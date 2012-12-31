# coding: utf-8

require 'country.rb'

Country::COUNTRIES.keys.each do |country|
  puts "#{country}"

  # load all wines for country country
#  wines = Wine.find(:all, :conditions => [ "country = ?", country], :order => 'winery_id DESC')
  wines = Wine.where("country = ?", country).order('winery_id asc')

  wines.each do |wine|
    # p "#{wine}"

    # look up winery
    winery = Winery.find(wine.winery_id)
    puts "#{winery.name}"
  end

  # find all scores for wine
  # print out scores

  puts
end
