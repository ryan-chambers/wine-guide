FactoryGirl.define do
  factory :alvento, class: Winery do
    name 'Alvento' 
  end

  factory :vineland, class: Winery do
    name 'Vineland Estates'
  end

  factory :cavesprings, class: Winery do
    name 'Cave Springs'
  end

  factory :imocali, class: Winery do
    name 'I Mocali'
  end

  factory :sauvignonblanc, class: Grape do
    name 'Sauvignon Blanc'
  end

  factory :vernaccia, class: Grape do
    name 'Vernaccia'
  end

  factory :wine do
    country 'Canada'
    year 2011
    other 'Reserve'

    factory :wine_with_grapes_a, parent: :wine do
      before(:create) do |wine|
        wine.winery = create(:alvento)
        wine.grapes << build(:sauvignonblanc)
        wine.lcbo_code = '123456'
      end
    end

    factory :wine_with_grapes_b, parent: :wine do
      before(:create) do |wine|
        wine.winery = create(:vineland)
        wine.grapes << build(:sauvignonblanc)
      end
    end

    factory :wine_with_grapes_c, parent: :wine do
      before(:create) do |wine|
        wine.winery = create(:cavesprings)
        wine.grapes << build(:sauvignonblanc)
      end
    end

    factory :wine_with_grapes_d, parent: :wine do
      before(:create) do |wine|
        wine.winery = create(:imocali)
        wine.grapes << build(:vernaccia)
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

    factory :bottle_in_cellar_later, parent: :bottle do
      before(:create) do |bottle|
        bottle.wine = create(:wine_with_grapes_b)
        bottle.in_fridge = true
        bottle.from = 2014
        bottle.to = Time.new.strftime('%Y').to_i + 5
        bottle.score = 0
        bottle.bought = 'Apr 2011'
      end
    end

    factory :bottle_in_cellar_sooner, parent: :bottle do
      before(:create) do |bottle|
        bottle.wine = create(:wine_with_grapes_c)
        bottle.in_fridge = true
        bottle.to = Time.new.strftime('%Y').to_i + 1
        bottle.score = 0
        bottle.bought = 'Apr 2012'
      end
    end

    factory :bottle_in_cellar_now, parent: :bottle do
      before(:create) do |bottle|
        bottle.wine = create(:wine_with_grapes_d)
        bottle.in_fridge = true
        bottle.to = Time.new.strftime('%Y').to_i
        bottle.from = Time.new.strftime('%Y').to_i + 1
        bottle.score = 0
        bottle.bought = 'May 2013'
      end
    end
  end
end