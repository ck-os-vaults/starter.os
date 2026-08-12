#!/usr/bin/env ruby

require "date"
require "open3"
require "pathname"
require "yaml"

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

ROOT = Pathname.new(File.expand_path("..", __dir__))
Dir.chdir(ROOT)

ENTRY_EXEMPTIONS = %w[AGENTS.md CLAUDE.md].freeze
TEMPLATE_EXEMPTIONS = Dir["agent/templates/*.md"].reject { |file| File.basename(file) == "readme.md" }.freeze
REQUIRED_KEYS = %w[type created reviewed status authority source].freeze
ALLOWED = {
  "type" => %w[note map identity skill spec handoff daily weekly monthly journal decision-log status],
  "status" => %w[living draft superseded done archived],
  "authority" => %w[canon spec reference exploratory],
  "source" => %w[owner ai]
}.freeze
LOCAL_PRIVACY_DENYLIST = ".starter-private-denylist"
SECRET_SHAPES = {
  "private key" => /-----BEGIN (?:RSA |EC |OPENSSH )?PRIVATE KEY-----/,
  "GitHub token" => /(?:ghp|gho|github_pat)_[A-Za-z0-9_]{20,}/,
  "OpenAI key" => /sk-[A-Za-z0-9_-]{20,}/,
  "Anthropic key" => /sk-ant-[A-Za-z0-9_-]{20,}/,
  "AWS key" => /AKIA[0-9A-Z]{16}/
}.freeze
RETIRED_BRAND = /\blife(?:[.\s_-]+)os\b/i
ONBOARDING_STATES = %w[not-started in-progress tutorial-pending complete].freeze
TEMPORARY_SETUP_FILES = %w[
  setup/README.md
  setup/FIRST-CHAT.md
  setup/INSTALL.md
  setup/SHORT-GUIDE.md
  setup/POST-SETUP-TUTORIAL.md
  setup/SETUP-STATUS.md
  setup/AGENT-RUNBOOK.md
  setup/ONBOARDING-INTERVIEW.md
  setup/OPERATOR-GUIDE.md
].freeze

git_files, git_status = Open3.capture2e(
  "git", "ls-files", "--cached", "--others", "--exclude-standard", "--", "*.md"
)
all_markdown = if git_status.success?
  git_files.lines.map(&:strip).reject(&:empty?).select { |file| File.file?(file) }.sort
else
  Dir["**/*.md"].reject { |file| file.start_with?(".git/") }.sort
end

active_markdown = all_markdown.reject do |file|
  file.start_with?(".trash/") || (file.start_with?("archive/") && file != "archive/readme.md")
end
audited_files = active_markdown - ENTRY_EXEMPTIONS - TEMPLATE_EXEMPTIONS

errors = []
metadata = {}

add_error = lambda do |file, message|
  errors << "#{file}: #{message}"
end

audited_files.each do |file|
  text = File.read(file)
  add_error.call(file, "retired predecessor branding remains in active content") if text.match?(RETIRED_BRAND)
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
    rescue Date::Error
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

# Once onboarding is complete, temporary setup scaffolding must leave active context.
starter_version = metadata["os/starter-version.md"] || {}
onboarding_state = starter_version["onboarding"].to_s
unless ONBOARDING_STATES.include?(onboarding_state)
  add_error.call("os/starter-version.md", "invalid onboarding state: #{onboarding_state.inspect}")
end

if ONBOARDING_STATES.include?(onboarding_state)
  visible_state = File.read("os/starter-version.md").match(/^- Onboarding state: `([^`]+)`$/)&.captures&.first
  if visible_state != onboarding_state
    add_error.call("os/starter-version.md", "visible onboarding state does not match frontmatter")
  end
end

if onboarding_state == "complete"
  add_error.call("setup/", "temporary setup folder remains active after onboarding completion") if Dir.exist?("setup")
  TEMPORARY_SETUP_FILES.each do |file|
    add_error.call(file, "setup file remains active after onboarding completion") if File.exist?(file)
  end
  add_error.call("log/setup-completion.md", "missing after onboarding completion") unless File.exist?("log/setup-completion.md")

  active_markdown.each do |file|
    next if file == "log/setup-completion.md"

    text = File.read(file)
    TEMPORARY_SETUP_FILES.each do |temporary|
      if text.include?(temporary)
        add_error.call(file, "still routes to archived setup file: #{temporary}")
      end
    end
  end
end

TEMPLATE_EXEMPTIONS.each do |file|
  text = File.read(file)
  next if File.basename(file) == "project-agents.md"

  %w[type created reviewed status authority source].each do |key|
    add_error.call(file, "template is missing #{key}") unless text.match?(/^#{Regexp.escape(key)}:/)
  end
end

# Validate local Markdown links in active files.
audited_files.each do |file|
  next if metadata.dig(file, "status") == "archived"

  File.read(file).scan(/\[[^\]]*\]\(([^)]+)\)/).flatten.each do |raw|
    target = raw.split("#", 2).first.strip
    next if target.empty? || target.match?(%r{\A(?:https?://|mailto:|data:)})

    target = target[1..-2] if target.start_with?("<") && target.end_with?(">")
    resolved = Pathname(file).dirname.join(target).cleanpath
    add_error.call(file, "broken Markdown link: #{target}") unless resolved.exist?
  end
end

# Validate active wikilinks by direct path or unique active filename.
audited_files.each do |file|
  next if metadata.dig(file, "status") == "archived"

  link_text = File.read(file).gsub(/```.*?```/m, "")
  link_text.scan(/\[\[([^\]|#]+)(?:#[^\]|]+)?(?:\|[^\]]+)?\]\]/).flatten.each do |raw|
    target = raw.strip.sub(/\.md\z/, "")
    direct = "#{target}.md"
    by_name = active_markdown.select { |candidate| File.basename(candidate, ".md").casecmp?(File.basename(target)) }
    resolved = File.exist?(direct) || by_name.length == 1
    add_error.call(file, "unresolved or ambiguous wikilink: #{raw}") unless resolved
  end
end

# Validate root routes and keep instructions narrow.
map_text = File.read("knowledge-map.md")
map_text.scan(/`([^`]+(?:\.md|\/))`/).flatten.uniq.each do |target|
  add_error.call("knowledge-map.md", "broken routed path: #{target}") unless Pathname(target).exist?
end
map_text.lines.each_with_index do |line, index|
  path_count = line.scan(/`([^`]+(?:\.md|\/))`/).flatten.uniq.length
  add_error.call("knowledge-map.md", "line #{index + 1} routes to #{path_count} paths; split by intent") if path_count > 4
end

# Every active content record must be named in a map/index. Date-named log streams index themselves.
index_files = metadata.select { |_file, data| data["type"] == "map" }.keys | ["knowledge-map.md"]
index_corpus = index_files.to_h { |file| [file, File.read(file)] }
content_files = metadata.reject { |_file, data| data["type"] == "map" }.keys
content_files = content_files.reject do |file|
  file.match?(%r{\Alog/(?:daily|weekly|monthly|journal)/(?:\d{4}/)?\d{4}-})
end
content_files.each do |file|
  basename = File.basename(file)
  stem = File.basename(file, ".md")
  covered = index_corpus.any? { |_map, text| text.include?(basename) || text.include?("[[#{stem}") }
  add_error.call(file, "not named in any map or folder index") unless covered
end

# An optional ignored local denylist catches source-owner terms without publishing them.
privacy_terms = if File.file?(LOCAL_PRIVACY_DENYLIST)
  File.readlines(LOCAL_PRIVACY_DENYLIST, chomp: true)
    .map(&:strip)
    .reject { |line| line.empty? || line.start_with?("#") }
else
  []
end

# The distributable starter must remain free of locally denied terms and secret-shaped values.
active_markdown.each do |file|
  text = File.read(file)
  privacy_terms.each do |term|
    if text.match?(/#{Regexp.escape(term)}/i)
      add_error.call(file, "contains a term from the local starter privacy denylist")
    end
  end
  SECRET_SHAPES.each do |label, pattern|
    add_error.call(file, "contains #{label}-shaped text") if text.match?(pattern)
  end
end

required_ignores = %w[
  .obsidian/
  .claude/
  .codex/
  .trash/
  00_inbox/attachments/
  corpus-media/
  .env
  *.key
  *.pem
  *recovery-codes*.txt
  .starter-private-denylist
].freeze
ignore_lines = File.read(".gitignore").lines.map(&:strip)
required_ignores.each do |entry|
  add_error.call(".gitignore", "missing defensive exclusion: #{entry}") unless ignore_lines.include?(entry)
end

if errors.empty?
  puts "PASS starter: #{audited_files.length} active files, #{content_files.length} content records, privacy and structure clean."
  exit 0
end

puts "FAIL starter: #{errors.length} issue#{errors.length == 1 ? '' : 's'}"
errors.each { |message| puts "- #{message}" }
exit 1
