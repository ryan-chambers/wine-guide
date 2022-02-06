require 'country.rb'
require 'wine.rb'
require 'winery.rb'

class WineScoreExporter

  def create_wine_sentence(wine, winery)
    # p "create sentence for wine #{wine}"
    s = [winery.name.gsub('.', ''), wine.grape.name, wine.year]
    s << wine.other.gsub('.', '') unless wine.other.nil? or wine.other.empty?
    s << wine.region unless wine.region.nil? or wine.region.empty?
    s << "LCBO# " + wine.lcbo_code unless wine.lcbo_code.empty?
    s.join(', ')
  end

  def create_wine_bottle_sentence(bottle)
    s = ['$' + bottle.price.to_s, bottle.score.to_i.to_s + '/100', bottle.comments]
    if ! bottle.bought.nil? # TODO change check to empty string check (eq? '') because "Bought " is being output
      s << 'Bought ' + bottle.bought
    end
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

  NEW_LINE = '
'

  def export_db
    j = Country::COUNTRIES.keys.reduce(StringIO.new) {|out, country|
      l = StringIO.new
      l << "#{country}"
      l << NEW_LINE

      # load all wines for country
      wines = Wine.includes(:grape, :bottles).where("country = ?", country).order('winery_id asc')

      wines.each do |wine|
        # look up winery
        winery = Winery.find(wine.winery_id)
        winery_sentence = create_wine_sentence(wine, winery)
        l << "#{winery_sentence}."
        wine.bottles.each do |bottle|
          wine_bottle = create_wine_bottle_sentence(bottle)
          l << " #{wine_bottle}."
        end
    
         l << NEW_LINE
      end

      l << NEW_LINE
      out << l.string
      out
      }
    j.string
  end
end