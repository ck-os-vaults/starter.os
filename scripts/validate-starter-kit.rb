#!/usr/bin/env ruby

require "open3"
require "pathname"
require "tmpdir"

ROOT = Pathname.new(File.expand_path("..", __dir__))
Dir.chdir(ROOT)

errors = []
add_error = ->(message) { errors << message }

required = %w[
  AGENTS.md
  CLAUDE.md
  readme.md
  biz
  life/AGENTS.md
  life/knowledge-map.md
  os/AGENTS.md
  os/agent-rules.md
  os/vault-map.md
  os/validate-starter-os.rb
  setup/README.md
  setup/INSTALL.md
  setup/PROMPT-01-CREATE-MY-OS.md
  setup/PROMPT-02-FIRST-WORKING-SESSION.md
  setup/SETUP-STATUS.md
  setup/AGENT-RUNBOOK.md
  setup/ONBOARDING-INTERVIEW.md
  setup/OPERATOR-GUIDE.md
  setup/business-template/AGENTS.md
  scripts/create-vault.rb
  scripts/add-business.rb
]
required.each { |file| add_error.call("missing required source path: #{file}") unless File.exist?(file) }

%w[template migration-v1.md].each do |path|
  add_error.call("obsolete source path remains: #{path}") if File.exist?(path)
end
%w[BIZ LIFE OS].each do |path|
  add_error.call("obsolete uppercase source path remains: #{path}") if Dir.children(".").include?(path)
end

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

first_prompt = File.file?(prompt_files.first) ? File.read(prompt_files.first) : ""
add_error.call("#{prompt_files.first}: must ask what replaces STARTER in STARTER.os") unless first_prompt.match?(/replace STARTER.*STARTER\.os/i)

user_files = %w[setup/README.md setup/INSTALL.md]
agent_files = %w[setup/SETUP-STATUS.md setup/AGENT-RUNBOOK.md setup/ONBOARDING-INTERVIEW.md setup/OPERATOR-GUIDE.md]
user_files.each { |file| add_error.call("#{file}: missing New User label") unless File.file?(file) && File.read(file).include?("**For: New User**") }
agent_files.each { |file| add_error.call("#{file}: missing Agent label") unless File.file?(file) && File.read(file).match?(/\*\*For: Agent/) }

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

route_sources = Dir["{os,life,setup}/**/*.{md,rb}"] + %w[AGENTS.md CLAUDE.md readme.md scripts/create-vault.rb scripts/add-business.rb]
route_sources.each do |file|
  next unless File.file?(file)
  text = File.read(file)
  add_error.call("#{file}: contains obsolete template/vault route") if text.include?("template/vault")
  add_error.call("#{file}: contains uppercase OS path") if text.match?(%r{(?<![A-Za-z])OS/})
  add_error.call("#{file}: contains uppercase LIFE path") if text.match?(%r{(?<![A-Za-z])LIFE/})
  add_error.call("#{file}: contains uppercase BIZ path") if text.match?(%r{(?<![A-Za-z])BIZ/})
end

unless errors.empty?
  puts "FAIL starter kit: #{errors.length} source issue#{errors.length == 1 ? '' : 's'}"
  errors.each { |message| puts "- #{message}" }
  exit 1
end

Dir.mktmpdir("starter-os-kit-") do |tmp|
  vault = File.join(tmp, "NOVA.os")
  create_output, create_status = Open3.capture2e("ruby", "scripts/create-vault.rb", vault)
  unless create_status.success?
    add_error.call("vault creation failed: #{create_output.strip}")
    next
  end

  expected_roots = %w[AGENTS.md CLAUDE.md biz life os setup]
  actual_roots = Dir.children(vault).sort
  add_error.call("generated root does not match biz/life/os structure: #{actual_roots.join(', ')}") unless actual_roots == expected_roots
  add_error.call("custom root name was not preserved") unless File.basename(vault) == "NOVA.os"

  business_output, business_status = Open3.capture2e("ruby", "setup/add-business.rb", "sample-business", chdir: vault)
  add_error.call("business creation failed: #{business_output.strip}") unless business_status.success?

  validation_output, validation_status = Open3.capture2e("ruby", "os/validate-starter-os.rb", chdir: vault)
  add_error.call("installed-vault validation failed:\n#{validation_output}") unless validation_status.success?

  add_error.call("generated vault root became a Git repository") if File.exist?(File.join(vault, ".git"))
  add_error.call("generated biz container became a Git repository") if File.exist?(File.join(vault, "biz", ".git"))

  refusal_output, refusal_status = Open3.capture2e("ruby", "scripts/create-vault.rb", vault)
  add_error.call("non-empty destination was not refused") if refusal_status.success? || !refusal_output.include?("not empty")
end

if errors.empty?
  puts "PASS starter kit: direct biz/life/os source, custom root naming, privacy, creation, business template, refusal, and installed validator passed."
  exit 0
end

puts "FAIL starter kit: #{errors.length} issue#{errors.length == 1 ? '' : 's'}"
errors.each { |message| puts "- #{message}" }
exit 1
