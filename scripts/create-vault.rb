#!/usr/bin/env ruby

require "fileutils"
require "pathname"

SOURCE_ROOT = Pathname.new(File.expand_path("..", __dir__))
SETUP_SOURCE = SOURCE_ROOT.join("setup")
ADD_BUSINESS = SOURCE_ROOT.join("scripts", "add-business.rb")

def stop(message)
  warn "Cannot create vault: #{message}"
  exit 1
end

raw_destination = ARGV.shift
stop("provide the full destination ending in .os") if raw_destination.to_s.strip.empty?
stop("unexpected options: #{ARGV.join(' ')}") unless ARGV.empty?

destination = Pathname.new(File.expand_path(raw_destination))
source_real = SOURCE_ROOT.realpath

stop("the root folder name must end in .os, such as STARTER.os or ALEX.os") unless destination.basename.to_s.match?(/\A.+\.os\z/i)
if destination == SOURCE_ROOT || destination.to_s.start_with?("#{source_real}/")
  stop("the private vault must be outside the public Starter.OS source")
end
stop("the destination exists and is not a folder") if destination.exist? && !destination.directory?
stop("the destination folder is not empty") if destination.directory? && !destination.children.empty?

%w[AGENTS.md CLAUDE.md os life setup].each do |required|
  stop("source path is missing: #{required}") unless SOURCE_ROOT.join(required).exist?
end
stop("business template is missing") unless SETUP_SOURCE.join("business-template").directory?
stop("business helper is missing") unless ADD_BUSINESS.file?

FileUtils.mkdir_p(destination)
%w[AGENTS.md CLAUDE.md os life setup].each do |name|
  FileUtils.cp_r(SOURCE_ROOT.join(name), destination.join(name), preserve: true)
end
FileUtils.mkdir_p(destination.join("biz"))
FileUtils.cp(ADD_BUSINESS, destination.join("setup", "add-business.rb"), preserve: true)

puts "Created #{destination.basename} at #{destination}"
puts "Next: open that folder as the agent workspace and Obsidian vault."
