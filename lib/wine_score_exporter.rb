# coding: utf-8

def create_wine_sentence(wine, winery)
  s = [winery.name, wine.grapes.join(', '), wine.year]
  s << wine.other unless wine.other.empty?
  s << "LCBO# " + wine.lcbo_code unless wine.lcbo_code.empty?
  s << wine.region unless wine.region.empty?
  s.join(', ')
end

def create_wine_score_sentence(score)
  s = [score.wine_price, score.wine_score + '/100', score.comments]
  s << score.from unless score.from.nil?
  s << score.to unless score.to.nil?
  if !score.wine_reviewdate.nil?
    s << '[' + score.wine_reviewdate + ']'
  end
  if score.in_fridge
    s << 'In fridge'
  end
  s.join('. ')
end

Country::COUNTRIES.keys.each do |country|
  puts "#{country}"

  # load all wines for country country
  wines = Wine.where("country = ?", country).order('winery_id asc')

  wines.each do |wine|
    # look up winery
    winery = Winery.find(wine.winery_id)
    winery_sentence = create_wine_sentence(wine, winery)
    print "#{winery_sentence}."
    wine.scores.each do |score|
      wine_score = create_wine_score_sentence(score)
      print " #{wine_score}."
    end

    puts
  end

  # find all scores for wine
  # print out scores

  puts
end
