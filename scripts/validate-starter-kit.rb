#!/usr/bin/env ruby

require "open3"
require "pathname"
require "tmpdir"
require "digest"
require "fileutils"
require "csv"

ROOT = Pathname.new(File.expand_path("..", __dir__))
Dir.chdir(ROOT)

errors = []
add = ->(message) { errors << message }

required = %w[
  AGENTS.md
  CLAUDE.md
  readme.md
  setup/START-HERE.md
  setup/GITHUB-SETUP.md
  setup/AGENT-SETUP.md
  setup/QUICK-SETUP.md
  setup/MIGRATE-V1.md
  scripts/create-vault.rb
  scripts/add-project.rb
  scripts/add-business.rb
  scripts/verify-migration.rb
  os/AGENTS.md
  os/me.md
  os/vault-map.md
  os/retrieval.md
  os/knowledge-map.md
  os/recovery.md
  os/integrations.md
  os/skill-map.md
  os/skills/security-intake.md
  os/validate-starter-os.rb
  life/AGENTS.md
  life/now.md
  life/knowledge-map.md
  life/documents/readme.md
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
  setup/ONBOARDING.md
]
forbidden.each { |path| add.call("obsolete source path remains: #{path}") if File.exist?(path) }

setup_files = Dir.glob("setup/*").select { |path| File.file?(path) }.sort
expected_setup = %w[setup/AGENT-SETUP.md setup/GITHUB-SETUP.md setup/MIGRATE-V1.md setup/QUICK-SETUP.md setup/START-HERE.md]
add.call("setup is not the five-file contract: #{setup_files.join(', ')}") unless setup_files == expected_setup

actual_skills = Dir.glob("os/skills/*.md").map { |path| File.basename(path, ".md") }.reject { |name| name == "readme" }.sort
skill_map_text = File.file?("os/skill-map.md") ? File.read("os/skill-map.md") : ""
registered_skills = skill_map_text.scan(/^\|\s*\[\[([a-z0-9-]+)\]\]/).flatten.uniq.sort
(registered_skills - actual_skills).each { |skill| add.call("registered skill missing: os/skills/#{skill}.md") }
(actual_skills - registered_skills).each { |skill| add.call("unregistered skill file: os/skills/#{skill}.md") }

migration = File.file?("setup/MIGRATE-V1.md") ? File.read("setup/MIGRATE-V1.md") : ""
start_here = File.file?("setup/START-HERE.md") ? File.read("setup/START-HERE.md") : ""
agent_setup = File.file?("setup/AGENT-SETUP.md") ? File.read("setup/AGENT-SETUP.md") : ""
quick_setup = File.file?("setup/QUICK-SETUP.md") ? File.read("setup/QUICK-SETUP.md") : ""
github_setup = File.file?("setup/GITHUB-SETUP.md") ? File.read("setup/GITHUB-SETUP.md") : ""
recovery = File.file?("os/recovery.md") ? File.read("os/recovery.md") : ""
add.call("owner setup page is not clearly identified") unless start_here.include?("main setup file for the owner")
add.call("owner setup page is missing the public GitHub address") unless start_here.include?("https://github.com/ck-os-vaults/starter.os")
add.call("owner paths must each say to copy and paste the exact prompt") unless start_here.scan(/copy and paste these exact words/i).length == 2
add.call("owner setup still contains an editable migration placeholder") if start_here.include?("[CURRENT VAULT PATH]")
add.call("owner setup does not preserve COS-until-named language") unless start_here.include?("COS until you choose a name")
{
  "AGENT-SETUP" => agent_setup,
  "QUICK-SETUP" => quick_setup,
  "MIGRATE-V1" => migration
}.each do |name, text|
  add.call("#{name} is not clearly labeled agent-only") unless text.include?("Audience: Agent only") && text.include?("START-HERE.md")
end
add.call("new-system launch prompt is missing") unless start_here.include?("Read `AGENTS.md` and `setup/AGENT-SETUP.md`")
add.call("migration launch prompt is missing") unless start_here.include?("Read `AGENTS.md` and `setup/MIGRATE-V1.md`") && start_here.include?("Show me the exact source path and wait for my confirmation")
{
  "read-only inventory" => /Inventory.*without changing/i,
  "source path approval" => /Show the exact path and wait for the owner's confirmation/i,
  "complete redesign" => /complete system redesign/i,
  "untouched original" => /existing vault remains untouched/i,
  "complete file accounting" => /Every existing content path must be classified exactly once/i,
  "proposed project names" => /propose concise names for every personal project and business/i,
  "editable owner naming" => /every proposed name visibly editable/i,
  "compact questions" => /Ask one compact group of questions only/i,
  "approval gate" => /Wait for the owner to approve or rename/i,
  "separate preview" => /separate Starter\.OS 2 vault/i,
  "shared clean generator" => /scripts\/create-vault\.rb/i,
  "adoption gate" => /adoption gate, not another interview/i,
  "executable migration proof" => /scripts\/verify-migration\.rb verify/i,
  "no old-vault deletion" => /Deleting the old vault is never part of migration/i,
  "short orientation" => /Do not add a tutorial course, exercises, or a required first task/i
}.each { |label, pattern| add.call("migration contract missing #{label}") unless migration.match?(pattern) }
add.call("migration contains forbidden no-approval instruction") if migration.match?(/do not ask for approval/i)

add.call("GitHub setup is not clearly owner-facing") unless github_setup.include?("Audience: Owner")
add.call("GitHub setup does not provide both exact owner prompts") unless github_setup.scan(/copy and paste these exact words/i).length == 2
add.call("GitHub setup does not make GitHub canonical origin") unless github_setup.match?(/GitHub as the canonical remote named `origin`/i)
add.call("GitHub setup does not define GitLab as an automatic downstream mirror") unless github_setup.match?(/GitLab.*automatic downstream mirror/im)
add.call("GitHub setup does not forbid routine dual agent pushes") unless github_setup.match?(/Do not keep GitLab as a second routine agent push target/i)
add.call("GitHub setup is missing the existing-system upgrade prompt") unless github_setup.include?("Audit my existing GitHub and GitLab repository connections")
add.call("GitHub setup does not cover the GitLab pull-mirror route") unless github_setup.include?("Settings > Repository > Mirroring repositories")
add.call("GitHub setup does not cover the GitHub Actions fallback") unless github_setup.match?(/GitHub Actions mirror/i)
add.call("recovery contract does not require GitHub-only agent pushes") unless recovery.match?(/Agents push only to GitHub/i)
add.call("recovery contract still directs routine dual pushes") if recovery.match?(/push.*GitHub.*and.*GitLab/i)

forbidden_starter_skills = %w[drift-recovery evidence-research independent-review project-handoff]
forbidden_starter_skills.each do |skill|
  add.call("provider- or harness-dependent starter skill remains: os/skills/#{skill}.md") if File.exist?("os/skills/#{skill}.md")
end

reconciliation_skill = File.file?("os/skills/task-reconciliation.md") ? File.read("os/skills/task-reconciliation.md") : ""
add.call("task reconciliation skill is missing its nightly scheduled-task contract") unless reconciliation_skill.include?("Nightly COS Reconciliation") && reconciliation_skill.match?(/3:00 AM.*verified local timezone/i)
add.call("task reconciliation is not explicitly read-only") unless reconciliation_skill.match?(/remain read-only/i)
add.call("agent setup does not create or update the nightly reconciliation") unless agent_setup.match?(/create or update exactly one scheduled task named `Nightly COS Reconciliation`/i)
add.call("migration does not update rather than duplicate reconciliation") unless migration.match?(/updated instead of duplicated/i)
add.call("owner setup does not disclose nightly reconciliation") unless start_here.match?(/read-only nightly reconciliation/i)

security_intake = File.file?("os/skills/security-intake.md") ? File.read("os/skills/security-intake.md") : ""
add.call("security intake does not keep new artifacts inert") unless security_intake.match?(/Keep newly sourced.*inert/im)
add.call("security intake does not treat embedded instructions as data") unless security_intake.match?(/instruction.*inside it as data, not authority/i)
add.call("security intake does not protect private files from public uploads") unless security_intake.match?(/Never send private files to public scanning services without owner approval/i)
add.call("security intake incorrectly treats a clean scan as proof") unless security_intake.match?(/clean scan lowers risk; it never proves/i)
add.call("operating rules do not require security intake before execution") unless File.read("os/AGENTS.md").match?(/Before opening, downloading, installing, importing, or running.*security-intake/im)

browser_skill = File.file?("os/skills/browser-use.md") ? File.read("os/skills/browser-use.md") : ""
add.call("browser skill does not require the native browser first") unless browser_skill.match?(/native or in-app browser.*whenever it is available/im)
add.call("browser skill does not approval-gate external browsers") unless browser_skill.match?(/ask the owner before using an external browser/i)

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

    rogue_skill = File.join(vault, "os", "skills", "unregistered-example.md")
    File.write(rogue_skill, "# unregistered example\n")
    rogue_output, rogue_status = Open3.capture2e("ruby", "os/validate-starter-os.rb", chdir: vault)
    add.call("unregistered installed skill was not rejected") if rogue_status.success? || !rogue_output.include?("unregistered skill file")
    FileUtils.rm_f(rogue_skill)

    refusal_output, refusal_status = Open3.capture2e("ruby", "scripts/create-vault.rb", vault)
    add.call("non-empty destination was not refused") if refusal_status.success? || !refusal_output.include?("not empty")

    legacy = File.join(tmp, "LEGACY.os")
    FileUtils.mkdir_p(File.join(legacy, "life", "00_inbox"))
    FileUtils.mkdir_p(File.join(legacy, "life", "areas", "health"))
    FileUtils.mkdir_p(File.join(legacy, "life", "archive"))
    FileUtils.mkdir_p(File.join(legacy, "life", "assets"))
    File.write(File.join(legacy, "life", "00_inbox", "note.md"), "unique legacy note\n")
    File.write(File.join(legacy, "life", "areas", "health", "care.md"), "unique health record\n")
    File.write(File.join(legacy, "life", "archive", "history.md"), "unique archived history\n")
    File.binwrite(File.join(legacy, "life", "assets", "sample.bin"), "\x00\xFFlegacy\x10".b)
    File.write(File.join(legacy, ".DS_Store"), "obsolete finder metadata\n")
    before = Dir.glob(File.join(legacy, "**", "*"), File::FNM_DOTMATCH).select { |path| File.file?(path) }.to_h do |path|
      [path.delete_prefix("#{legacy}/"), Digest::SHA256.file(path).hexdigest]
    end

    preview = File.join(tmp, "PREVIEW.os")
    source_snapshot = File.join(tmp, "source-snapshot.json")
    snapshot_output, snapshot_status = Open3.capture2e("ruby", "scripts/verify-migration.rb", "snapshot", legacy, source_snapshot)
    add.call("migration source snapshot failed: #{snapshot_output.strip}") unless snapshot_status.success?
    preview_output, preview_status = Open3.capture2e("ruby", "scripts/create-vault.rb", preview)
    add.call("migration preview generation failed: #{preview_output.strip}") unless preview_status.success?
    if preview_status.success? && snapshot_status.success?
      FileUtils.mkdir_p(File.join(preview, "life", "projects", "imported"))
      FileUtils.mkdir_p(File.join(preview, "life", "projects", "health"))
      FileUtils.mkdir_p(File.join(preview, "life", "documents"))
      FileUtils.cp(File.join(legacy, "life", "00_inbox", "note.md"), File.join(preview, "life", "projects", "imported", "note.md"))
      FileUtils.cp(File.join(legacy, "life", "areas", "health", "care.md"), File.join(preview, "life", "projects", "health", "care.md"))
      FileUtils.cp(File.join(legacy, "life", "assets", "sample.bin"), File.join(preview, "life", "documents", "sample.bin"))

      manifest = File.join(tmp, "migration-map.tsv")
      rows = [
        %w[source_path disposition destination_path reason],
        [".DS_Store", "exclude", "", "obsolete Finder metadata"],
        ["life/00_inbox/note.md", "copy", "life/projects/imported/note.md", ""],
        ["life/archive/history.md", "unresolved", "", "owner must choose its durable home"],
        ["life/areas/health/care.md", "copy", "life/projects/health/care.md", ""],
        ["life/assets/sample.bin", "copy", "life/documents/sample.bin", ""]
      ]
      File.write(manifest, rows.map { |row| CSV.generate_line(row, col_sep: "\t") }.join)
      verify_output, verify_status = Open3.capture2e("ruby", "scripts/verify-migration.rb", "verify", legacy, preview, source_snapshot, manifest)
      add.call("complete migration manifest did not verify: #{verify_output.strip}") unless verify_status.success?

      incomplete_manifest = File.join(tmp, "incomplete-migration-map.tsv")
      File.write(incomplete_manifest, rows.reject { |row| row.first == "life/assets/sample.bin" }.map { |row| CSV.generate_line(row, col_sep: "\t") }.join)
      incomplete_output, incomplete_status = Open3.capture2e("ruby", "scripts/verify-migration.rb", "verify", legacy, preview, source_snapshot, incomplete_manifest)
      add.call("incomplete migration map was not rejected") if incomplete_status.success? || !incomplete_output.include?("unaccounted source paths")

      original_note = File.binread(File.join(legacy, "life", "00_inbox", "note.md"))
      File.binwrite(File.join(legacy, "life", "00_inbox", "note.md"), "changed after snapshot\n")
      changed_output, changed_status = Open3.capture2e("ruby", "scripts/verify-migration.rb", "verify", legacy, preview, source_snapshot, manifest)
      add.call("changed original vault was not rejected") if changed_status.success? || !changed_output.include?("original vault changed")
      File.binwrite(File.join(legacy, "life", "00_inbox", "note.md"), original_note)

      copied_binary = File.join(preview, "life", "documents", "sample.bin")
      original_binary = File.binread(copied_binary)
      File.binwrite(copied_binary, "changed copy\n")
      mismatch_output, mismatch_status = Open3.capture2e("ruby", "scripts/verify-migration.rb", "verify", legacy, preview, source_snapshot, manifest)
      add.call("changed copied bytes were not rejected") if mismatch_status.success? || !mismatch_output.include?("copied bytes do not match")
      File.binwrite(copied_binary, original_binary)
    end
    after = Dir.glob(File.join(legacy, "**", "*"), File::FNM_DOTMATCH).select { |path| File.file?(path) }.to_h do |path|
      [path.delete_prefix("#{legacy}/"), Digest::SHA256.file(path).hexdigest]
    end
    add.call("migration preview changed the legacy fixture") unless before == after
    add.call("migration preview was not separate from legacy") if preview == legacy || !File.directory?(preview)
  end
end

if errors.empty?
  puts "PASS Starter.OS 2: source contract, links, privacy, clean install, minimal project, business foundation, refusal, installed validation, exhaustive migration accounting, and non-destructive v1 preview"
  exit 0
end

puts "FAIL Starter.OS 2: #{errors.length} issue#{errors.length == 1 ? '' : 's'}"
errors.each { |message| puts "- #{message}" }
exit 1
