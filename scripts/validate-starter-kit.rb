#!/usr/bin/env ruby

require "open3"
require "pathname"
require "tmpdir"
require "digest"
require "fileutils"

ROOT = Pathname.new(File.expand_path("..", __dir__))
Dir.chdir(ROOT)

errors = []
add = ->(message) { errors << message }

required = %w[
  AGENTS.md
  CLAUDE.md
  readme.md
  setup/START-HERE.md
  setup/AGENT-SETUP.md
  setup/ONBOARDING.md
  setup/MIGRATE-V1.md
  scripts/create-vault.rb
  scripts/add-project.rb
  scripts/add-business.rb
  os/AGENTS.md
  os/me.md
  os/vault-map.md
  os/retrieval.md
  os/knowledge-map.md
  os/recovery.md
  os/integrations.md
  os/skill-map.md
  os/validate-starter-os.rb
  life/AGENTS.md
  life/now.md
  life/knowledge-map.md
  life/projects/readme.md
  life/wiki/owner.md
  life/records/readme.md
  life/records/decisions.md
]
required.each { |path| add.call("missing required source path: #{path}") unless File.exist?(path) }

forbidden = %w[
  starter-os-migration-guide.html
  biz/business-model
  life/00_inbox
  life/areas
  life/archive
  life/records/sessions
  os/agent-rules.md
  setup/PROMPT-01-CREATE-MY-OS.md
  setup/PROMPT-02-FIRST-WORKING-SESSION.md
  setup/PROMPT-03-MIGRATE-OLD-VAULT.md
]
forbidden.each { |path| add.call("obsolete source path remains: #{path}") if File.exist?(path) }

setup_files = Dir.glob("setup/*").select { |path| File.file?(path) }.sort
expected_setup = %w[setup/AGENT-SETUP.md setup/MIGRATE-V1.md setup/ONBOARDING.md setup/START-HERE.md]
add.call("setup is not the four-file contract: #{setup_files.join(', ')}") unless setup_files == expected_setup

migration = File.file?("setup/MIGRATE-V1.md") ? File.read("setup/MIGRATE-V1.md") : ""
{
  "read-only inventory" => /Inventory.*without changing/i,
  "exact plan" => /exact keep, move, combine, create, and remove plan/i,
  "approval gate" => /Wait for approval/i,
  "separate preview" => /separate 2\.0 preview/i,
  "separate cutover" => /Cutover, deletion, repository publication, and automation changes are separate approvals/i
}.each { |label, pattern| add.call("migration contract missing #{label}") unless migration.match?(pattern) }
add.call("migration contains forbidden no-approval instruction") if migration.match?(/do not ask for approval/i)

source_files = Dir.glob("**/*", File::FNM_DOTMATCH).select do |path|
  File.file?(path) && !path.start_with?(".git/")
end

secret_shapes = {
  "private key" => /-----BEGIN (?:RSA |EC |OPENSSH )?PRIVATE KEY-----/,
  "GitHub token" => /(?:ghp|gho|github_pat)_[A-Za-z0-9_]{20,}/,
  "OpenAI key" => /sk-[A-Za-z0-9_-]{20,}/,
  "AWS key" => /AKIA[0-9A-Z]{16}/
}
source_files.each do |path|
  text = File.binread(path).force_encoding(Encoding::UTF_8)
  next unless text.valid_encoding?
  secret_shapes.each { |label, pattern| add.call("#{path} contains #{label}-shaped text") if text.match?(pattern) }
end

source_files.select { |path| path.end_with?(".md") }.each do |path|
  File.read(path).scan(/\[[^\]]+\]\(([^)]+)\)/).flatten.each do |target|
    clean = target.split("#", 2).first
    next if clean.empty? || clean.match?(/\A(?:https?:|mailto:)/)
    resolved = File.expand_path(clean, File.dirname(path))
    add.call("#{path} links to missing #{target}") unless File.exist?(resolved)
  end
end

Dir.glob("os/skills/*.md").each do |path|
  File.read(path).scan(/\[\[([a-z0-9-]+)\]\]/).flatten.each do |target|
    add.call("#{path} links to missing skill #{target}") unless File.file?("os/skills/#{target}.md")
  end
end

unless errors.empty?
  puts "FAIL Starter.OS 2 source: #{errors.length} issue#{errors.length == 1 ? '' : 's'}"
  errors.each { |message| puts "- #{message}" }
  exit 1
end

source_project_output, source_project_status = Open3.capture2e("ruby", "scripts/add-project.rb", "must-refuse")
add.call("project generator did not refuse the public source") if source_project_status.success? || File.exist?("life/projects/must-refuse")
source_business_output, source_business_status = Open3.capture2e("ruby", "scripts/add-business.rb", "must-refuse")
add.call("business generator did not refuse the public source") if source_business_status.success? || File.exist?("biz/must-refuse")

Dir.mktmpdir("starter-os-2-") do |tmp|
  vault = File.join(tmp, "NOVA.os")
  output, status = Open3.capture2e("ruby", "scripts/create-vault.rb", vault)
  add.call("clean install failed: #{output.strip}") unless status.success?

  if status.success?
    roots = Dir.children(vault).sort
    expected_roots = %w[AGENTS.md CLAUDE.md biz life os]
    add.call("generated roots differ: #{roots.join(', ')}") unless roots == expected_roots
    add.call("setup leaked into installed vault") if File.exist?(File.join(vault, "setup"))
    add.call("biz is not initially empty") unless Dir.children(File.join(vault, "biz")).empty?

    project_output, project_status = Open3.capture2e("ruby", "os/scripts/add-project.rb", "health", chdir: vault)
    add.call("project generator failed: #{project_output.strip}") unless project_status.success?
    add.call("project generator created extra foundation files") unless Dir.glob(File.join(vault, "life/projects/health/*")).map { |path| File.basename(path) } == ["health.md"]

    business_output, business_status = Open3.capture2e("ruby", "os/scripts/add-business.rb", "sample-studio", chdir: vault)
    add.call("business generator failed: #{business_output.strip}") unless business_status.success?

    validate_output, validate_status = Open3.capture2e("ruby", "os/validate-starter-os.rb", chdir: vault)
    add.call("installed validation failed:\n#{validate_output}") unless validate_status.success?

    refusal_output, refusal_status = Open3.capture2e("ruby", "scripts/create-vault.rb", vault)
    add.call("non-empty destination was not refused") if refusal_status.success? || !refusal_output.include?("not empty")

    legacy = File.join(tmp, "LEGACY.os")
    FileUtils.mkdir_p(File.join(legacy, "life", "00_inbox"))
    FileUtils.mkdir_p(File.join(legacy, "life", "areas", "health"))
    FileUtils.mkdir_p(File.join(legacy, "life", "archive"))
    File.write(File.join(legacy, "life", "00_inbox", "note.md"), "unique legacy note\n")
    File.write(File.join(legacy, "life", "areas", "health", "care.md"), "unique health record\n")
    File.write(File.join(legacy, "life", "archive", "history.md"), "unique archived history\n")
    before = Dir.glob(File.join(legacy, "**", "*"), File::FNM_DOTMATCH).select { |path| File.file?(path) }.to_h do |path|
      [path.delete_prefix("#{legacy}/"), Digest::SHA256.file(path).hexdigest]
    end

    preview = File.join(tmp, "PREVIEW.os")
    preview_output, preview_status = Open3.capture2e("ruby", "scripts/create-vault.rb", preview)
    add.call("migration preview generation failed: #{preview_output.strip}") unless preview_status.success?
    after = Dir.glob(File.join(legacy, "**", "*"), File::FNM_DOTMATCH).select { |path| File.file?(path) }.to_h do |path|
      [path.delete_prefix("#{legacy}/"), Digest::SHA256.file(path).hexdigest]
    end
    add.call("migration preview changed the legacy fixture") unless before == after
    add.call("migration preview was not separate from legacy") if preview == legacy || !File.directory?(preview)
  end
end

if errors.empty?
  puts "PASS Starter.OS 2: source contract, links, privacy, clean install, minimal project, business foundation, refusal, installed validation, and non-destructive v1 preview"
  exit 0
end

puts "FAIL Starter.OS 2: #{errors.length} issue#{errors.length == 1 ? '' : 's'}"
errors.each { |message| puts "- #{message}" }
exit 1
