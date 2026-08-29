#!/usr/bin/env ruby

require "csv"
require "digest"
require "fileutils"
require "json"
require "pathname"

def stop(message)
  warn "Migration verification failed: #{message}"
  exit 1
end

def absolute_path(raw, label)
  stop("provide #{label}") if raw.to_s.strip.empty?
  Pathname.new(File.expand_path(raw))
end

def inside?(path, root)
  path == root || path.to_s.start_with?("#{root}/")
end

def relative_content_paths(root)
  Dir.glob(root.join("**", "*").to_s, File::FNM_DOTMATCH).each_with_object([]) do |absolute, paths|
    relative = Pathname.new(absolute).relative_path_from(root).to_s
    next if relative == ".git" || relative.start_with?(".git/")
    next unless File.file?(absolute) || File.symlink?(absolute)
    paths << relative
  end.sort
end

def content_entry(root, relative)
  absolute = root.join(relative)
  if File.symlink?(absolute)
    target = File.readlink(absolute)
    { "path" => relative, "type" => "symlink", "sha256" => Digest::SHA256.hexdigest(target), "size" => target.bytesize }
  else
    { "path" => relative, "type" => "file", "sha256" => Digest::SHA256.file(absolute).hexdigest, "size" => File.size(absolute) }
  end
end

def snapshot(root)
  {
    "format" => 1,
    "source" => root.to_s,
    "entries" => relative_content_paths(root).map { |relative| content_entry(root, relative) }
  }
end

def safe_relative(raw, label)
  value = raw.to_s.strip
  stop("#{label} is blank") if value.empty?
  path = Pathname.new(value)
  clean = path.cleanpath.to_s
  stop("#{label} must be a clean relative path: #{value}") if path.absolute? || clean == ".." || clean.start_with?("../") || clean != value
  clean
end

command = ARGV.shift

case command
when "snapshot"
  source = absolute_path(ARGV.shift, "the source vault")
  output = absolute_path(ARGV.shift, "the snapshot output path")
  stop("unexpected options: #{ARGV.join(' ')}") unless ARGV.empty?
  stop("source vault is not a directory") unless source.directory?
  stop("snapshot output must be outside the source vault") if inside?(output, source)
  stop("snapshot output already exists") if output.exist?

  output.dirname.mkpath
  output.write("#{JSON.pretty_generate(snapshot(source))}\n")
  puts "Snapshot recorded #{relative_content_paths(source).length} content paths at #{output}"

when "verify"
  source = absolute_path(ARGV.shift, "the source vault")
  destination = absolute_path(ARGV.shift, "the destination vault")
  snapshot_path = absolute_path(ARGV.shift, "the source snapshot")
  manifest_path = absolute_path(ARGV.shift, "the migration map")
  stop("unexpected options: #{ARGV.join(' ')}") unless ARGV.empty?
  stop("source vault is not a directory") unless source.directory?
  stop("destination vault is not a directory") unless destination.directory?
  stop("source and destination must be separate") if inside?(destination, source) || inside?(source, destination)
  stop("source snapshot is missing") unless snapshot_path.file?
  stop("migration map is missing") unless manifest_path.file?

  stored = JSON.parse(snapshot_path.read)
  stop("unsupported snapshot format") unless stored["format"] == 1
  stop("snapshot belongs to a different source: #{stored['source']}") unless stored["source"] == source.to_s
  current = snapshot(source)
  stop("the original vault changed after its snapshot") unless current["entries"] == stored["entries"]

  expected = stored.fetch("entries").to_h { |entry| [entry.fetch("path"), entry] }
  rows = CSV.read(manifest_path, headers: true, col_sep: "\t", liberal_parsing: true)
  required_headers = %w[source_path disposition destination_path reason]
  stop("migration map headers must be: #{required_headers.join(', ')}") unless rows.headers == required_headers

  seen = {}
  counts = Hash.new(0)
  rows.each_with_index do |row, index|
    line = index + 2
    source_path = safe_relative(row["source_path"], "line #{line} source_path")
    stop("line #{line} duplicates #{source_path}") if seen[source_path]
    stop("line #{line} names a path absent from the source snapshot: #{source_path}") unless expected.key?(source_path)
    seen[source_path] = true

    disposition = row["disposition"].to_s.strip
    stop("line #{line} has invalid disposition: #{disposition}") unless %w[copy exclude unresolved].include?(disposition)
    counts[disposition] += 1

    if disposition == "copy"
      destination_path = safe_relative(row["destination_path"], "line #{line} destination_path")
      target = destination.join(destination_path)
      stop("line #{line} copied destination is missing: #{destination_path}") unless File.file?(target) || File.symlink?(target)
      actual = content_entry(destination, destination_path)
      original = expected.fetch(source_path)
      stop("line #{line} copied bytes do not match: #{source_path} -> #{destination_path}") unless actual.slice("type", "sha256", "size") == original.slice("type", "sha256", "size")
    else
      stop("line #{line} #{disposition} requires a reason") if row["reason"].to_s.strip.empty?
      stop("line #{line} #{disposition} must not name a destination") unless row["destination_path"].to_s.strip.empty?
    end
  end

  missing = expected.keys - seen.keys
  stop("unaccounted source paths: #{missing.first(10).join(', ')}#{missing.length > 10 ? ' ...' : ''}") unless missing.empty?

  required_roots = %w[AGENTS.md CLAUDE.md biz life os]
  allowed_roots = required_roots + %w[.obsidian]
  unexpected_roots = destination.children.map { |path| path.basename.to_s }.sort - allowed_roots
  stop("destination has unexpected root paths: #{unexpected_roots.join(', ')}") unless unexpected_roots.empty?
  stop("destination is missing a required root") unless (required_roots - destination.children.map { |path| path.basename.to_s }).empty?
  stop("setup content leaked into the destination") if destination.join("setup").exist?
  %w[life/archive os/archive biz/archive].each do |relative|
    stop("catch-all archive remains in the destination: #{relative}") if destination.join(relative).exist?
  end
  stop("destination vault root must not be a Git repository") if destination.join(".git").exist?
  stop("destination biz container must not be a Git repository") if destination.join("biz", ".git").exist?

  puts "PASS migration: #{expected.length} paths accounted for (#{counts['copy']} copied, #{counts['exclude']} excluded, #{counts['unresolved']} unresolved); original unchanged; destination boundaries valid"

else
  stop("usage: verify-migration.rb snapshot SOURCE SNAPSHOT | verify SOURCE DESTINATION SNAPSHOT MIGRATION_MAP.tsv")
end
