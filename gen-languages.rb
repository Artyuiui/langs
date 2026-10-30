#!/usr/bin/env ruby
# Regenerates the language table in `langs` from GitHub linguist's languages.yml.
# Usage: curl -fsSL https://raw.githubusercontent.com/github-linguist/linguist/main/lib/linguist/languages.yml | ruby gen-languages.rb
require "yaml"
Encoding.default_external = Encoding::UTF_8  # macOS system Ruby defaults to US-ASCII

# Tie-breaker when an extension or filename belongs to several languages (GitHub reads file contents instead).
PREFER = %w[JavaScript TypeScript Python Java C C++ C# Go Rust Ruby PHP Swift Kotlin Objective-C Dart Shell
            HTML CSS SCSS Vue Svelte Lua SQL R Perl Elixir Markdown JSON YAML XML Text TOML INI].freeze

langs = YAML.safe_load($stdin.read)
rgb = ->(hex) { (hex || "#cccccc").delete("#").scan(/../).map { |h| h.to_i(16) }.join(";") }

# Language -> "Name|R;G;B", rolled up into its group the way GitHub's language bar does.
label = {}
langs.each do |name, l|
  shown = l["group"] || name
  label[name] = "#{shown}|#{rgb.(langs.dig(shown, "color") || l["color"])}"
end
counted = ->(name) { %w[programming markup].include?(langs[name]["type"]) }

pick = lambda do |cands|  # cands: [[name, primary?], ...]
  primary = cands.select { |_, p| p }
  cands = primary unless primary.empty?
  cands.map(&:first).min_by { |n| [PREFER.index(n) || PREFER.size, n] }
end

exts = Hash.new { |h, k| h[k] = [] }
files = Hash.new { |h, k| h[k] = [] }
langs.each do |name, l|
  (l["extensions"] || []).each_with_index { |e, i| exts[e.downcase.sub(/\A\./, "")] << [name, i.zero?] }
  (l["filenames"] || []).each { |f| files[f] << [name, false] }
end

safe = ->(s) { s !~ /['"\\]/ }  # the table lives inside a single-quoted awk program
lines = []
{ "L" => exts, "F" => files }.each do |var, table|
  table.sort.each do |key, cands|
    name = pick.(cands)
    lines << %(  #{var}["#{key}"]="#{label[name]}") if counted.(name) && safe.(key) && safe.(label[name])
  end
end

path = File.join(__dir__, "langs")
src = File.read(path)
out = src.sub(/(  # BEGIN GENERATED\n).*(  # END GENERATED\n)/m) { "#{$1}#{lines.join("\n")}\n#{$2}" }
abort "markers not found in #{path}" if out == src && !src.include?("# BEGIN GENERATED")
File.write(path, out)
puts "#{lines.size} entries, #{lines.map { |x| x[/="([^|]+)/, 1] }.uniq.size} languages"
