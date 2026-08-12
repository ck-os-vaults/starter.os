#!/usr/bin/env ruby

require "fileutils"
require "pathname"

SETUP_DIR = Pathname.new(__dir__)
VAULT_ROOT = SETUP_DIR.parent
MODEL = VAULT_ROOT.join("biz", "business-model")

def stop(message)
  warn "Cannot name first business: #{message}"
  exit 1
end

name = ARGV.shift.to_s.strip
stop("provide one lowercase kebab-case business name") if name.empty?
stop("unexpected options: #{ARGV.join(' ')}") unless ARGV.empty?
stop("use lowercase kebab-case, such as north-star-studio") unless name.match?(/\A[a-z0-9]+(?:-[a-z0-9]+)*\z/)
stop("the generic business model is missing or was already named") unless MODEL.directory?
stop("run this copied helper from the generated vault's setup folder") unless VAULT_ROOT.join("os", "vault-map.md").file?

destination = VAULT_ROOT.join("biz", name)
stop("#{destination} already exists") if destination.exist?

FileUtils.mv(MODEL, destination)

puts "Named the first business workspace biz/#{name}/"
puts "Next: personalize its foundations before initializing Git."
