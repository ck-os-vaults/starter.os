#!/usr/bin/env ruby

require "date"
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
  "type" => %w[note map identity skill daily weekly monthly decision-log history status],
  "status" => %w[living draft superseded done archived],
  "authority" => %w[canon spec reference exploratory],
  "source" => %w[owner ai]
}.freeze
PERSONAL_LEAKS = {
  "CK identity" => /\bCK\b/,
  "Cristian identity" => /\bCristian\b/i,
  "ABC business" => /\bABC(?:\.OS)?\b/,
  "UIG knowledge" => /\bUIG\b/,
  "source username" => /abc-ck|agent-hub/i,
  "source personal context" => /\b(?:Jenna|Iggy's|Nashville)\b/i
}.freeze
SECRET_SHAPES = {
  "private key" => /-----BEGIN (?:RSA |EC |OPENSSH )?PRIVATE KEY-----/,
  "GitHub token" => /(?:ghp|gho|github_pat)_[A-Za-z0-9_]{20,}/,
  "OpenAI key" => /sk-[A-Za-z0-9_-]{20,}/,
  "Anthropic key" => /sk-ant-[A-Za-z0-9_-]{20,}/,
  "AWS key" => /AKIA[0-9A-Z]{16}/
}.freeze

all_markdown = Dir["**/*.md"].sort
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

  summary_required = %w[note map identity status history].include?(data["type"]) || data["type"] == "decision-log"
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

TEMPLATE_EXEMPTIONS.each do |file|
  text = File.read(file)
  next if File.basename(file) == "project-agents.md"

  %w[type created reviewed status authority source].each do |key|
    add_error.call(file, "template is missing #{key}") unless text.match?(/^#{Regexp.escape(key)}:/)
  end
end

# Validate Markdown links in active files.
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

# Validate active wikilinks by path or unique active filename.
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

# Every active content record must be named in a map/index.
index_files = metadata.select { |_file, data| data["type"] == "map" }.keys | ["knowledge-map.md"]
index_corpus = index_files.to_h { |file| [file, File.read(file)] }
content_files = metadata.reject { |_file, data| data["type"] == "map" }.keys
content_files.each do |file|
  basename = File.basename(file)
  stem = File.basename(file, ".md")
  covered = index_corpus.any? { |_map, text| text.include?(basename) || text.include?("[[#{stem}") }
  add_error.call(file, "not named in any map or folder index") unless covered
end

# The distributable starter must remain free of source-owner context and secret-shaped values.
(active_markdown + ENTRY_EXEMPTIONS + TEMPLATE_EXEMPTIONS).uniq.each do |file|
  text = File.read(file)
  PERSONAL_LEAKS.each do |label, pattern|
    add_error.call(file, "contains #{label} from the source system") if text.match?(pattern)
  end
  SECRET_SHAPES.each do |label, pattern|
    add_error.call(file, "contains #{label}-shaped text") if text.match?(pattern)
  end
end

required_ignores = %w[.obsidian/ .claude/ .codex/ .trash/ .env *.key *.pem]
ignore_text = File.read(".gitignore")
required_ignores.each do |entry|
  add_error.call(".gitignore", "missing defensive exclusion: #{entry}") unless ignore_text.lines.map(&:strip).include?(entry)
end

if errors.empty?
  puts "PASS starter: #{audited_files.length} active files, #{content_files.length} content records, privacy and structure clean."
  exit 0
end

puts "FAIL starter: #{errors.length} issue#{errors.length == 1 ? '' : 's'}"
errors.each { |message| puts "- #{message}" }
exit 1
