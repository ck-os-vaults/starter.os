#!/usr/bin/env ruby

require "date"
require "open3"
require "pathname"
require "tmpdir"
require "yaml"

ROOT = Pathname.new(File.expand_path("..", __dir__))
Dir.chdir(ROOT)

errors = []
add_error = ->(message) { errors << message }

required = %w[
  AGENTS.md
  CLAUDE.md
  readme.md
  migration-v1.md
  setup/README.md
  setup/INSTALL.md
  setup/PROMPT-01-CREATE-MY-OS.md
  setup/PROMPT-02-FIRST-WORKING-SESSION.md
  setup/SETUP-STATUS.md
  setup/AGENT-RUNBOOK.md
  setup/ONBOARDING-INTERVIEW.md
  setup/OPERATOR-GUIDE.md
  scripts/create-vault.rb
  scripts/add-business.rb
  template/vault/AGENTS.md
  template/vault/CLAUDE.md
  template/vault/os/agent-rules.md
  template/vault/os/vault-map.md
  template/vault/os/validate-starter-os.rb
  template/vault/life/knowledge-map.md
  template/business/AGENTS.md
]
required.each { |file| add_error.call("missing required kit file: #{file}") unless File.exist?(file) }

prompt_files = %w[
  setup/PROMPT-01-CREATE-MY-OS.md
  setup/PROMPT-02-FIRST-WORKING-SESSION.md
]
prompt_files.each do |file|
  next unless File.file?(file)
  text = File.read(file)
  add_error.call("#{file}: missing Copy and paste label") unless text.match?(/^# Copy and paste/)
  add_error.call("#{file}: missing New User label") unless text.include?("**For: New User**")
  add_error.call("#{file}: expected exactly one prompt block") unless text.scan(/^```text$/).length == 1 && text.scan(/^```$/).length == 1
  add_error.call("#{file}: prompt file must not contain YAML frontmatter") if text.start_with?("---\n")
end

user_files = %w[setup/README.md setup/INSTALL.md]
agent_files = %w[setup/SETUP-STATUS.md setup/AGENT-RUNBOOK.md setup/ONBOARDING-INTERVIEW.md setup/OPERATOR-GUIDE.md]
user_files.each { |file| add_error.call("#{file}: missing New User label") unless File.read(file).include?("**For: New User**") }
agent_files.each { |file| add_error.call("#{file}: missing Agent label") unless File.read(file).match?(/\*\*For: Agent/) }

active_text_files = Dir.glob("**/*", File::FNM_DOTMATCH).select do |file|
  File.file?(file) && !file.start_with?(".git/", "archive/") && !file.include?("/.DS_Store")
end

secret_shapes = {
  "private key" => /-----BEGIN (?:RSA |EC |OPENSSH )?PRIVATE KEY-----/,
  "GitHub token" => /(?:ghp|gho|github_pat)_[A-Za-z0-9_]{20,}/,
  "OpenAI key" => /sk-[A-Za-z0-9_-]{20,}/,
  "Anthropic key" => /sk-ant-[A-Za-z0-9_-]{20,}/,
  "AWS key" => /AKIA[0-9A-Z]{16}/
}

privacy_terms = if File.file?(".starter-private-denylist")
  File.readlines(".starter-private-denylist", chomp: true).map(&:strip).reject { |line| line.empty? || line.start_with?("#") }
else
  []
end

active_text_files.each do |file|
  text = File.binread(file).force_encoding(Encoding::UTF_8)
  next unless text.valid_encoding?
  privacy_terms.each do |term|
    add_error.call("#{file}: contains a locally denied privacy term") if text.match?(/#{Regexp.escape(term)}/i)
  end
  secret_shapes.each do |label, pattern|
    add_error.call("#{file}: contains #{label}-shaped text") if text.match?(pattern)
  end
end

legacy_patterns = {
  "single-repo log route" => /(?<!life\/)`log\//,
  "old current-state path" => /`os\/now\.md`/,
  "old business container" => /(?<!biz\/)`business\//
}
generated_sources = Dir["template/**/*.{md,rb}"] + Dir["setup/*.md"]
generated_sources.each do |file|
  next if file.start_with?("archive/")
  next if file.end_with?("validate-starter-os.rb")
  text = File.read(file)
  legacy_patterns.each do |label, pattern|
    add_error.call("#{file}: contains #{label}") if text.match?(pattern)
  end
end

unless errors.empty?
  puts "FAIL starter kit: #{errors.length} source issue#{errors.length == 1 ? '' : 's'}"
  errors.each { |message| puts "- #{message}" }
  exit 1
end

Dir.mktmpdir("starter-os-kit-") do |tmp|
  vault = File.join(tmp, "owner-os")
  create_output, create_status = Open3.capture2e("ruby", "scripts/create-vault.rb", vault)
  unless create_status.success?
    add_error.call("generated-vault creation failed: #{create_output.strip}")
    next
  end

  business_output, business_status = Open3.capture2e("ruby", "setup/add-business.rb", "sample-business", chdir: vault)
  unless business_status.success?
    add_error.call("business creation failed: #{business_output.strip}")
    next
  end

  validation_output, validation_status = Open3.capture2e("ruby", "os/validate-starter-os.rb", chdir: vault)
  add_error.call("generated-vault validation failed:\n#{validation_output}") unless validation_status.success?

  add_error.call("generated vault root became a Git repository") if File.exist?(File.join(vault, ".git"))
  add_error.call("generated biz container became a Git repository") if File.exist?(File.join(vault, "biz", ".git"))
end

if errors.empty?
  puts "PASS starter kit: source privacy clean; generated vault, business template, and validator passed."
  exit 0
end

puts "FAIL starter kit: #{errors.length} issue#{errors.length == 1 ? '' : 's'}"
errors.each { |message| puts "- #{message}" }
exit 1
