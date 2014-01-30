#!/usr/bin/env ruby

require "./save_game"
require "./localization"

unless ARGV.size == 1
  STDERR.puts "Usage: #{$0} <file.sav>"
  exit 1
end

save_path = ARGV[0]

SaveGame.new(save_path).parse do |x|
  if x[:countries]
    x[:countries].each do |country_data|
      tag = country_data.keys[0]
      country_name = localization[tag.to_s] || tag
      tech_group = country_data.values[0].find{|n| n[:technology_group]}
      tech_group &&= tech_group.values[0]
      puts [country_name, tech_group || "-"].join("\t")
    end
  end
end
