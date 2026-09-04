#!/usr/bin/env ruby

require "digest"
require "fileutils"
require "json"
require "open3"
require "pathname"
require "time"

SOURCE_ROOT = Pathname.new(File.expand_path("../..", __dir__)).realpath
MANIFEST_PATH = SOURCE_ROOT.join("setup", "release-manifest.json")
LEGACY_MANAGED_ROOT_SHA256 = %w[
  f58afce2dc1578b7863a3a272585604926aad72b80ae18f0bb0ab8b52ea11fe1
].freeze

def stop(message)
  warn "Starter.OS update stopped: #{message}"
  exit 1
end

def safe_relative(raw, label = "path")
  value = raw.to_s.strip
  stop("#{label} is blank") if value.empty?
  path = Pathname.new(value)
  clean = path.cleanpath.to_s
  stop("#{label} is unsafe: #{value}") if path.absolute? || clean == ".." || clean.start_with?("../") || clean != value
  clean
end

def sha256(path)
  Digest::SHA256.file(path).hexdigest
end

def artifact_bytes(source, artifact, target_root)
  bytes = File.binread(source)
  return bytes unless artifact["render"]

  stop("unknown artifact renderer: #{artifact['render']}") unless artifact["render"] == "system-name"
  marker = "{{SYSTEM_NAME}}"
  stop("system-name template is missing its marker: #{artifact['source']}") unless bytes.include?(marker)
  bytes.gsub(marker, target_root.basename.to_s)
end

def inside?(path, root)
  path == root || path.to_s.start_with?("#{root}/")
end

def canonical_existing_root(raw, label)
  path = Pathname.new(File.expand_path(raw))
  stop("#{label} itself may not be a symbolic link") if path.symlink?
  stop("#{label} is not a directory") unless path.directory?
  path.realpath
end

def canonical_new_path(path, label)
  stop("#{label} may not be a symbolic link") if path.symlink?
  stop("#{label} already exists: #{path}") if path.exist?

  missing = []
  current = path
  until current.exist?
    stop("#{label} contains a broken symbolic link: #{current}") if current.symlink?
    parent = current.parent
    stop("cannot resolve #{label}") if parent == current
    missing.unshift(current.basename.to_s)
    current = parent
  end

  stop("#{label} crosses a symbolic link: #{current}") if current.symlink?
  stop("#{label} has a non-directory parent: #{current}") unless current.directory?
  missing.reduce(current.realpath) { |resolved, part| resolved.join(part) }
end

def safe_target(root, relative)
  relative = safe_relative(relative)
  stop("target root is a symbolic link") if root.symlink?
  current = root
  Pathname.new(relative).each_filename do |part|
    current = current.join(part)
    stop("target path crosses a symbolic link: #{relative}") if current.symlink?
  end
  current
end


def safe_source(relative)
  current = SOURCE_ROOT
  Pathname.new(relative).each_filename do |part|
    current = current.join(part)
    stop("artifact source crosses a symbolic link: #{relative}") if current.symlink?
  end
  stop("artifact source is missing: #{relative}") unless current.file?
  stop("artifact source escapes the public source: #{relative}") unless inside?(current.realpath, SOURCE_ROOT)
  current
end

def file_state(path)
  return { "exists" => false, "sha256" => nil } unless path.exist?
  stop("expected a regular file but found another type: #{path}") unless path.file? && !path.symlink?
  { "exists" => true, "sha256" => sha256(path) }
end

def load_manifest
  stop("release manifest is missing; run ruby setup/scripts/build-release-manifest.rb") unless MANIFEST_PATH.file?
  manifest = JSON.parse(MANIFEST_PATH.read)
  stop("unsupported release manifest") unless manifest["format"] == 1 && manifest["product"] == "Starter.OS"
  manifest.fetch("artifacts").each do |artifact|
    source = safe_relative(artifact.fetch("source"), "artifact source")
    source_path = safe_source(source)
    stop("artifact source changed; rebuild the release manifest: #{source}") unless sha256(source_path) == artifact.fetch("sha256")
  end
  manifest
end

def load_release_record(target)
  path = target.join("os", "release.json")
  return nil unless path.file?
  record = JSON.parse(path.read)
  stop("unsupported installed release record") unless record["format"] == 1 && record["product"] == "Starter.OS"
  record
rescue JSON::ParserError => error
  stop("installed release record is invalid JSON: #{error.message}")
end

def recognized_unversioned_starter?(target)
  signatures = {
    "os/AGENTS.md" => /^# Operating rules\s*$/i,
    "os/me.md" => /^type:\s*identity\s*$/i,
    "os/vault-map.md" => /^# vault map\s*$/i,
    "life/AGENTS.md" => /^# Life entry\s*$/i
  }

  root_agents = safe_target(target, "AGENTS.md")
  root_agents.file? && !root_agents.symlink? && signatures.all? do |relative, pattern|
    path = safe_target(target, relative)
    path.file? && !path.symlink? && File.binread(path).force_encoding(Encoding::UTF_8).match?(pattern)
  end
rescue ArgumentError
  false
end

def ensure_update_git_ready(target)
  %w[os life].each do |name|
    repository = target.join(name)
    top, top_status = Open3.capture2e("git", "-C", repository.to_s, "rev-parse", "--show-toplevel")
    stop("#{name}/ is not protected by its own Git repository; establish and commit working Git history before apply") unless top_status.success?

    begin
      resolved_top = Pathname.new(top.strip).realpath
    rescue Errno::ENOENT
      stop("cannot resolve the #{name}/ Git repository")
    end
    stop("#{name}/ is not an independent Git repository") unless resolved_top == repository.realpath

    head, head_status = Open3.capture2e("git", "-C", repository.to_s, "rev-parse", "--verify", "HEAD")
    stop("#{name}/ has no readable recovery commit; create and verify the approved recovery commit before apply") unless head_status.success? && !head.strip.empty?
    _commit, commit_status = Open3.capture2e("git", "-C", repository.to_s, "cat-file", "-e", "#{head.strip}^{commit}")
    stop("#{name}/ recovery commit cannot be read: #{head.strip}") unless commit_status.success?

    git_dir, git_dir_status = Open3.capture2e("git", "-C", repository.to_s, "rev-parse", "--git-dir")
    stop("cannot inspect the #{name}/ Git operation state") unless git_dir_status.success?
    resolved_git_dir = Pathname.new(git_dir.strip)
    resolved_git_dir = repository.join(resolved_git_dir) unless resolved_git_dir.absolute?
    %w[MERGE_HEAD REBASE_HEAD CHERRY_PICK_HEAD REVERT_HEAD].each do |marker|
      stop("#{name}/ has a Git operation in progress: #{marker}") if resolved_git_dir.join(marker).exist?
    end

    status_output, status_status = Open3.capture2e("git", "-C", repository.to_s, "status", "--porcelain")
    stop("cannot inspect #{name}/ Git status") unless status_status.success?
    stop("#{name}/ has uncommitted work; create and verify the approved recovery commit before apply") unless status_output.empty?
  end
end

def build_plan(target, manifest)
  installed = load_release_record(target)
  stop("target is not a recognized unversioned Starter.OS; leave it untouched and create a new installation separately") if installed.nil? && !recognized_unversioned_starter?(target)
  installed_version = installed ? installed.fetch("version") : "unversioned-legacy"
  supported_updates = manifest.fetch("supported_updates", [])
  stop("unsupported update path: #{installed_version} -> #{manifest.fetch('version')}") unless supported_updates.include?(installed_version)
  prior = installed ? installed.fetch("artifacts", {}) : {}
  entries = []
  current_paths = {}

  manifest.fetch("artifacts").each do |artifact|
    path = safe_relative(artifact.fetch("path"), "artifact path")
    current_paths[path] = true
    target_path = safe_target(target, path)
    state = file_state(target_path)
    previous = prior[path]
    ownership = artifact.fetch("ownership")

    action, reason =
      if ownership == "owner-owned"
        if path == "AGENTS.md" && artifact["render"] == "system-name" && state["exists"] && installed.nil? && LEGACY_MANAGED_ROOT_SHA256.include?(state["sha256"])
          ["adopt-owner-entry", "recognized untouched unversioned Starter.OS root entry becomes the owner's named entry"]
        elsif path == "AGENTS.md" && artifact["render"] == "system-name" && state["exists"] && previous && previous["ownership"] == "managed" && state["sha256"] == previous["sha256"]
          ["adopt-owner-entry", "recognized untouched Starter.OS root entry becomes the owner's named entry"]
        elsif state["exists"]
          ["preserve", "owner-owned content is never replaced"]
        elsif previous
          ["conflict", "owner-owned required path is missing; restore the reviewed seed or defer"]
        else
          ["add-seed", "new owner-owned starter file is absent"]
        end
      elsif previous && previous["ownership"] == "forked" && state["exists"]
        ["forked", "explicit owner fork remains untouched"]
      elsif !state["exists"]
        previous ? ["conflict", "managed file is missing"] : ["add", "new managed file"]
      elsif previous && previous["ownership"] == "managed" && state["sha256"] == previous["sha256"]
        state["sha256"] == artifact.fetch("sha256") ? ["unchanged", "already matches target release"] : ["update", "managed file matches its installed baseline"]
      else
        ["conflict", previous ? "managed file changed locally" : "legacy installation has no trusted managed baseline"]
      end

    entries << {
      "path" => path,
      "source" => artifact.fetch("source"),
      "ownership" => ownership,
      "action" => action,
      "reason" => reason,
      "target_exists" => state["exists"],
      "target_sha256" => state["sha256"],
      "source_sha256" => artifact.fetch("sha256")
    }
  end

  prior.each do |path, previous|
    next if current_paths[path]
    path = safe_relative(path, "deprecated path")
    state = file_state(safe_target(target, path))
    entries << {
      "path" => path,
      "ownership" => previous.fetch("ownership", "unknown"),
      "action" => "deprecated-preserve",
      "reason" => "path is absent from the target release and will not be deleted",
      "target_exists" => state["exists"],
      "target_sha256" => state["sha256"],
      "source_sha256" => nil
    }
  end

  {
    "format" => 1,
    "product" => "Starter.OS",
    "created_at" => Time.now.utc.iso8601,
    "source_root" => SOURCE_ROOT.to_s,
    "source_manifest_sha256" => sha256(MANIFEST_PATH),
    "target_root" => target.to_s,
    "installed_version" => installed_version,
    "target_version" => manifest.fetch("version"),
    "entries" => entries.sort_by { |entry| entry["path"] }
  }
end

def print_summary(plan)
  counts = plan.fetch("entries").group_by { |entry| entry.fetch("action") }.transform_values(&:length)
  puts "Starter.OS update plan: #{plan.fetch('installed_version')} -> #{plan.fetch('target_version')}"
  counts.sort.each { |action, count| puts "- #{action}: #{count}" }
  conflicts = plan.fetch("entries").select { |entry| entry["action"] == "conflict" }
  conflicts.each { |entry| puts "  conflict #{entry.fetch('path')}: #{entry.fetch('reason')}" }
end

command = ARGV.shift
manifest = load_manifest

case command
when "plan"
  target_raw = ARGV.shift
  output_raw = ARGV.shift
  stop("usage: update-vault.rb plan TARGET PLAN.json") if target_raw.to_s.empty? || output_raw.to_s.empty? || !ARGV.empty?

  target_path = Pathname.new(File.expand_path(target_raw))
  output = canonical_new_path(Pathname.new(File.expand_path(output_raw)), "plan output")
  stop("target is not a Starter.OS folder") unless target_path.directory? && target_path.join("os").directory? && target_path.join("life").directory?
  target = canonical_existing_root(target_raw, "target")
  stop("target must be outside the public source") if inside?(target, SOURCE_ROOT) || inside?(SOURCE_ROOT, target)
  stop("plan output must be outside the installed vault") if inside?(output, target)

  plan = build_plan(target, manifest)
  output.dirname.mkpath
  output.write("#{JSON.pretty_generate(plan)}\n")
  print_summary(plan)
  puts "Plan written to #{output}"

when "apply"
  target_raw = ARGV.shift
  plan_raw = ARGV.shift
  stop("usage: update-vault.rb apply TARGET PLAN.json --root-backup DIR [--keep PATH] [--replace PATH] [--fork SOURCE=DESTINATION]") if target_raw.to_s.empty? || plan_raw.to_s.empty?

  keep = []
  replace = []
  forks = {}
  root_backup_raw = nil
  until ARGV.empty?
    option = ARGV.shift
    case option
    when "--keep"
      keep << safe_relative(ARGV.shift, "--keep path")
    when "--replace"
      replace << safe_relative(ARGV.shift, "--replace path")
    when "--fork"
      raw = ARGV.shift.to_s
      source, destination = raw.split("=", 2)
      source = safe_relative(source, "--fork source")
      destination = safe_relative(destination, "--fork destination")
      stop("duplicate --fork source: #{source}") if forks.key?(source)
      forks[source] = destination
    when "--root-backup"
      stop("duplicate --root-backup") if root_backup_raw
      root_backup_raw = ARGV.shift.to_s.strip
      stop("--root-backup directory is blank") if root_backup_raw.empty?
    else
      stop("unknown option: #{option}")
    end
  end

  target_path = Pathname.new(File.expand_path(target_raw))
  plan_path = Pathname.new(File.expand_path(plan_raw))
  stop("target is not a Starter.OS folder") unless target_path.directory? && target_path.join("os").directory? && target_path.join("life").directory?
  target = canonical_existing_root(target_raw, "target")
  stop("target must be outside the public source") if inside?(target, SOURCE_ROOT) || inside?(SOURCE_ROOT, target)
  stop("plan file may not be a symbolic link") if plan_path.symlink?
  stop("plan file is missing") unless plan_path.file?
  plan = JSON.parse(plan_path.read)
  stop("unsupported update plan") unless plan["format"] == 1 && plan["product"] == "Starter.OS"
  stop("plan belongs to another target: #{plan['target_root']}") unless plan["target_root"] == target.to_s
  stop("plan belongs to another source checkout") unless plan["source_root"] == SOURCE_ROOT.to_s
  stop("public release manifest changed after planning") unless plan["source_manifest_sha256"] == sha256(MANIFEST_PATH)
  stop("plan targets a different release") unless plan["target_version"] == manifest["version"]

  expected_plan = build_plan(target, manifest)
  comparable_fields = %w[source_root source_manifest_sha256 target_root installed_version target_version entries]
  unless comparable_fields.all? { |field| plan[field] == expected_plan[field] }
    stop("plan contents do not match the current source and target; create and review a new plan")
  end

  ensure_update_git_ready(target)

  entries = plan.fetch("entries")
  by_path = entries.to_h { |entry| [entry.fetch("path"), entry] }
  entries.each do |entry|
    state = file_state(safe_target(target, entry.fetch("path")))
    unless state["exists"] == entry["target_exists"] && state["sha256"] == entry["target_sha256"]
      stop("target changed after planning: #{entry.fetch('path')}")
    end
  end

  choices = keep + replace + forks.keys
  stop("a path has more than one conflict choice") unless choices.uniq.length == choices.length
  choices.each do |path|
    stop("choice does not name a planned conflict: #{path}") unless by_path[path] && by_path[path]["action"] == "conflict"
  end
  choices.each do |path|
    next if by_path.fetch(path)["target_exists"]
    stop("a missing required path can only use --replace: #{path}") unless replace.include?(path)
  end
  stop("use --fork os/manual.md=life/manual.md instead of keeping the protected manual in place") if keep.include?("os/manual.md")
  stop("use --fork CLAUDE.md=life/claude-entry.md instead of keeping the root Claude adapter in place") if keep.include?("CLAUDE.md")
  stop("two forks may not use the same destination") unless forks.values.uniq.length == forks.values.length

  conflicts = entries.select { |entry| entry["action"] == "conflict" }.map { |entry| entry["path"] }
  unresolved = conflicts - choices
  stop("conflicts need an approved --keep, --replace, or --fork choice: #{unresolved.join(', ')}") unless unresolved.empty?

  prepared_forks = forks.map do |source, destination|
    destination_path = safe_target(target, destination)
    stop("fork destination already exists: #{destination}") if destination_path.exist?
    stop("fork destination conflicts with a managed release path: #{destination}") if by_path.key?(destination)
    source_path = safe_target(target, source)
    stop("fork source is missing: #{source}") unless source_path.file?
    [source_path, destination_path]
  end

  planned_new_paths = entries.select do |entry|
    path = entry.fetch("path")
    install = %w[add add-seed update adopt-owner-entry].include?(entry.fetch("action")) || replace.include?(path) || forks.key?(path)
    install && !entry["target_exists"]
  end.map { |entry| entry.fetch("path") }
  new_paths = (planned_new_paths + forks.values).uniq.sort

  stop("--root-backup DIR is required so non-repository root entry files can be restored") unless root_backup_raw
  root_backup = canonical_new_path(Pathname.new(File.expand_path(root_backup_raw)), "root backup")
  stop("root backup must be outside the installed vault") if inside?(root_backup, target) || inside?(target, root_backup)
  stop("root backup must be outside the public source") if inside?(root_backup, SOURCE_ROOT) || inside?(SOURCE_ROOT, root_backup)
  FileUtils.mkdir_p(root_backup)
  stop("root backup changed while it was being created") unless root_backup.realpath == root_backup

  root_files = manifest.fetch("artifacts").map { |artifact| artifact.fetch("path") }.select { |path| !path.include?("/") }.sort
  backup_files = root_files.map do |path|
    source_path = safe_target(target, path)
    unless source_path.exist?
      next { "path" => path, "existed" => false, "sha256" => nil }
    end
    stop("root entry is not a regular file: #{path}") unless source_path.file? && !source_path.symlink?
    backup_path = root_backup.join(path)
    FileUtils.cp(source_path, backup_path, preserve: true)
    digest = sha256(source_path)
    stop("root backup read-back failed: #{path}") unless sha256(backup_path) == digest
    { "path" => path, "existed" => true, "sha256" => digest }
  end
  backup_receipt = {
    "format" => 1,
    "product" => "Starter.OS root backup",
    "created_at" => Time.now.utc.iso8601,
    "target_root" => target.to_s,
    "installed_version" => plan.fetch("installed_version"),
    "target_version" => plan.fetch("target_version"),
    "files" => backup_files,
    "new_paths" => new_paths
  }
  receipt_path = root_backup.join("receipt.json")
  receipt_path.write("#{JSON.pretty_generate(backup_receipt)}\n")
  read_back_receipt = JSON.parse(receipt_path.read)
  stop("root backup receipt read-back failed") unless read_back_receipt == backup_receipt

  prepared_forks.each do |source_path, destination_path|
    FileUtils.mkdir_p(destination_path.dirname)
    FileUtils.cp(source_path, destination_path, preserve: true)
  end

  manifest_by_path = manifest.fetch("artifacts").to_h { |artifact| [artifact.fetch("path"), artifact] }
  entries.each do |entry|
    path = entry.fetch("path")
    action = entry.fetch("action")
    install = %w[add add-seed update adopt-owner-entry].include?(action) || replace.include?(path) || forks.key?(path)
    next unless install
    artifact = manifest_by_path.fetch(path)
    source = safe_source(safe_relative(artifact.fetch("source"), "artifact source"))
    target_path = safe_target(target, path)
    FileUtils.mkdir_p(target_path.dirname)
    if artifact["render"]
      File.binwrite(target_path, artifact_bytes(source, artifact, target))
    else
      FileUtils.cp(source, target_path, preserve: true)
    end
  end

  previous_record = load_release_record(target)
  previous_artifacts = previous_record ? previous_record.fetch("artifacts", {}) : {}
  release_artifacts = {}
  manifest.fetch("artifacts").each do |artifact|
    path = artifact.fetch("path")
    target_path = safe_target(target, path)
    state = file_state(target_path)
    previous = previous_artifacts[path]
    ownership =
      if keep.include?(path) || (previous && previous["ownership"] == "forked" && !replace.include?(path) && !forks.key?(path))
        "forked"
      else
        artifact.fetch("ownership")
      end
    release_artifacts[path] = {
      "ownership" => ownership,
      "sha256" => state["sha256"],
      "upstream_sha256" => artifact.fetch("sha256"),
      "source_version" => manifest.fetch("version")
    }
  end

  retained_forks = previous_record ? previous_record.fetch("forks", []) : []
  retained_forks = retained_forks.reject { |record| forks.key?(record["source"]) }
  new_forks = forks.map do |source, destination|
    {
      "source" => source,
      "destination" => destination,
      "sha256" => sha256(safe_target(target, destination))
    }
  end

  release_record = {
    "format" => 1,
    "product" => "Starter.OS",
    "version" => manifest.fetch("version"),
    "installed_at" => Time.now.utc.iso8601,
    "manifest_sha256" => sha256(MANIFEST_PATH),
    "artifacts" => release_artifacts,
    "forks" => retained_forks + new_forks,
    "deprecated_preserved" => entries.select { |entry| entry["action"] == "deprecated-preserve" && entry["target_exists"] }.map { |entry| entry["path"] }
  }
  target.join("os", "release.json").write("#{JSON.pretty_generate(release_record)}\n")

  applied_plan = build_plan(target, manifest)
  remaining_conflicts = applied_plan.fetch("entries").select { |entry| entry["action"] == "conflict" }
  stop("post-apply state still has conflicts: #{remaining_conflicts.map { |entry| entry['path'] }.join(', ')}") unless remaining_conflicts.empty?

  print_summary(applied_plan)
  puts "Applied Starter.OS #{manifest.fetch('version')}"
  puts "Root entry backup: #{root_backup}"
  puts "Next: run ruby os/validate-starter-os.rb, review the diff, commit to the primary, and verify every enabled mirror"

else
  stop("usage: update-vault.rb plan TARGET PLAN.json | apply TARGET PLAN.json --root-backup DIR [choices]")
end
