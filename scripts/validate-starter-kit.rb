#!/usr/bin/env ruby

require "csv"
require "digest"
require "fileutils"
require "find"
require "json"
require "open3"
require "pathname"
require "tmpdir"

ROOT = Pathname.new(File.expand_path("..", __dir__))
Dir.chdir(ROOT)

errors = []
add = ->(message) { errors << message }

def capture(*command, chdir: nil)
  chdir ? Open3.capture2e(*command, chdir: chdir) : Open3.capture2e(*command)
end

def tree_digests(root)
  files = {}
  Find.find(root.to_s) do |absolute|
    relative = Pathname.new(absolute).relative_path_from(root).to_s
    if File.symlink?(absolute)
      files[relative] = "symlink:#{Digest::SHA256.hexdigest(File.readlink(absolute))}"
      next
    end
    if File.directory?(absolute)
      relative == ".git" ? Find.prune : next
    end
    next unless File.file?(absolute)
    files[relative] = Digest::SHA256.file(absolute).hexdigest
  end
  files
end

source_before = tree_digests(ROOT)
source_before.keys.select { |path| ROOT.join(path).symlink? }.each do |path|
  add.call("public source contains unsupported symbolic link: #{path}")
end

required = %w[
  AGENTS.md CLAUDE.md readme.md CHANGELOG.md LICENSE LICENSE-CODE LICENSE-CONTENT
  release-manifest.json
  setup/START-HERE.md setup/AGENT-SETUP.md setup/QUICK-SETUP.md
  setup/GIT-SETUP.md setup/MIGRATE.md setup/UPDATE.md
  scripts/build-release-manifest.rb scripts/create-vault.rb
  scripts/update-vault.rb scripts/add-project.rb scripts/add-business.rb
  scripts/verify-migration.rb
  os/AGENTS.md os/manual.md os/license.md os/me.md os/vault-map.md
  os/retrieval.md os/knowledge-map.md os/recovery.md os/integrations.md
  os/skill-map.md os/skills/drift-recovery.md os/skills/security-intake.md
  os/skills/security-sweep.md os/skills/daily-brief.md os/skills/news-report.md
  os/skills/task-reconciliation.md
  os/validate-starter-os.rb
  life/AGENTS.md life/now.md life/knowledge-map.md life/documents/readme.md
  life/projects/readme.md life/wiki/owner.md life/records/readme.md
  life/records/decisions.md
]
required.each { |path| add.call("missing required source path: #{path}") unless File.exist?(path) }

forbidden = %w[
  RELEASE-NOTES.md setup/GITHUB-SETUP.md setup/MIGRATE-V1.md starter-os-migration-guide.html
  biz/business-model life/00_inbox life/areas life/archive
  life/records/sessions os/agent-rules.md setup/ONBOARDING.md
]
forbidden.each { |path| add.call("obsolete source path remains: #{path}") if File.exist?(path) }

setup_files = Dir.glob("setup/*").select { |path| File.file?(path) }.sort
expected_setup = %w[
  setup/AGENT-SETUP.md setup/GIT-SETUP.md setup/MIGRATE.md
  setup/QUICK-SETUP.md setup/START-HERE.md setup/UPDATE.md
]
add.call("setup is not the six-file guided contract: #{setup_files.join(', ')}") unless setup_files == expected_setup

start_here = File.file?("setup/START-HERE.md") ? File.read("setup/START-HERE.md") : ""
root_agents = File.file?("AGENTS.md") ? File.read("AGENTS.md") : ""
readme = File.file?("readme.md") ? File.read("readme.md") : ""
agent_setup = File.file?("setup/AGENT-SETUP.md") ? File.read("setup/AGENT-SETUP.md") : ""
quick_setup = File.file?("setup/QUICK-SETUP.md") ? File.read("setup/QUICK-SETUP.md") : ""
git_setup = File.file?("setup/GIT-SETUP.md") ? File.read("setup/GIT-SETUP.md") : ""
migration = File.file?("setup/MIGRATE.md") ? File.read("setup/MIGRATE.md") : ""
update = File.file?("setup/UPDATE.md") ? File.read("setup/UPDATE.md") : ""
manual = File.file?("os/manual.md") ? File.read("os/manual.md") : ""

public_url = "https://github.com/ck-os-vaults/starter-os-public"
add.call("README does not lead with the one-link start") unless readme.include?(public_url) && readme.match?(/whole normal starting prompt/i)
add.call("owner start does not use the repository link as the normal prompt") unless start_here.include?(public_url) && start_here.match?(/whole normal starting prompt/i)
add.call("owner start does not state required agent capabilities") unless start_here.match?(/read repository instructions/i) && start_here.match?(/private working repository/i)
add.call("root AGENTS does not recognize the link-only handoff") unless root_agents.match?(/provides only the public Starter\.OS repository link/i)
%w[setup migration update].each { |route| add.call("root AGENTS is missing #{route} routing") unless root_agents.match?(/#{route}/i) }

{
  "AGENT-SETUP" => agent_setup,
  "QUICK-SETUP" => quick_setup,
  "GIT-SETUP" => git_setup,
  "MIGRATE" => migration,
  "UPDATE" => update
}.each do |name, text|
  add.call("#{name} is not clearly agent-only") unless text.include?("Audience: Agent only")
end

[agent_setup, migration, update].each_with_index do |text, index|
  route = %w[setup migration update][index]
  add.call("#{route} does not discover Git before mutation") unless text.match?(/discover Git|Git discovery/i)
  add.call("#{route} does not route secondary Git as an automatic mirror") unless text.match?(/automatic mirror/i)
  add.call("#{route} does not offer compatible recurring workflows") unless text.match?(/compatible.*recurring|recurring.*compatible/im)
  add.call("#{route} does not preserve owner choice") unless text.match?(/declin|defer/i)
end
add.call("shared setup does not support adopt, decline, and defer") unless %w[adopt decline defer].all? { |word| quick_setup.match?(/#{word}/i) }
add.call("shared setup does not prefer persistent destinations") unless quick_setup.match?(/persistent home-base destination/i) && quick_setup.match?(/new task per run/i)
add.call("Git setup does not enforce one primary") unless git_setup.match?(/one primary/i)
add.call("Git setup does not forbid routine second pushes") unless git_setup.match?(/Do not keep a second routine agent push target/i)
add.call("Git setup does not make GitHub the normal guided primary") unless git_setup.match?(/GitHub.*normal guided private primary/im)
add.call("Git setup does not require a private hosted primary for completed protection") unless git_setup.match?(/private hosted primary/im) && git_setup.match?(/do not call the standard setup complete/im)
add.call("Git setup does not warn about local-only device loss") unless git_setup.match?(/local-only Git.*device loss/im)
add.call("shared setup still forces an execution label") if quick_setup.match?(/local, cloud, on-demand, or hybrid execution needs/i)
add.call("shared setup does not inventory execution capabilities") unless %w[repository persistence scheduler source-access delivery Git-verification].all? { |word| quick_setup.match?(/#{word}/i) }
add.call("migration is not preserve-first") unless migration.match?(/preserve-first/i)
%w[preserve copy transform merge exclude unresolved].each do |disposition|
  add.call("migration is missing #{disposition} disposition") unless migration.match?(/\b#{disposition}\b/i)
end
add.call("update lacks deterministic plan and apply commands") unless update.include?("update-vault.rb plan") && update.include?("update-vault.rb apply")
add.call("update lacks keep, replace, fork, and defer choices") unless %w[keep replace fork defer].all? { |word| update.match?(/#{word}/i) }

add.call("manual title is missing") unless manual.include?("# How Starter.OS works")
%w[Chief Git Skills automations agents Migration Update Validation recovery].each do |topic|
  add.call("manual does not explain #{topic}") unless manual.match?(/#{topic}/i)
end
add.call("manual is not protected from ordinary agent edits") unless manual.match?(/may not rewrite/i) && manual.match?(/protected/i)
add.call("manual does not explain an owner fork") unless manual.match?(/owner-owned fork/i)

skill_map_text = File.file?("os/skill-map.md") ? File.read("os/skill-map.md") : ""
actual_skills = Dir.glob("os/skills/*.md").map { |path| File.basename(path, ".md") }.reject { |name| name == "readme" }.sort
registered_skills = skill_map_text.scan(/^\|\s*\[\[([a-z0-9-]+)\]\]/).flatten.uniq.sort
(registered_skills - actual_skills).each { |skill| add.call("registered skill missing: os/skills/#{skill}.md") }
(actual_skills - registered_skills).each { |skill| add.call("unregistered skill file: os/skills/#{skill}.md") }
["core portable", "optional portable", "optional scheduled", "harness-specific", "CK-only", "incomplete"].each do |category|
  add.call("skill audit is missing category: #{category}") unless skill_map_text.match?(/#{category}/i)
end

reconciliation = File.file?("os/skills/task-reconciliation.md") ? File.read("os/skills/task-reconciliation.md") : ""
security_sweep = File.file?("os/skills/security-sweep.md") ? File.read("os/skills/security-sweep.md") : ""
daily_brief = File.file?("os/skills/daily-brief.md") ? File.read("os/skills/daily-brief.md") : ""
news_report = File.file?("os/skills/news-report.md") ? File.read("os/skills/news-report.md") : ""
add.call("Morning Brief recipe is missing or forced") unless daily_brief.include?("Morning Brief") && daily_brief.match?(/When the owner accepts/i)
add.call("News Report recipe is missing citations or owner-selected sources") unless news_report.include?("News Report") && news_report.match?(/owner-selected/i) && news_report.match?(/Cite|citation/i)
add.call("reconciliation is not an internal input by default") unless reconciliation.match?(/not a separate user-facing report by default/i) && reconciliation.match?(/Morning Brief/i)
add.call("security recipe is missing or forced") unless security_sweep.include?("System Security Watch") && security_sweep.match?(/When the owner accepts/i)
add.call("security recipe is not read-only and fail-closed") unless security_sweep.match?(/remain read-only/i) && security_sweep.match?(/incomplete coverage/i)
recurring_docs = [agent_setup, quick_setup, migration, update, daily_brief, news_report, reconciliation, security_sweep].join("\n")
add.call("public recurring-workflow docs still require a specific model") if recurring_docs.match?(/GPT-\d|Claude \d|Gemini \d/i)

add.call("code license is not MIT") unless File.read("LICENSE-CODE").include?("MIT License") && File.read("LICENSE-CODE").include?("Copyright (c) 2026 CK")
add.call("content license is not CC BY 4.0") unless File.read("LICENSE-CONTENT").match?(/Creative\s+Commons\s+Attribution\s+4\.0\s+International/m)
add.call("license boundary omits source marks") unless File.read("LICENSE").match?(/Name and marks/i)
if File.file?("CHANGELOG.md")
  changelog = File.read("CHANGELOG.md")
  add.call("changelog does not identify Unreleased and 2.0.0") unless changelog.include?("## [Unreleased]") && changelog.include?("## [2.0.0] - 2026-08-30")
  add.call("changelog does not define semantic versioning") unless changelog.match?(/semantic versioning/i) && changelog.match?(/major versions/i) && changelog.match?(/minor versions/i) && changelog.match?(/patch versions/i)
  add.call("changelog omits owner-facing release guidance") unless %w[Compatibility limitations Updating Rollback].all? { |word| changelog.match?(/#{word}/i) }
  add.call("changelog omits security history") unless changelog.match?(/^### Security$/)
end

if File.file?("release-manifest.json")
  begin
    manifest = JSON.parse(File.read("release-manifest.json"))
    add.call("unsupported release manifest") unless manifest["format"] == 1 && manifest["product"] == "Starter.OS" && manifest["version"] == "2.1.0"
    add.call("release manifest does not support 2.0 and unversioned updates") unless %w[unversioned-legacy 2.0.0 2.1.0].all? { |version| manifest.fetch("supported_updates", []).include?(version) }
    artifacts = manifest.fetch("artifacts")
    paths = artifacts.map { |artifact| artifact.fetch("path") }
    add.call("release manifest has duplicate installed paths") unless paths.uniq.length == paths.length

    artifacts.each do |artifact|
      source = artifact.fetch("source")
      source_path = ROOT.join(source)
      add.call("manifest source missing: #{source}") unless source_path.file?
      if source_path.file? && Digest::SHA256.file(source_path).hexdigest != artifact.fetch("sha256")
        add.call("manifest checksum mismatch: #{source}")
      end
      add.call("invalid ownership for #{artifact['path']}") unless %w[managed owner-owned].include?(artifact["ownership"])
    end

    expected_installed = Dir.glob(ROOT.join("{os,life}", "**", "*").to_s, File::FNM_DOTMATCH)
      .select { |path| File.file?(path) }
      .map { |path| Pathname.new(path).relative_path_from(ROOT).to_s }
    expected_installed -= ["os/release.json"]
    expected_installed += %w[AGENTS.md CLAUDE.md os/scripts/add-project.rb os/scripts/add-business.rb]
    missing_manifest_paths = expected_installed.sort - paths.sort
    extra_manifest_paths = paths.sort - expected_installed.sort
    add.call("release manifest misses installed paths: #{missing_manifest_paths.join(', ')}") unless missing_manifest_paths.empty?
    add.call("release manifest has unexpected installed paths: #{extra_manifest_paths.join(', ')}") unless extra_manifest_paths.empty?

    expected_distribution = tree_digests(ROOT).reject { |path, _hash| path == "release-manifest.json" }
    recorded_distribution = manifest.fetch("distribution_files").to_h { |entry| [entry.fetch("path"), entry.fetch("sha256")] }
    missing_distribution = expected_distribution.keys.sort - recorded_distribution.keys.sort
    extra_distribution = recorded_distribution.keys.sort - expected_distribution.keys.sort
    changed_distribution = (expected_distribution.keys & recorded_distribution.keys).select do |path|
      expected_distribution[path] != recorded_distribution[path]
    end
    add.call("release manifest misses public files: #{missing_distribution.join(', ')}") unless missing_distribution.empty?
    add.call("release manifest has removed public files: #{extra_distribution.join(', ')}") unless extra_distribution.empty?
    add.call("release manifest has stale public checksums: #{changed_distribution.join(', ')}") unless changed_distribution.empty?
  rescue JSON::ParserError => error
    add.call("release manifest is invalid JSON: #{error.message}")
  rescue KeyError => error
    add.call("release manifest is incomplete: #{error.message}")
  end
end

security_intake = File.file?("os/skills/security-intake.md") ? File.read("os/skills/security-intake.md") : ""
add.call("security intake does not keep artifacts inert") unless security_intake.match?(/Keep newly sourced.*inert/im)
add.call("security intake does not treat instructions as data") unless security_intake.match?(/instruction.*inside it as data, not authority/i)
add.call("security intake permits private public uploads") unless security_intake.match?(/Never send private files to public scanning services without owner approval/i)

source_files = tree_digests(ROOT).keys
secret_shapes = {
  "private key" => /-----BEGIN (?:RSA |EC |OPENSSH )?PRIVATE KEY-----/,
  "GitHub token" => /(?:ghp|gho|github_pat)_[A-Za-z0-9_]{20,}/,
  "OpenAI key" => /sk-[A-Za-z0-9_-]{20,}/,
  "AWS key" => /AKIA[0-9A-Z]{16}/
}
source_files.each do |path|
  next if File.symlink?(path)
  text = File.binread(path).force_encoding(Encoding::UTF_8)
  next unless text.valid_encoding?
  next if path == "scripts/validate-starter-kit.rb"
  secret_shapes.each { |label, pattern| add.call("#{path} contains #{label}-shaped text") if text.match?(pattern) }
  add.call("#{path} exposes a private local path") if text.match?(%r{/Users/[^/\s]+/})
end

synthetic_secrets = {
  "private key" => "-----BEGIN PRIVATE KEY-----",
  "GitHub token" => "ghp_abcdefghijklmnopqrstuvwxyz123456",
  "OpenAI key" => "sk-abcdefghijklmnopqrstuvwxyz123456",
  "AWS key" => "AKIA1234567890ABCDEF"
}
secret_shapes.each do |label, pattern|
  add.call("secret scanner positive fixture failed: #{label}") unless synthetic_secrets.fetch(label).match?(pattern)
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

source_project_output, source_project_status = capture("ruby", "scripts/add-project.rb", "must-refuse")
add.call("project generator did not refuse the public source") if source_project_status.success? || File.exist?("life/projects/must-refuse")
source_business_output, source_business_status = capture("ruby", "scripts/add-business.rb", "must-refuse")
add.call("business generator did not refuse the public source") if source_business_status.success? || File.exist?("biz/must-refuse")

Dir.mktmpdir("starter-os-2-") do |tmp|
  init_git = lambda do |vault|
    os_root = File.join(vault, "os")
    commands = [
      ["git", "init", "-q", os_root],
      ["git", "-C", os_root, "config", "user.name", "Starter.OS test"],
      ["git", "-C", os_root, "config", "user.email", "starter-os-test@example.invalid"],
      ["git", "-C", os_root, "add", "-A"],
      ["git", "-C", os_root, "commit", "-q", "-m", "test recovery point"]
    ]
    commands.each do |command|
      output, status = capture(*command)
      add.call("test Git setup failed: #{command.join(' ')}: #{output.strip}") unless status.success?
    end
  end

  linked_install_target = File.join(tmp, "LINKED-INSTALL-TARGET.os")
  linked_install = File.join(tmp, "LINKED-INSTALL.os")
  FileUtils.mkdir_p(linked_install_target)
  File.symlink(linked_install_target, linked_install)
  linked_install_output, linked_install_status = capture("ruby", "scripts/create-vault.rb", linked_install)
  if linked_install_status.success? || !linked_install_output.include?("destination itself may not be a symbolic link")
    add.call("clean installer did not reject a symbolic-link destination root")
  end

  builder_fixture = File.join(tmp, "builder-fixture")
  FileUtils.mkdir_p(builder_fixture)
  %w[os life scripts].each { |path| FileUtils.cp_r(ROOT.join(path), builder_fixture) }
  builder_external = File.join(tmp, "builder-external")
  FileUtils.mkdir_p(builder_external)
  File.write(File.join(builder_external, "outside.md"), "outside release tree\n")
  File.symlink(builder_external, File.join(builder_fixture, "os", "linked-outside"))
  builder_output, builder_status = capture(
    "ruby", "scripts/build-release-manifest.rb",
    chdir: builder_fixture
  )
  if builder_status.success? || !builder_output.include?("symbolic links are not allowed")
    add.call("release manifest builder did not reject a symbolic-link directory")
  end

  vault = File.join(tmp, "NOVA.os")
  output, status = capture("ruby", "scripts/create-vault.rb", vault)
  add.call("clean install failed: #{output.strip}") unless status.success?

  if status.success?
    roots = Dir.children(vault).sort
    expected_roots = %w[AGENTS.md CLAUDE.md biz life os]
    add.call("generated roots differ: #{roots.join(', ')}") unless roots == expected_roots
    add.call("setup leaked into installed vault") if File.exist?(File.join(vault, "setup"))
    add.call("biz is not initially empty") unless Dir.children(File.join(vault, "biz")).empty?
    add.call("manual was not installed") unless File.file?(File.join(vault, "os", "manual.md"))
    add.call("license was not installed") unless File.file?(File.join(vault, "os", "license.md"))

    release = JSON.parse(File.read(File.join(vault, "os", "release.json")))
    add.call("installed release version is not 2.1.0") unless release["version"] == "2.1.0"

    init_git.call(vault)

    project_output, project_status = capture("ruby", "os/scripts/add-project.rb", "health", chdir: vault)
    add.call("project generator failed: #{project_output.strip}") unless project_status.success?
    business_output, business_status = capture("ruby", "os/scripts/add-business.rb", "sample-studio", chdir: vault)
    add.call("business generator failed: #{business_output.strip}") unless business_status.success?

    validate_output, validate_status = capture("ruby", "os/validate-starter-os.rb", chdir: vault)
    add.call("installed validation failed:\n#{validate_output}") unless validate_status.success?

    external_manual = File.join(tmp, "external-manual.md")
    installed_manual = File.join(vault, "os", "manual.md")
    manual_bytes = File.binread(installed_manual)
    File.binwrite(external_manual, manual_bytes)
    FileUtils.rm_f(installed_manual)
    File.symlink(external_manual, installed_manual)
    linked_validate_output, linked_validate_status = capture("ruby", "os/validate-starter-os.rb", chdir: vault)
    if linked_validate_status.success? || !linked_validate_output.include?("crosses a symbolic link")
      add.call("installed validator did not reject a managed symbolic link")
    end
    FileUtils.rm_f(installed_manual)
    File.binwrite(installed_manual, manual_bytes)

    linked_update_target = File.join(tmp, "LINKED-UPDATE.os")
    File.symlink(vault, linked_update_target)
    linked_plan_path = File.join(tmp, "linked-update-plan.json")
    linked_plan_output, linked_plan_status = capture(
      "ruby", "scripts/update-vault.rb", "plan",
      linked_update_target, linked_plan_path
    )
    if linked_plan_status.success? || !linked_plan_output.include?("target itself may not be a symbolic link")
      add.call("updater did not reject a symbolic-link target root")
    end

    plan_path = File.join(tmp, "same-version-plan.json")
    plan_output, plan_status = capture("ruby", "scripts/update-vault.rb", "plan", vault, plan_path)
    add.call("same-version update plan failed: #{plan_output.strip}") unless plan_status.success?
    if plan_status.success?
      plan = JSON.parse(File.read(plan_path))
      add.call("same-version plan unexpectedly has conflicts") if plan["entries"].any? { |entry| entry["action"] == "conflict" }

      tampered_path = File.join(tmp, "tampered-plan.json")
      tampered = JSON.parse(JSON.generate(plan))
      preserve_entry = tampered.fetch("entries").find { |entry| entry["action"] == "preserve" }
      if preserve_entry
        protected_path = File.join(vault, preserve_entry.fetch("path"))
        protected_before = Digest::SHA256.file(protected_path).hexdigest
        preserve_entry["action"] = "update"
        File.write(tampered_path, "#{JSON.pretty_generate(tampered)}\n")
        tampered_output, tampered_status = capture(
          "ruby", "scripts/update-vault.rb", "apply",
          vault, tampered_path
        )
        if tampered_status.success? || !tampered_output.include?("plan contents do not match")
          add.call("updater did not reject a semantically tampered plan")
        end
        add.call("tampered update plan changed an owner-owned file") unless Digest::SHA256.file(protected_path).hexdigest == protected_before
      else
        add.call("same-version plan has no owner-owned preserve entry for tamper regression")
      end

      apply_output, apply_status = capture("ruby", "scripts/update-vault.rb", "apply", vault, plan_path)
      add.call("same-version update apply failed: #{apply_output.strip}") unless apply_status.success?
    end

    refusal_output, refusal_status = capture("ruby", "scripts/create-vault.rb", vault)
    add.call("non-empty destination was not refused") if refusal_status.success? || !refusal_output.include?("not empty")
  end

  prior_vault = File.join(tmp, "STARTER-2-0.os")
  prior_create, prior_create_status = capture("ruby", "scripts/create-vault.rb", prior_vault)
  if prior_create_status.success?
    prior_release_path = File.join(prior_vault, "os", "release.json")
    prior_release = JSON.parse(File.read(prior_release_path))
    prior_release["version"] = "2.0.0"
    prior_brief_path = File.join(prior_vault, "os", "skills", "daily-brief.md")
    prior_brief = "---\ntype: skill\nstatus: draft\n---\n\n# daily brief\n\nLegacy 2.0 fixture.\n"
    File.write(prior_brief_path, prior_brief)
    prior_release.fetch("artifacts").fetch("os/skills/daily-brief.md")["sha256"] = Digest::SHA256.hexdigest(prior_brief)
    File.write(prior_release_path, "#{JSON.pretty_generate(prior_release)}\n")
    custom_path = File.join(prior_vault, "life", "original-owner-note.md")
    File.write(custom_path, "owner work must survive\n")
    custom_digest = Digest::SHA256.file(custom_path).hexdigest
    init_git.call(prior_vault)

    prior_plan_path = File.join(tmp, "2-0-to-2-1-plan.json")
    prior_plan_output, prior_plan_status = capture("ruby", "scripts/update-vault.rb", "plan", prior_vault, prior_plan_path)
    add.call("2.0 to 2.1 update plan failed: #{prior_plan_output.strip}") unless prior_plan_status.success?
    if prior_plan_status.success?
      prior_plan = JSON.parse(File.read(prior_plan_path))
      brief_entry = prior_plan.fetch("entries").find { |entry| entry["path"] == "os/skills/daily-brief.md" }
      add.call("2.0 to 2.1 plan did not recognize the managed Morning Brief update") unless brief_entry && brief_entry["action"] == "update"
      prior_apply_output, prior_apply_status = capture("ruby", "scripts/update-vault.rb", "apply", prior_vault, prior_plan_path)
      add.call("2.0 to 2.1 update apply failed: #{prior_apply_output.strip}") unless prior_apply_status.success?
      if prior_apply_status.success?
        updated_release = JSON.parse(File.read(prior_release_path))
        add.call("2.0 update did not install 2.1.0") unless updated_release["version"] == "2.1.0"
        add.call("2.0 update changed unknown owner work") unless Digest::SHA256.file(custom_path).hexdigest == custom_digest
        prior_validate, prior_validate_status = capture("ruby", "os/validate-starter-os.rb", chdir: prior_vault)
        add.call("updated 2.0 vault did not validate: #{prior_validate.strip}") unless prior_validate_status.success?
      end
    end
  else
    add.call("2.0 update fixture could not be created: #{prior_create.strip}")
  end

  fork_vault = File.join(tmp, "FORK.os")
  fork_create, fork_create_status = capture("ruby", "scripts/create-vault.rb", fork_vault)
  if fork_create_status.success?
    init_git.call(fork_vault)
    File.open(File.join(fork_vault, "os", "manual.md"), "a") { |file| file.write("\nOwner explanation.\n") }
    capture("git", "-C", File.join(fork_vault, "os"), "add", "-A")
    capture("git", "-C", File.join(fork_vault, "os"), "commit", "-q", "-m", "owner changed manual")
    fork_plan = File.join(tmp, "fork-plan.json")
    fork_plan_output, fork_plan_status = capture("ruby", "scripts/update-vault.rb", "plan", fork_vault, fork_plan)
    add.call("manual conflict plan failed: #{fork_plan_output.strip}") unless fork_plan_status.success?
    if fork_plan_status.success?
      plan = JSON.parse(File.read(fork_plan))
      manual_entry = plan["entries"].find { |entry| entry["path"] == "os/manual.md" }
      add.call("modified manual was not detected as a conflict") unless manual_entry && manual_entry["action"] == "conflict"
      fork_apply_output, fork_apply_status = capture(
        "ruby", "scripts/update-vault.rb", "apply", fork_vault, fork_plan,
        "--fork", "os/manual.md=life/manual.md"
      )
      add.call("manual fork update failed: #{fork_apply_output.strip}") unless fork_apply_status.success?
      add.call("owner manual fork was not created") unless File.file?(File.join(fork_vault, "life", "manual.md"))
      expected_manual = Digest::SHA256.file("os/manual.md").hexdigest
      actual_manual = Digest::SHA256.file(File.join(fork_vault, "os", "manual.md")).hexdigest
      add.call("product manual was not restored") unless expected_manual == actual_manual
      me_path = File.join(fork_vault, "os", "me.md")
      File.write(me_path, File.read(me_path).sub("Manual fork: none by default.", "Manual fork: life/manual.md."))
      fork_validate, fork_validate_status = capture("ruby", "os/validate-starter-os.rb", chdir: fork_vault)
      add.call("manual fork routing did not validate: #{fork_validate.strip}") unless fork_validate_status.success?
    end
  else
    add.call("manual fork fixture could not be created: #{fork_create.strip}")
  end

  legacy_vault = File.join(tmp, "LEGACY-STARTER.os")
  legacy_create, legacy_create_status = capture("ruby", "scripts/create-vault.rb", legacy_vault)
  if legacy_create_status.success?
    FileUtils.rm_f(File.join(legacy_vault, "os", "release.json"))
    legacy_owner_path = File.join(legacy_vault, "life", "first-version-owner-note.md")
    File.write(legacy_owner_path, "unique owner work from the first version\n")
    legacy_owner_digest = Digest::SHA256.file(legacy_owner_path).hexdigest
    init_git.call(legacy_vault)
    legacy_plan = File.join(tmp, "legacy-update-plan.json")
    legacy_plan_output, legacy_plan_status = capture("ruby", "scripts/update-vault.rb", "plan", legacy_vault, legacy_plan)
    add.call("legacy update plan failed: #{legacy_plan_output.strip}") unless legacy_plan_status.success?
    if legacy_plan_status.success?
      plan = JSON.parse(File.read(legacy_plan))
      conflicts = plan["entries"].select { |entry| entry["action"] == "conflict" }.map { |entry| entry["path"] }
      add.call("legacy update did not conservatively detect managed conflicts") if conflicts.empty?
      command = ["ruby", "scripts/update-vault.rb", "apply", legacy_vault, legacy_plan]
      conflicts.each { |path| command.concat(["--replace", path]) }
      legacy_apply_output, legacy_apply_status = capture(*command)
      add.call("approved legacy update failed: #{legacy_apply_output.strip}") unless legacy_apply_status.success?
      if legacy_apply_status.success?
        add.call("legacy update changed unknown owner work") unless Digest::SHA256.file(legacy_owner_path).hexdigest == legacy_owner_digest
        legacy_validate, legacy_validate_status = capture("ruby", "os/validate-starter-os.rb", chdir: legacy_vault)
        add.call("updated legacy vault did not validate: #{legacy_validate.strip}") unless legacy_validate_status.success?
      end
    end
  else
    add.call("legacy update fixture could not be created: #{legacy_create.strip}")
  end

  legacy = File.join(tmp, "OTHER.os")
  FileUtils.mkdir_p(File.join(legacy, "life", "00_inbox"))
  FileUtils.mkdir_p(File.join(legacy, "life", "areas", "health"))
  FileUtils.mkdir_p(File.join(legacy, "life", "archive"))
  FileUtils.mkdir_p(File.join(legacy, "life", "assets"))
  FileUtils.mkdir_p(File.join(legacy, "life", "notes"))
  File.write(File.join(legacy, "life", "00_inbox", "note.md"), "unique legacy note\n")
  File.write(File.join(legacy, "life", "areas", "health", "care.md"), "unique health record\n")
  File.write(File.join(legacy, "life", "archive", "history.md"), "unique archived history\n")
  File.binwrite(File.join(legacy, "life", "assets", "sample.bin"), "\x00\xFFlegacy\x10".b)
  File.write(File.join(legacy, "life", "notes", "raw.md"), "raw idea\n")
  File.write(File.join(legacy, "life", "notes", "part.md"), "part one\n")
  File.write(File.join(legacy, ".DS_Store"), "obsolete finder metadata\n")

  before = tree_digests(Pathname.new(legacy))
  preview = File.join(tmp, "PREVIEW.os")
  source_snapshot = File.join(tmp, "source-snapshot.json")
  snapshot_output, snapshot_status = capture(
    "ruby", "scripts/verify-migration.rb", "snapshot", legacy, source_snapshot
  )
  add.call("migration source snapshot failed: #{snapshot_output.strip}") unless snapshot_status.success?
  preview_output, preview_status = capture("ruby", "scripts/create-vault.rb", preview)
  add.call("migration preview generation failed: #{preview_output.strip}") unless preview_status.success?

  if preview_status.success? && snapshot_status.success?
    FileUtils.mkdir_p(File.join(preview, "life", "documents"))
    FileUtils.mkdir_p(File.join(preview, "life", "projects", "health"))
    FileUtils.cp(File.join(legacy, "life", "00_inbox", "note.md"), File.join(preview, "life", "documents", "note.md"))
    FileUtils.cp(File.join(legacy, "life", "areas", "health", "care.md"), File.join(preview, "life", "projects", "health", "care.md"))
    FileUtils.cp(File.join(legacy, "life", "assets", "sample.bin"), File.join(preview, "life", "documents", "sample.bin"))
    File.write(File.join(preview, "life", "documents", "summary.md"), "approved transformed summary\n")
    File.write(File.join(preview, "life", "documents", "combined.md"), "approved merged material\n")

    manifest_path = File.join(tmp, "migration-map.tsv")
    rows = [
      %w[source_path disposition destination_path reason],
      [".DS_Store", "exclude", "", "obsolete Finder metadata"],
      ["life/00_inbox/note.md", "preserve", "life/documents/note.md", ""],
      ["life/archive/history.md", "unresolved", "", "owner must choose its durable home"],
      ["life/areas/health/care.md", "copy", "life/projects/health/care.md", ""],
      ["life/assets/sample.bin", "copy", "life/documents/sample.bin", ""],
      ["life/notes/raw.md", "transform", "life/documents/summary.md", "owner approved a concise rewrite"],
      ["life/notes/part.md", "merge", "life/documents/combined.md", "owner approved consolidation"]
    ]
    File.write(manifest_path, rows.map { |row| CSV.generate_line(row, col_sep: "\t") }.join)
    verify_output, verify_status = capture(
      "ruby", "scripts/verify-migration.rb", "verify",
      legacy, preview, source_snapshot, manifest_path
    )
    add.call("complete migration manifest did not verify: #{verify_output.strip}") unless verify_status.success?

    incomplete_path = File.join(tmp, "incomplete-migration-map.tsv")
    incomplete_rows = rows.reject { |row| row.first == "life/assets/sample.bin" }
    File.write(incomplete_path, incomplete_rows.map { |row| CSV.generate_line(row, col_sep: "\t") }.join)
    incomplete_output, incomplete_status = capture(
      "ruby", "scripts/verify-migration.rb", "verify",
      legacy, preview, source_snapshot, incomplete_path
    )
    add.call("incomplete migration map was not rejected") if incomplete_status.success? || !incomplete_output.include?("unaccounted source paths")

    copied_binary = File.join(preview, "life", "documents", "sample.bin")
    original_binary = File.binread(copied_binary)
    File.binwrite(copied_binary, "changed copy\n")
    mismatch_output, mismatch_status = capture(
      "ruby", "scripts/verify-migration.rb", "verify",
      legacy, preview, source_snapshot, manifest_path
    )
    add.call("changed copied bytes were not rejected") if mismatch_status.success? || !mismatch_output.include?("copied bytes do not match")
    File.binwrite(copied_binary, original_binary)
  end

  add.call("migration preview changed the source fixture") unless before == tree_digests(Pathname.new(legacy))
end

source_after = tree_digests(ROOT)
add.call("validation modified the public source checkout") unless source_before == source_after

if errors.empty?
  puts "PASS Starter.OS 2.1: link-only routing, three guided paths, Git primary and mirror contract, skill audit, protected manual, licenses, release manifest, clean install, 2.0 update, legacy update, manual fork, migration proof, and privacy checks"
  exit 0
end

puts "FAIL Starter.OS 2.1: #{errors.length} issue#{errors.length == 1 ? '' : 's'}"
errors.each { |message| puts "- #{message}" }
exit 1
