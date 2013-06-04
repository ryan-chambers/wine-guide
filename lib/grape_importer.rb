# coding: utf-8

grape = ARGV.join(' ')

normalized_grape_name = grape.split(/(\W)/).map(&:capitalize).join
existing_grape = Grape.where(:name => normalized_grape_name)

# p "#{existing_grape.exists?}"

if ! existing_grape.exists?
  puts "Creating new grape #{normalized_grape_name}"
  new_grape = Grape.new
  new_grape.name = normalized_grape_name
  if new_grape.save
    puts "Saved new grape #{normalized_grape_name}"
  else
    puts "Got an error saving grape #{normalized_grape_name}"
  end
else
  puts "#{normalized_grape_name} already exists"
end
