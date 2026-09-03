#!/usr/bin/env ruby

require "csv"
require "digest"
require "fileutils"
require "json"
require "open3"
require "pathname"

IGNORED_COMPUTER_FILES = %w[.DS_Store .localized Thumbs.db desktop.ini].freeze

def stop(message)
  warn "Migration verification failed: #{message}"
  exit 1
end

def absolute_path(raw, label)
  stop("provide #{label}") if raw.to_s.strip.empty?
  Pathname.new(File.expand_path(raw))
end

def canonical_output(path)
  path.parent.realpath.join(path.basename)
rescue Errno::ENOENT
  path
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

def relative_directories(root)
  Dir.glob(root.join("**", "*").to_s, File::FNM_DOTMATCH).each_with_object([]) do |absolute, directories|
    next unless File.directory?(absolute)
    relative = Pathname.new(absolute).relative_path_from(root).to_s
    next if relative == ".git" || relative.start_with?(".git/") || relative.split("/").include?(".git")
    directories << { "path" => relative, "mode" => File.lstat(absolute).mode & 0o7777 }
  end.sort_by { |entry| entry.fetch("path") }
end

def content_entry(root, relative)
  absolute = root.join(relative)
  if File.symlink?(absolute)
    target = File.readlink(absolute)
    { "path" => relative, "type" => "symlink", "sha256" => Digest::SHA256.hexdigest(target), "size" => target.bytesize, "mode" => File.lstat(absolute).mode & 0o7777 }
  else
    { "path" => relative, "type" => "file", "sha256" => Digest::SHA256.file(absolute).hexdigest, "size" => File.size(absolute), "mode" => File.lstat(absolute).mode & 0o7777 }
  end
end

def git_repository_roots(root)
  Dir.glob(root.join("**", ".git").to_s, File::FNM_DOTMATCH)
    .select { |path| File.directory?(path) || File.file?(path) }
    .map { |path| Pathname.new(path).parent }
    .uniq
    .sort_by(&:to_s)
end

def git_output(repository, *arguments, allow_failure: false)
  output, status = Open3.capture2e("git", "-C", repository.to_s, *arguments)
  stop("cannot inspect Git state at #{repository}: git #{arguments.join(' ')}") unless status.success? || allow_failure
  [output, status.success?]
end

def git_state(root)
  repositories = git_repository_roots(root).map { |repository| [repository, "repository"] }
  enclosing_raw, enclosing_status = Open3.capture2e("git", "-C", root.to_s, "rev-parse", "--show-toplevel")
  if enclosing_status.success?
    enclosing = Pathname.new(enclosing_raw.strip).realpath
    repositories << [enclosing, "enclosing-repository"] unless repositories.any? { |repository, _scope| repository == enclosing }
  end

  repositories.map do |repository, scope|
    relative = scope == "enclosing-repository" || repository == root ? "." : repository.relative_path_from(root).to_s
    top, top_ok = git_output(repository, "rev-parse", "--show-toplevel")
    stop("Git root cannot be resolved for source scope: #{relative}") unless top_ok && Pathname.new(top.strip).realpath == repository.realpath

    head, head_ok = git_output(repository, "rev-parse", "--verify", "HEAD", allow_failure: true)
    head_ref, _head_ref_ok = git_output(repository, "symbolic-ref", "-q", "HEAD", allow_failure: true)
    status_arguments = ["status", "--porcelain=v1", "--untracked-files=all"]
    status_arguments += ["--", root.relative_path_from(repository).to_s] if scope == "enclosing-repository"
    status, = git_output(repository, *status_arguments)
    refs, = git_output(repository, "for-each-ref", "--format=%(refname) %(objectname)")
    config, = git_output(repository, "config", "--local", "--null", "--list")
    git_dir_raw, = git_output(repository, "rev-parse", "--git-dir")
    git_dir = Pathname.new(git_dir_raw.strip)
    git_dir = repository.join(git_dir) unless git_dir.absolute?
    markers = %w[MERGE_HEAD REBASE_HEAD CHERRY_PICK_HEAD REVERT_HEAD].select { |name| git_dir.join(name).exist? }

    {
      "path" => relative,
      "scope" => scope,
      "head" => head_ok ? head.strip : nil,
      "head_ref" => head_ref.strip.empty? ? nil : head_ref.strip,
      "status_sha256" => Digest::SHA256.hexdigest(status),
      "refs_sha256" => Digest::SHA256.hexdigest(refs),
      "config_sha256" => Digest::SHA256.hexdigest(config),
      "operation_markers" => markers
    }
  end
end

def snapshot(root)
  {
    "format" => 2,
    "source" => root.to_s,
    "entries" => relative_content_paths(root).map { |relative| content_entry(root, relative) },
    "directories" => relative_directories(root),
    "git" => git_state(root)
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

def safe_destination(root, relative, label)
  current = root
  Pathname.new(relative).each_filename do |part|
    current = current.join(part)
    stop("#{label} crosses a symbolic link: #{relative}") if current.symlink?
  end
  current
end

command = ARGV.shift

case command
when "snapshot"
  source = absolute_path(ARGV.shift, "the source vault")
  output = canonical_output(absolute_path(ARGV.shift, "the snapshot output path"))
  stop("unexpected options: #{ARGV.join(' ')}") unless ARGV.empty?
  stop("source vault is not a directory") unless source.directory?
  source = source.realpath
  stop("snapshot output must be outside the source vault") if inside?(output, source)
  stop("snapshot output already exists") if output.exist?

  output.dirname.mkpath
  recorded = snapshot(source)
  output.write("#{JSON.pretty_generate(recorded)}\n")
  puts "Snapshot recorded #{recorded.fetch('entries').length} content paths and #{recorded.fetch('git').length} Git repositories at #{output}"

when "verify"
  source = absolute_path(ARGV.shift, "the source vault")
  destination = absolute_path(ARGV.shift, "the destination vault")
  snapshot_path = canonical_output(absolute_path(ARGV.shift, "the source snapshot"))
  manifest_path = canonical_output(absolute_path(ARGV.shift, "the migration map"))
  stop("unexpected options: #{ARGV.join(' ')}") unless ARGV.empty?
  stop("source vault is not a directory") unless source.directory?
  stop("destination vault is not a directory") unless destination.directory?
  source = source.realpath
  destination = destination.realpath
  stop("source and destination must be separate") if inside?(destination, source) || inside?(source, destination)
  stop("source snapshot is missing") unless snapshot_path.file?
  stop("migration map is missing") unless manifest_path.file?

  stored = JSON.parse(snapshot_path.read)
  stop("unsupported snapshot format") unless stored["format"] == 2
  stop("snapshot belongs to a different source: #{stored['source']}") unless stored["source"] == source.to_s
  current = snapshot(source)
  stop("the original vault content changed after its snapshot") unless current["entries"] == stored["entries"] && current["directories"] == stored["directories"]
  stop("the original vault Git state changed after its snapshot") unless current["git"] == stored["git"]

  expected = stored.fetch("entries").to_h { |entry| [entry.fetch("path"), entry] }
  rows = CSV.read(manifest_path, headers: true, col_sep: "\t", liberal_parsing: true)
  required_headers = %w[source_path disposition destination_path reason approved_destination_sha256]
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
    allowed_dispositions = %w[preserve copy transform merge exclude unresolved]
    stop("line #{line} has invalid disposition: #{disposition}") unless allowed_dispositions.include?(disposition)
    counts[disposition] += 1
    approval = row["approved_destination_sha256"].to_s.strip

    if %w[preserve copy].include?(disposition)
      destination_path = safe_relative(row["destination_path"], "line #{line} destination_path")
      target = safe_destination(destination, destination_path, "line #{line} destination path")
      original = expected.fetch(source_path)
      stop("line #{line} source is a symbolic link; use transform after review or leave it unresolved") if original["type"] == "symlink"
      stop("line #{line} copied destination is missing: #{destination_path}") unless target.file? && !target.symlink?
      actual = content_entry(destination, destination_path)
      stop("line #{line} copied bytes do not match: #{source_path} -> #{destination_path}") unless actual.slice("type", "sha256", "size", "mode") == original.slice("type", "sha256", "size", "mode")
      stop("line #{line} preserve or copy must not include an approval digest") unless approval.empty?
    elsif %w[transform merge].include?(disposition)
      destination_path = safe_relative(row["destination_path"], "line #{line} destination_path")
      target = safe_destination(destination, destination_path, "line #{line} destination path")
      stop("line #{line} #{disposition} destination must be a regular file: #{destination_path}") unless target.file? && !target.symlink?
      stop("line #{line} #{disposition} requires a reason") if row["reason"].to_s.strip.empty?
      prefix = File.basename(source_path).match?(/\A(?:AGENTS|CLAUDE)\.md\z/i) ? "instruction-review:" : "approved:"
      expected_approval = "#{prefix}#{Digest::SHA256.file(target).hexdigest}"
      stop("line #{line} #{disposition} requires the reviewed destination digest #{expected_approval}") unless approval == expected_approval
    else
      stop("line #{line} #{disposition} requires a reason") if row["reason"].to_s.strip.empty?
      stop("line #{line} #{disposition} must not name a destination") unless row["destination_path"].to_s.strip.empty?
      stop("line #{line} #{disposition} must not include an approval digest") unless approval.empty?
    end
  end

  missing = expected.keys - seen.keys
  stop("unaccounted source paths: #{missing.first(10).join(', ')}#{missing.length > 10 ? ' ...' : ''}") unless missing.empty?

  required_roots = %w[AGENTS.md CLAUDE.md biz life os]
  allowed_roots = required_roots + %w[.obsidian] + IGNORED_COMPUTER_FILES
  unexpected_roots = destination.children.map { |path| path.basename.to_s }.sort - allowed_roots
  stop("destination has unexpected root paths: #{unexpected_roots.join(', ')}") unless unexpected_roots.empty?
  stop("destination is missing a required root") unless (required_roots - destination.children.map { |path| path.basename.to_s }).empty?
  stop("setup content leaked into the destination") if destination.join("setup").exist?
  %w[life/archive os/archive biz/archive].each do |relative|
    stop("catch-all archive remains in the destination: #{relative}") if destination.join(relative).exist?
  end
  stop("destination vault root must not be a Git repository") if destination.join(".git").exist?
  stop("destination biz container must not be a Git repository") if destination.join("biz", ".git").exist?

  summary = %w[preserve copy transform merge exclude unresolved].map { |name| "#{counts[name]} #{name}" }.join(", ")
  puts "PASS migration: #{expected.length} paths accounted for (#{summary}); source content and recorded Git state unchanged; copied bytes and approved destinations verified; destination boundaries valid"

else
  stop("usage: verify-migration.rb snapshot SOURCE SNAPSHOT | verify SOURCE DESTINATION SNAPSHOT MIGRATION_MAP.tsv")
end
