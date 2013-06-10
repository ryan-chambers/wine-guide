# coding: utf-8

def create_wine_sentence(wine, winery)
  s = [winery.name, wine.grapes.join(', '), wine.year]
  s << wine.other unless wine.other.empty?
  s << wine.region unless wine.region.empty?
  s << "LCBO# " + wine.lcbo_code unless wine.lcbo_code.empty?
  s.join(', ')
end

def create_wine_bottle_sentence(bottle)
  s = [bottle.price, bottle.score.to_s + '/100', bottle.comments]
  if ! bottle.drink_from.nil?
    s << 'From ' + bottle.drink_from.to_s
  end
  s << 'To ' + bottle.drink_to.to_s unless bottle.drink_to.nil?
  if !bottle.wine_reviewdate.nil?
    s << '[' + bottle.wine_reviewdate + ']'
  end
  if bottle.in_fridge
    s << 'In fridge'
  end
  s.join('. ')
end

Country::COUNTRIES.keys.each do |country|
  puts "#{country}"
  puts

  # load all wines for country country
  wines = Wine.where("country = ?", country).order('winery_id asc')

  wines.each do |wine|
    # look up winery
    winery = Winery.find(wine.winery_id)
    winery_sentence = create_wine_sentence(wine, winery)
    print "#{winery_sentence}."
    wine.bottles.each do |bottle|
      wine_bottle = create_wine_bottle_sentence(bottle)
      print " #{wine_bottle}."
    end

    puts
  end

  puts
end
