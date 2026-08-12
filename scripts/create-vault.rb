#!/usr/bin/env ruby

require "fileutils"
require "pathname"

KIT_ROOT = Pathname.new(File.expand_path("..", __dir__))
VAULT_TEMPLATE = KIT_ROOT.join("template", "vault")
BUSINESS_TEMPLATE = KIT_ROOT.join("template", "business")
SETUP_SOURCE = KIT_ROOT.join("setup")
ADD_BUSINESS = KIT_ROOT.join("scripts", "add-business.rb")

def stop(message)
  warn "Cannot create vault: #{message}"
  exit 1
end

raw_destination = ARGV.shift
stop("provide one destination path") if raw_destination.to_s.strip.empty?
stop("unexpected options: #{ARGV.join(' ')}") unless ARGV.empty?

destination = Pathname.new(File.expand_path(raw_destination))
kit_real = KIT_ROOT.realpath
destination_parent = destination.parent.exist? ? destination.parent.realpath : destination.parent

if destination == KIT_ROOT || destination.to_s.start_with?("#{kit_real}/")
  stop("the private vault must be outside the public Starter.OS kit")
end

if destination.exist? && !destination.directory?
  stop("the destination exists and is not a folder")
end

if destination.directory? && !destination.children.empty?
  stop("the destination folder is not empty")
end

[VAULT_TEMPLATE, BUSINESS_TEMPLATE, SETUP_SOURCE, ADD_BUSINESS].each do |required|
  stop("kit file is missing: #{required.relative_path_from(KIT_ROOT)}") unless required.exist?
end

FileUtils.mkdir_p(destination)

VAULT_TEMPLATE.children.each do |entry|
  FileUtils.cp_r(entry, destination.join(entry.basename), preserve: true)
end

FileUtils.mkdir_p(destination.join("biz"))
FileUtils.cp_r(SETUP_SOURCE, destination.join("setup"), preserve: true)
FileUtils.cp_r(BUSINESS_TEMPLATE, destination.join("setup", "business-template"), preserve: true)
FileUtils.cp(ADD_BUSINESS, destination.join("setup", "add-business.rb"), preserve: true)

puts "Created Starter.OS vault shell at #{destination}"
puts "Next: open that folder as the agent workspace and Obsidian vault."
