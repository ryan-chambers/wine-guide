# coding: utf-8

require 'open-uri'
require 'wine_score_parser'

lines = open(ARGV[0], "r:UTF-8") { |f| 
  f.readlines 
}

current_country = ''
lines.each do |line|
  line = line.chomp
  next if line.empty?

  line = line.force_encoding('UTF-8')

  if(Country.is_country?(line))
    current_country = line
  else
    wine_and_bottles = parse_wine_bottle_line(line, current_country)

   wine = wine_and_bottles[:wine].store
   if(wine)
      wine_and_bottles[:bottles].each do |bottle|
        bottle.store wine
      end
    end
  end
end
