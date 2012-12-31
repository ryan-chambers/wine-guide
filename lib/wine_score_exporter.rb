# coding: utf-8

def create_wine_sentence(wine, winery)
  s = [winery.name, wine.grapes.join(', '), wine.year]
  s << wine.other unless wine.other.empty?
  s << "LCBO# " + wine.lcbo_code unless wine.lcbo_code.empty?
  s << wine.region unless wine.region.empty?
  s.join(', ')
end

Country::COUNTRIES.keys.each do |country|
  puts "#{country}"

  # load all wines for country country
#  wines = Wine.find(:all, :conditions => [ "country = ?", country], :order => 'winery_id DESC')
  wines = Wine.where("country = ?", country).order('winery_id asc')

  wines.each do |wine|
    # p "#{wine}"

    # look up winery
    winery = Winery.find(wine.winery_id)
    winery_sentence = create_wine_sentence(wine, winery)
    puts "#{winery_sentence}. "
  end

  # find all scores for wine
  # print out scores

  puts
end
