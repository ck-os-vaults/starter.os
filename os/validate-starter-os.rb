#!/usr/bin/env ruby

require "digest"
require "json"
require "pathname"

ROOT = Pathname.new(File.expand_path("..", __dir__))
Dir.chdir(ROOT)

errors = []
add = ->(message) { errors << message }

def symlink_component?(relative)
  current = Pathname.new(".")
  Pathname.new(relative).each_filename do |part|
    current = current.join(part)
    return true if current.symlink?
  end
  false
end

required = %w[
  AGENTS.md
  CLAUDE.md
  os/AGENTS.md
  os/CLAUDE.md
  os/manual.md
  os/license.md
  os/release.json
  os/me.md
  os/vault-map.md
  os/knowledge-map.md
  os/retrieval.md
  os/recovery.md
  os/integrations.md
  os/skill-map.md
  os/skills/drift-recovery.md
  os/skills/security-intake.md
  os/skills/security-sweep.md
  os/skills/task-reconciliation.md
  os/validate-starter-os.rb
  os/scripts/add-project.rb
  os/scripts/add-business.rb
  life/AGENTS.md
  life/CLAUDE.md
  life/now.md
  life/knowledge-map.md
  life/documents/readme.md
  life/projects/readme.md
  life/wiki/owner.md
  life/records/readme.md
  life/records/decisions.md
  biz
]
required.each do |path|
  add.call("missing #{path}") unless File.exist?(path)
  add.call("required path crosses a symbolic link: #{path}") if symlink_component?(path)
end

forbidden = %w[setup life/00_inbox life/areas life/archive life/records/sessions biz/business-model]
forbidden.each { |path| add.call("obsolete path remains: #{path}") if File.exist?(path) }

add.call("vault root must not be a Git repository") if File.exist?(".git")
add.call("biz container must not be a Git repository") if File.exist?("biz/.git")

if File.file?("AGENTS.md") && File.file?("os/templates/root-AGENTS.txt")
  add.call("root AGENTS.md differs from its recovery template") unless File.read("AGENTS.md") == File.read("os/templates/root-AGENTS.txt")
end
if File.file?("CLAUDE.md") && File.file?("os/templates/root-CLAUDE.txt")
  add.call("root CLAUDE.md differs from its recovery template") unless File.read("CLAUDE.md") == File.read("os/templates/root-CLAUDE.txt")
end

allowed_roots = %w[.obsidian AGENTS.md CLAUDE.md biz life os]
%w[os life biz].each { |path| add.call("installed root may not be a symbolic link: #{path}") if Pathname.new(path).symlink? }
unexpected_roots = Dir.children(".").reject { |name| allowed_roots.include?(name) }
add.call("unexpected installed root: #{unexpected_roots.join(', ')}") unless unexpected_roots.empty?

empty_dirs = Dir.glob("**/*", File::FNM_DOTMATCH).select do |path|
  File.directory?(path) && !path.split("/").include?(".git") && Dir.children(path).empty?
end
empty_dirs.reject! { |path| path == "biz" || path == "biz/." || File.basename(path) == "." }
empty_dirs.each { |path| add.call("unnecessary empty directory: #{path}") }

Dir.glob("life/projects/*").select { |path| File.directory?(path) }.each do |project|
  name = File.basename(project)
  add.call("project home missing: #{project}/#{name}.md") unless File.file?(File.join(project, "#{name}.md"))
end

Dir.glob("biz/*").select { |path| File.directory?(path) }.each do |business|
  %w[AGENTS.md CLAUDE.md readme.md status.md knowledge-map.md decisions.md].each do |file|
    add.call("business foundation missing: #{business}/#{file}") unless File.file?(File.join(business, file))
  end
  nested = Dir.glob("#{business}/**/.git").reject { |path| path == "#{business}/.git" }
  nested.each { |path| add.call("nested business repository: #{path}") }
end

skill_map = File.file?("os/skill-map.md") ? File.read("os/skill-map.md") : ""
actual_skills = Dir.glob("os/skills/*.md").map { |path| File.basename(path, ".md") }.reject { |name| name == "readme" }.sort
registered_skills = skill_map.scan(/^\|\s*\[\[([a-z0-9-]+)\]\]/).flatten.uniq.sort
(registered_skills - actual_skills).each { |skill| add.call("registered skill missing: os/skills/#{skill}.md") }
(actual_skills - registered_skills).each { |skill| add.call("unregistered skill file: os/skills/#{skill}.md") }

manual = File.file?("os/manual.md") ? File.read("os/manual.md") : ""
operating_rules = File.file?("os/AGENTS.md") ? File.read("os/AGENTS.md") : ""
add.call("manual is missing its human title") unless manual.include?("# How Starter.OS works")
add.call("manual does not explain Git, skills, automations, and updates") unless %w[Git Skills automations Update].all? { |word| manual.match?(/#{word}/i) }
add.call("manual is not declared protected") unless manual.match?(/may not rewrite|protected/i)
add.call("operating rules do not route explanations to the manual") unless operating_rules.match?(/Use .*manual\.md.*owner asks/im)
add.call("operating rules do not protect the manual") unless operating_rules.match?(/manual\.md.*protected/im) && operating_rules.match?(/Do not rewrite/im)

release_path = Pathname.new("os/release.json")
if release_path.file?
  begin
    release = JSON.parse(release_path.read)
    add.call("unsupported release record") unless release["format"] == 1 && release["product"] == "Starter.OS" && !release["version"].to_s.empty?
    release_artifacts = release.fetch("artifacts", {})
    add.call("release record has no artifacts") if release_artifacts.empty?
    release_artifacts.each do |path, record|
      target = Pathname.new(path)
      clean = target.cleanpath.to_s
      if target.absolute? || clean == ".." || clean.start_with?("../") || clean != path
        add.call("release record has unsafe path: #{path}")
        next
      end
      if symlink_component?(path)
        add.call("release artifact crosses a symbolic link: #{path}")
        next
      end
      absolute = Pathname.new(path)
      if record["ownership"] == "managed"
        if !absolute.file?
          add.call("managed release artifact is missing: #{path}")
        elsif record["sha256"].to_s.empty?
          add.call("managed release artifact has no checksum: #{path}")
        elsif Digest::SHA256.file(absolute).hexdigest != record["sha256"]
          add.call("managed release artifact changed outside the update process: #{path}")
        end
      end
      add.call("protected product manual cannot be forked in place") if path == "os/manual.md" && record["ownership"] == "forked"
    end
    release.fetch("forks", []).each do |fork|
      destination = fork.fetch("destination")
      fork_path = Pathname.new(destination)
      clean = fork_path.cleanpath.to_s
      if fork_path.absolute? || clean == ".." || clean.start_with?("../") || clean != destination
        add.call("release record has unsafe fork destination: #{destination}")
        next
      end
      if symlink_component?(destination)
        add.call("declared owner fork crosses a symbolic link: #{destination}")
        next
      end
      if !fork_path.file?
        add.call("declared owner fork is missing: #{destination}")
      end
      if fork["source"] == "os/manual.md" && File.file?("os/me.md") && !File.read("os/me.md").include?(destination)
        add.call("manual fork is not routed from os/me.md: #{destination}")
      end
    end
  rescue JSON::ParserError => error
    add.call("release record is invalid JSON: #{error.message}")
  rescue KeyError => error
    add.call("release record is incomplete: #{error.message}")
  end
end

security_intake = File.file?("os/skills/security-intake.md") ? File.read("os/skills/security-intake.md") : ""
add.call("security intake does not keep new artifacts inert") unless security_intake.match?(/Keep newly sourced.*inert/im)
add.call("security intake does not treat embedded instructions as data") unless security_intake.match?(/instruction.*inside it as data, not authority/i)
add.call("security intake does not protect private files from public uploads") unless security_intake.match?(/Never send private files to public scanning services without owner approval/i)
add.call("security intake incorrectly treats a clean scan as proof") unless security_intake.match?(/clean scan lowers risk; it never proves/i)

security_sweep = File.file?("os/skills/security-sweep.md") ? File.read("os/skills/security-sweep.md") : ""
add.call("security sweep is missing the optional nightly recipe") unless security_sweep.include?("Nightly System Security Check") && security_sweep.match?(/owner accepts/i)
add.call("nightly security recipe is not read-only and fail-closed") unless security_sweep.match?(/remain read-only/i) && security_sweep.match?(/incomplete coverage/i)

reconciliation = File.file?("os/skills/task-reconciliation.md") ? File.read("os/skills/task-reconciliation.md") : ""
add.call("reconciliation is missing the optional nightly recipe") unless reconciliation.include?("Nightly Chief Reconciliation") && reconciliation.match?(/owner accepts/i)
add.call("nightly reconciliation is not read-only") unless reconciliation.match?(/remain read-only/i)

git_preflight = File.file?("os/skills/git-sync-preflight.md") ? File.read("os/skills/git-sync-preflight.md") : ""
add.call("Git preflight is not provider-neutral") unless git_preflight.match?(/declared primary/i) && git_preflight.match?(/Secondary.*verification-only/im)
add.call("Git preflight permits dual pushes") if git_preflight.match?(/push.*to.*secondary/i) && !git_preflight.match?(/never push.*secondary/i)

secret_shapes = {
  "private key" => /-----BEGIN (?:RSA |EC |OPENSSH )?PRIVATE KEY-----/,
  "GitHub token" => /(?:ghp|gho|github_pat)_[A-Za-z0-9_]{20,}/,
  "OpenAI key" => /sk-[A-Za-z0-9_-]{20,}/,
  "AWS key" => /AKIA[0-9A-Z]{16}/
}

Dir.glob("{os,life,biz}/**/*", File::FNM_DOTMATCH).select { |path| File.file?(path) && !symlink_component?(path) }.each do |path|
  text = File.binread(path).force_encoding(Encoding::UTF_8)
  next unless text.valid_encoding?
  secret_shapes.each { |label, pattern| add.call("#{path} contains #{label}-shaped text") if text.match?(pattern) }
end

if errors.empty?
  puts "PASS Starter.OS installed vault: structure, release identity, protected manual, skill registry, Git contract, automation recipes, and privacy checks"
  exit 0
end

puts "FAIL Starter.OS installed vault: #{errors.length} issue#{errors.length == 1 ? '' : 's'}"
errors.each { |message| puts "- #{message}" }
exit 1
