#!/usr/bin/env ruby

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title IPs
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.packageName IP/Domain Formatter
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "separator" }

# Documentation:
# @raycast.author Nirantak Raghav
# @raycast.authorURL https://nirantak.com
# @raycast.description Transform a list of IPs or Domains in your clipboard into a comma/quote/space separated list

CLIPBOARD_DATA = `pbpaste`
IPs = CLIPBOARD_DATA.scan(/([a-z0-9\-]+\.[a-z0-9\-]+\.[a-z0-9]+\.[a-z0-9]+)/).map { |ip| ip[0] }
SEPARATOR = ARGV[0].downcase.strip

if !IPs.empty?
  if ["q", "quote", '"', "'"].include?(SEPARATOR)
    op = IPs.map { |ip| "\\\"#{ip}\\\"" }.join(",")
  elsif ["c", "comma", ","].include?(SEPARATOR)
    op = IPs.join(",")
  elsif ["s", "space"].include?(SEPARATOR)
    op = IPs.join(" ")
  elsif ["n", "line"].include?(SEPARATOR)
    op = IPs.join("\n")
  else
    puts "Invalid SEPARATOR"
    exit(1)
  end

  puts op.gsub("\\", "")
  `echo #{op} | tr -d '\n' | pbcopy`
else
  puts "No IPs found in clipboard"
  exit(1)
end
