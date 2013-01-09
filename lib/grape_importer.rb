# coding: utf-8

grape = ARGV.join(' ')

existing_grape = Grape.where(:name => grape)

if existing_grape
  puts "Creating new grape #{grape}"
  new_grape = Grape.new
  new_grape.name = grape
  if new_grape.save
    puts "Saved new grape #{grape}"
  else
    puts "Got an error saving grape #{grape}"
  end
else
  puts "#{grape} already exists"
end
