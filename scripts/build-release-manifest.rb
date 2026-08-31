#!/usr/bin/env ruby

require "digest"
require "find"
require "json"
require "pathname"
require "set"

ROOT = Pathname.new(File.expand_path("..", __dir__))
OUTPUT = ROOT.join("release-manifest.json")
RELEASE_VERSION = "2.0.0"
RELEASE_DATE = "2026-08-30"

OWNER_OWNED = Set.new(%w[
  os/me.md
  os/recovery.md
  os/integrations.md
  life/knowledge-map.md
  life/now.md
  life/wiki/owner.md
  life/records/decisions.md
]).freeze

TARGET_OVERRIDES = {
  "AGENTS.md" => "os/templates/root-AGENTS.txt",
  "CLAUDE.md" => "os/templates/root-CLAUDE.txt",
  "os/scripts/add-project.rb" => "scripts/add-project.rb",
  "os/scripts/add-business.rb" => "scripts/add-business.rb"
}.freeze

def stop(message)
  warn "Cannot build release manifest: #{message}"
  exit 1
end

def safe_relative(raw)
  path = Pathname.new(raw)
  clean = path.cleanpath.to_s
  stop("unsafe path: #{raw}") if path.absolute? || clean == ".." || clean.start_with?("../") || clean != raw
  clean
end

def sha256(path)
  Digest::SHA256.file(path).hexdigest
end

source_targets = {}
Dir.glob(ROOT.join("{os,life}", "**", "*").to_s, File::FNM_DOTMATCH).sort.each do |absolute|
  stop("symbolic links are not allowed in the public release: #{absolute}") if File.symlink?(absolute)
  next unless File.file?(absolute)
  relative = Pathname.new(absolute).relative_path_from(ROOT).to_s
  next if relative == "os/release.json"
  source_targets[relative] = relative
end
TARGET_OVERRIDES.each { |target, source| source_targets[target] = source }

artifacts = source_targets.sort.map do |target, source|
  target = safe_relative(target)
  source = safe_relative(source)
  source_path = ROOT.join(source)
  stop("missing source for #{target}: #{source}") unless source_path.file?

  ownership = OWNER_OWNED.include?(target) ? "owner-owned" : "managed"
  {
    "id" => target,
    "path" => target,
    "source" => source,
    "ownership" => ownership,
    "permitted_editor" => ownership == "managed" ? "Starter.OS update or explicit owner fork" : "owner and approved agents",
    "update" => ownership == "managed" ? "replace-if-unmodified" : "seed-once-then-preserve",
    "deprecation" => "preserve-and-report",
    "sha256" => sha256(source_path)
  }
end

duplicates = artifacts.group_by { |artifact| artifact["path"] }.select { |_path, rows| rows.length > 1 }.keys
stop("duplicate target paths: #{duplicates.join(', ')}") unless duplicates.empty?

distribution_files = []
Find.find(ROOT.to_s) do |absolute|
  relative = Pathname.new(absolute).relative_path_from(ROOT).to_s
  stop("symbolic links are not allowed in the public release: #{relative}") if File.symlink?(absolute)
  if File.directory?(absolute)
    if relative == ".git"
      Find.prune
    else
      next
    end
  end
  next unless File.file?(absolute)
  next if relative == "release-manifest.json"
  distribution_files << {
    "path" => safe_relative(relative),
    "sha256" => sha256(absolute)
  }
end
distribution_files.sort_by! { |entry| entry["path"] }

manifest = {
  "format" => 1,
  "product" => "Starter.OS",
  "version" => RELEASE_VERSION,
  "released" => RELEASE_DATE,
  "supported_updates" => ["unversioned-legacy", RELEASE_VERSION],
  "licenses" => {
    "code" => "MIT",
    "content" => "CC-BY-4.0"
  },
  "directories" => ["biz"],
  "generated" => [
    {
      "path" => "os/release.json",
      "ownership" => "generated",
      "update" => "regenerate-from-release-manifest"
    }
  ],
  "artifacts" => artifacts,
  "distribution_files" => distribution_files
}

OUTPUT.write("#{JSON.pretty_generate(manifest)}\n")
puts "Built #{OUTPUT.basename}: #{artifacts.length} installed artifacts, #{distribution_files.length} public files"
