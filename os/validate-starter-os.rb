#!/usr/bin/env ruby

require "pathname"

ROOT = Pathname.new(File.expand_path("..", __dir__))
Dir.chdir(ROOT)

errors = []
add = ->(message) { errors << message }

required = %w[
  AGENTS.md
  CLAUDE.md
  os/AGENTS.md
  os/CLAUDE.md
  os/me.md
  os/vault-map.md
  os/knowledge-map.md
  os/retrieval.md
  os/recovery.md
  os/integrations.md
  os/skill-map.md
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
required.each { |path| add.call("missing #{path}") unless File.exist?(path) }

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
unexpected_roots = Dir.children(".").reject { |name| allowed_roots.include?(name) }
add.call("unexpected installed root: #{unexpected_roots.join(', ')}") unless unexpected_roots.empty?

empty_dirs = Dir.glob("**/*", File::FNM_DOTMATCH).select do |path|
  File.directory?(path) && !path.split("/").include?(".git") && Dir.children(path).empty?
end
empty_dirs.reject! { |path| path == "biz" }
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

secret_shapes = {
  "private key" => /-----BEGIN (?:RSA |EC |OPENSSH )?PRIVATE KEY-----/,
  "GitHub token" => /(?:ghp|gho|github_pat)_[A-Za-z0-9_]{20,}/,
  "OpenAI key" => /sk-[A-Za-z0-9_-]{20,}/,
  "AWS key" => /AKIA[0-9A-Z]{16}/
}

Dir.glob("{os,life,biz}/**/*", File::FNM_DOTMATCH).select { |path| File.file?(path) }.each do |path|
  text = File.binread(path).force_encoding(Encoding::UTF_8)
  next unless text.valid_encoding?
  secret_shapes.each { |label, pattern| add.call("#{path} contains #{label}-shaped text") if text.match?(pattern) }
end

if errors.empty?
  puts "PASS Starter.OS 2 installed vault"
  exit 0
end

puts "FAIL Starter.OS 2 installed vault: #{errors.length} issue#{errors.length == 1 ? '' : 's'}"
errors.each { |message| puts "- #{message}" }
exit 1
