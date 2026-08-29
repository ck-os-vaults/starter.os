#!/usr/bin/env ruby

require "fileutils"
require "pathname"

SOURCE_ROOT = Pathname.new(File.expand_path("..", __dir__))

def stop(message)
  warn "Cannot create vault: #{message}"
  exit 1
end

raw_destination = ARGV.shift
stop("provide the full destination ending in .os") if raw_destination.to_s.strip.empty?
stop("unexpected options: #{ARGV.join(' ')}") unless ARGV.empty?

destination = Pathname.new(File.expand_path(raw_destination))
source_real = SOURCE_ROOT.realpath

stop("the root folder name must end in .os") unless destination.basename.to_s.match?(/\A.+\.os\z/i)
stop("the private vault must be outside the public source") if destination == SOURCE_ROOT || destination.to_s.start_with?("#{source_real}/")
stop("the destination exists and is not a folder") if destination.exist? && !destination.directory?
stop("the destination folder is not empty") if destination.directory? && !destination.children.empty?

%w[os life os/templates/root-AGENTS.txt os/templates/root-CLAUDE.txt].each do |required|
  stop("source path is missing: #{required}") unless SOURCE_ROOT.join(required).exist?
end

FileUtils.mkdir_p(destination)
%w[os life].each do |name|
  FileUtils.cp_r(SOURCE_ROOT.join(name), destination.join(name), preserve: true)
end
FileUtils.cp(SOURCE_ROOT.join("os", "templates", "root-AGENTS.txt"), destination.join("AGENTS.md"), preserve: true)
FileUtils.cp(SOURCE_ROOT.join("os", "templates", "root-CLAUDE.txt"), destination.join("CLAUDE.md"), preserve: true)
FileUtils.mkdir_p(destination.join("biz"))
FileUtils.mkdir_p(destination.join("os", "scripts"))
%w[add-project.rb add-business.rb].each do |script|
  FileUtils.cp(SOURCE_ROOT.join("scripts", script), destination.join("os", "scripts", script), preserve: true)
end

puts "Created #{destination.basename} at #{destination}"
puts "Next: personalize confirmed owner context, then run ruby os/validate-starter-os.rb"
