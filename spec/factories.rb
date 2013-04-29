FactoryGirl.define do
  factory :alvento, class: Winery do
    name 'Alvento' 
  end

  factory :vineland, class: Winery do
    name 'Vineland Estates'
  end

  factory :grape do
    name 'Sauvignon Blanc'
  end

  factory :wine do
    country 'Canada'
    year 2011
    other 'Reserve'

    factory :wine_with_grapes_a, parent: :wine do
      before(:create) do |wine|
        wine.winery = create(:alvento)
        wine.grapes << build(:grape)
        wine.lcbo_code = '123456'
      end
    end

    factory :wine_with_grapes_b, parent: :wine do
      before(:create) do |wine|
        wine.winery = create(:vineland)
        wine.grapes << build(:grape)
      end
    end
  end
  
  factory :bottle do
    price 19.95

    factory :bottle_drank, parent: :bottle do
      before(:create) do |bottle|
        bottle.wine = create(:wine_with_grapes_a)
        bottle.reviewdate = Date.new
        bottle.score = 86
        bottle.comments = 'Okay'
        bottle.in_fridge = false
      end
    end

    factory :bottle_in_cellar, parent: :bottle do
      before(:create) do |bottle|
        bottle.wine = create(:wine_with_grapes_b)
        bottle.in_fridge = true
        bottle.from = 2014
        bottle.to = 2017
        bottle.score = 0
        bottle.bought = 'Apr 2012'
      end
    end
  end
end