#!/usr/bin/env ruby

require "date"
require "open3"
require "pathname"
require "yaml"

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

ROOT = Pathname.new(File.expand_path("..", __dir__))
Dir.chdir(ROOT)

PROMPT_FILES = %w[
  setup/PROMPT-01-CREATE-MY-OS.md
  setup/PROMPT-02-FIRST-WORKING-SESSION.md
].freeze
ENTRY_EXEMPTIONS = %w[
  AGENTS.md
  CLAUDE.md
  os/AGENTS.md
  os/CLAUDE.md
  life/AGENTS.md
  life/CLAUDE.md
].freeze
TEMPLATE_EXEMPTIONS = Dir["os/templates/*"].reject { |file| File.basename(file) == "readme.md" }.freeze
REQUIRED_KEYS = %w[type created reviewed status authority source].freeze
ALLOWED = {
  "type" => %w[note map identity skill spec handoff daily weekly monthly journal decision-log history status],
  "status" => %w[living draft superseded done archived],
  "authority" => %w[canon spec reference exploratory],
  "source" => %w[owner ai]
}.freeze
ONBOARDING_STATES = %w[not-started in-progress tutorial-pending complete].freeze
BUSINESS_MODEL = "business-model"
SECRET_SHAPES = {
  "private key" => /-----BEGIN (?:RSA |EC |OPENSSH )?PRIVATE KEY-----/,
  "GitHub token" => /(?:ghp|gho|github_pat)_[A-Za-z0-9_]{20,}/,
  "OpenAI key" => /sk-[A-Za-z0-9_-]{20,}/,
  "Anthropic key" => /sk-ant-[A-Za-z0-9_-]{20,}/,
  "AWS key" => /AKIA[0-9A-Z]{16}/
}.freeze

errors = []
metadata = {}
add_error = ->(file, message) { errors << "#{file}: #{message}" }

required_paths = %w[
  AGENTS.md
  CLAUDE.md
  os/AGENTS.md
  os/CLAUDE.md
  os/me.md
  os/agent-rules.md
  os/vault-map.md
  os/retrieval.md
  os/recovery.md
  os/integrations.md
  os/knowledge-map.md
  os/skill-map.md
  os/starter-version.md
  os/system-explained.md
  life/AGENTS.md
  life/CLAUDE.md
  life/readme.md
  life/now.md
  life/knowledge-map.md
  life/00_inbox/readme.md
  life/areas/readme.md
  life/areas/health/readme.md
  life/areas/home/readme.md
  life/areas/relationships/readme.md
  life/projects/readme.md
  life/knowledge/people/owner.md
  life/records/readme.md
  life/records/decisions.md
  life/archive/readme.md
  biz
]
required_paths.each { |path| add_error.call(path, "required path is missing") unless Pathname(path).exist? }

all_markdown = Dir["**/*.md"].sort
active_markdown = all_markdown.reject do |file|
  file.start_with?("life/archive/") ||
    file.include?("/archive/") ||
    file.start_with?("biz/") && file.split("/").length > 2 && file.include?("/archive/")
end

business_entries = if Dir.exist?("biz")
  Dir.children("biz").reject { |name| name.start_with?(".") }.select { |name| File.directory?(File.join("biz", name)) }.sort
else
  []
end
real_business_entries = business_entries.reject { |name| name == BUSINESS_MODEL }
entry_exemptions = ENTRY_EXEMPTIONS.dup
business_entries.each do |business|
  entry_exemptions.concat(["biz/#{business}/AGENTS.md", "biz/#{business}/CLAUDE.md"])
end

audited_files = active_markdown - entry_exemptions - TEMPLATE_EXEMPTIONS - PROMPT_FILES

audited_files.each do |file|
  text = File.read(file)
  match = text.match(/\A---\n(.*?)\n---\n/m)
  unless match
    add_error.call(file, "missing or malformed YAML frontmatter")
    next
  end

  begin
    data = YAML.safe_load(match[1], permitted_classes: [Date], aliases: false) || {}
  rescue StandardError => e
    add_error.call(file, "invalid YAML: #{e.message}")
    next
  end

  metadata[file] = data
  body = text[match[0].length..]
  body_without_fences = body.gsub(/```.*?```/m, "")

  REQUIRED_KEYS.each { |key| add_error.call(file, "missing #{key}") unless data.key?(key) }
  ALLOWED.each do |key, values|
    add_error.call(file, "invalid #{key}: #{data[key]}") if data[key] && !values.include?(data[key])
  end

  if data["status"] == "superseded"
    replacement = data["superseded_by"]
    if replacement.to_s.empty?
      add_error.call(file, "superseded file is missing superseded_by")
    else
      target = Pathname(file).dirname.join(replacement).cleanpath
      add_error.call(file, "superseded_by target does not exist: #{replacement}") unless target.exist?
    end
  end

  dates = {}
  %w[created updated reviewed].each do |key|
    next unless data[key]
    begin
      dates[key] = Date.parse(data[key].to_s)
    rescue ArgumentError
      add_error.call(file, "invalid #{key} date: #{data[key]}")
    end
  end
  add_error.call(file, "updated predates created") if dates["created"] && dates["updated"] && dates["updated"] < dates["created"]
  add_error.call(file, "reviewed predates updated") if dates["updated"] && dates["reviewed"] && dates["reviewed"] < dates["updated"]

  add_error.call(file, "expected exactly one H1") unless body_without_fences.scan(/^# /).length == 1
  add_error.call(file, "literal \\n heading escape") if text.include?("\\n##")
  add_error.call(file, "legacy inline metadata remains") if body.match?(/^(Status|Created|Last updated):/)

  summary_required = %w[note map identity status decision-log].include?(data["type"])
  if summary_required
    add_error.call(file, "expected exactly one Bottom line") unless body.scan(/^\*\*Bottom line:\*\*/i).length == 1
    add_error.call(file, "expected exactly one When to read this") unless body.scan(/^\*\*When to read this:\*\*/i).length == 1
    first_h2 = body.index(/^## /)
    bottom_position = body.index(/^\*\*Bottom line:\*\*/i)
    trigger_position = body.index(/^\*\*When to read this:\*\*/i)
    if first_h2 && (!bottom_position || !trigger_position || bottom_position > first_h2 || trigger_position > first_h2)
      add_error.call(file, "routing summary must appear before the first H2")
    end
  end
end

PROMPT_FILES.each do |file|
  next unless File.exist?(file)
  text = File.read(file)
  add_error.call(file, "missing Copy and paste label") unless text.match?(/^# Copy and paste/)
  add_error.call(file, "missing New User label") unless text.include?("**For: New User**")
  add_error.call(file, "expected exactly one prompt block") unless text.scan(/^```text$/).length == 1 && text.scan(/^```$/).length == 1
end

# Validate Markdown links in active files.
active_markdown.each do |file|
  next if PROMPT_FILES.include?(file)
  File.read(file).scan(/\[[^\]]*\]\(([^)]+)\)/).flatten.each do |raw|
    target = raw.split("#", 2).first.strip
    next if target.empty? || target.match?(%r{\A(?:https?://|mailto:|data:)})
    target = target[1..-2] if target.start_with?("<") && target.end_with?(">")
    resolved = Pathname(file).dirname.join(target).cleanpath
    add_error.call(file, "broken Markdown link: #{target}") unless resolved.exist?
  end
end

# Validate wikilinks by direct relative path or unique active filename.
audited_files.each do |file|
  link_text = File.read(file).gsub(/```.*?```/m, "")
  link_text.scan(/\[\[([^\]|#]+)(?:#[^\]|]+)?(?:\|[^\]]+)?\]\]/).flatten.each do |raw|
    target = raw.strip.sub(/\.md\z/, "")
    relative = Pathname(file).dirname.join("#{target}.md").cleanpath
    by_name = active_markdown.select { |candidate| File.basename(candidate, ".md").casecmp?(File.basename(target)) }
    resolved = relative.exist? || by_name.length == 1
    add_error.call(file, "unresolved or ambiguous wikilink: #{raw}") unless resolved
  end
end

# Validate onboarding state and setup lifecycle.
starter_version = metadata["os/starter-version.md"] || {}
onboarding_state = starter_version["onboarding"].to_s
add_error.call("os/starter-version.md", "invalid onboarding state: #{onboarding_state.inspect}") unless ONBOARDING_STATES.include?(onboarding_state)

if File.file?("os/starter-version.md")
  visible_state = File.read("os/starter-version.md").match(/^- Onboarding state: `([^`]+)`$/)&.captures&.first
  add_error.call("os/starter-version.md", "visible onboarding state does not match frontmatter") if ONBOARDING_STATES.include?(onboarding_state) && visible_state != onboarding_state
end

if onboarding_state == "complete"
  add_error.call("setup/", "temporary setup folder remains active after onboarding") if Dir.exist?("setup")
  completions = Dir["life/records/sessions/*-setup-completion.md"]
  add_error.call("life/records/sessions/", "setup completion record is missing") if completions.empty?

  temporary_names = %w[
    README.md INSTALL.md PROMPT-01-CREATE-MY-OS.md PROMPT-02-FIRST-WORKING-SESSION.md
    SETUP-STATUS.md AGENT-RUNBOOK.md ONBOARDING-INTERVIEW.md OPERATOR-GUIDE.md
  ]
  active_markdown.each do |file|
    text = File.read(file)
    temporary_names.each do |name|
      add_error.call(file, "still routes to temporary setup file: #{name}") if text.include?("setup/#{name}")
    end
  end
else
  add_error.call("setup/", "setup folder is required until onboarding is complete") unless Dir.exist?("setup")
  PROMPT_FILES.each { |file| add_error.call(file, "required during onboarding") unless File.exist?(file) }
end

# Enforce repository boundaries.
add_error.call(".git", "vault root must never be a Git repository") if File.exist?(".git")
add_error.call("biz/.git", "biz container must never be a Git repository") if File.exist?("biz/.git")

declared_repos = ["os", "life"] + real_business_entries.map { |name| "biz/#{name}" }
all_git_dirs = Dir.glob("**/.git", File::FNM_DOTMATCH).select { |path| File.directory?(path) }.sort
all_git_dirs.each do |git_dir|
  root = File.dirname(git_dir)
  add_error.call(git_dir, "repository is not at a declared owner root") unless declared_repos.include?(root)
end

if %w[tutorial-pending complete].include?(onboarding_state)
  declared_repos.each do |repo|
    add_error.call(repo, "missing Git repository after publication phase") unless File.directory?(File.join(repo, ".git"))
  end
end

declared_repos.each do |repo|
  nested = Dir.glob(File.join(repo, "**", ".git"), File::FNM_DOTMATCH).select { |path| File.directory?(path) && path != File.join(repo, ".git") }
  nested.each { |path| add_error.call(path, "nested repository is forbidden") }

  next unless File.directory?(File.join(repo, ".git"))
  next unless %w[tutorial-pending complete].include?(onboarding_state)

  origin, origin_status = Open3.capture2e("git", "-C", repo, "remote", "get-url", "origin")
  backup, backup_status = Open3.capture2e("git", "-C", repo, "remote", "get-url", "backup")
  add_error.call(repo, "missing GitHub origin") unless origin_status.success? && origin.include?("github.com")
  add_error.call(repo, "missing GitLab backup") unless backup_status.success? && backup.include?("gitlab.com")
end

obsidian_dirs = Dir.glob("**/.obsidian", File::FNM_DOTMATCH).select { |path| File.directory?(path) }
obsidian_dirs.each { |path| add_error.call(path, "Obsidian configuration must live only at the vault root") unless path == ".obsidian" }
if %w[tutorial-pending complete].include?(onboarding_state) && obsidian_dirs != [".obsidian"]
  add_error.call(".obsidian", "expected exactly one root Obsidian configuration")
end

# Privacy and legacy-path checks.
active_markdown.each do |file|
  text = File.read(file)
  SECRET_SHAPES.each do |label, pattern|
    add_error.call(file, "contains #{label}-shaped text") if text.match?(pattern)
  end
  add_error.call(file, "contains old os/now.md route") if text.include?("`os/now.md`")
  add_error.call(file, "contains old root log route") if text.match?(/`log\//)
  add_error.call(file, "contains old business/ container route") if text.match?(/`business\//)
end

required_ignores = {
  "os/.gitignore" => %w[.claude/ .codex/ .env *.key *.pem *recovery-codes*.txt],
  "life/.gitignore" => %w[.claude/ .codex/ 00_inbox/attachments/ corpus-media/ .env *.key *.pem *recovery-codes*.txt]
}
business_entries.each do |name|
  required_ignores["biz/#{name}/.gitignore"] = %w[.claude/ .codex/ node_modules/ .env *.key *.pem *recovery-codes*.txt]
end
required_ignores.each do |file, entries|
  unless File.file?(file)
    add_error.call(file, "missing repository .gitignore")
    next
  end
  lines = File.readlines(file, chomp: true).map(&:strip)
  entries.each { |entry| add_error.call(file, "missing defensive exclusion: #{entry}") unless lines.include?(entry) }
end

if errors.empty?
  puts "PASS Starter.OS: #{audited_files.length} active files; structure, metadata, links, privacy, and repository boundaries clean."
  exit 0
end

puts "FAIL Starter.OS: #{errors.length} issue#{errors.length == 1 ? '' : 's'}"
errors.each { |message| puts "- #{message}" }
exit 1
