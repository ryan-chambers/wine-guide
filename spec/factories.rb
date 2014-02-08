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

  factory :lailey, class: Winery do
    name 'Lailey'
  end

  factory :imocali, class: Winery do
    name 'I Mocali'
  end

  factory :kenwood, class: Winery do
    name 'Kenwood'
  end
  
  factory :sauvignonblanc, class: Grape do
    name 'Sauvignon Blanc'
  end

  factory :vernaccia, class: Grape do
    name 'Vernaccia'
  end

  factory :merlot, class:Grape do
    name 'Merlot'
  end

  factory :wine do
    year 2011
    other 'Reserve'

    factory :wine_with_grapes_a, parent: :wine do
      before(:create) do |wine|
        wine.country = 'Canada'
        wine.region = 'VQA Niagara'
        wine.winery = create(:alvento)
        wine.grapes << build(:sauvignonblanc)
        wine.lcbo_code = '123456'
        wine.other = 'Reserve'
      end
    end

    factory :wine_with_grapes_b, parent: :wine do
      before(:create) do |wine|
        wine.country = 'Canada'
        wine.region = 'VQA Niagara'
        wine.winery = create(:vineland)
        wine.grapes << build(:sauvignonblanc)
        wine.lcbo_code = '98765432'
      end
    end

    factory :wine_with_grapes_c, parent: :wine do
      before(:create) do |wine|
        wine.country = 'Canada'
        wine.region = 'VQA Niagara'
        wine.winery = create(:cavesprings)
        wine.grapes << build(:sauvignonblanc)
      end
    end

    factory :wine_with_grapes_d, parent: :wine do
      before(:create) do |wine|
        wine.country = 'Italy'
        wine.winery = create(:imocali)
        wine.grapes << build(:vernaccia)
      end
    end

    factory :wine_with_grapes_e, parent: :wine do
      before(:create) do |wine|
        wine.country = 'USA'
        wine.winery = create(:kenwood)
        wine.grapes << build(:merlot)
      end
    end

    factory :wine_lailey_merlot, parent: :wine do
      before(:create) do |wine|
        wine.country = 'Canada'
        wine.winery = create(:lailey)
        wine.grapes << build(:merlot)
      end
    end
  end

  factory :bottle do
    price 19.95

    factory :bottle_drank, parent: :bottle do
      before(:create) do |bottle|
        bottle.wine = create(:wine_with_grapes_a)
        bottle.reviewdate = Time.new.strftime('%d %b %Y')
        bottle.score = 86
        bottle.comments = 'Okay'
        bottle.in_fridge = false
        bottle.price = 19.95
      end
    end

    factory :bottle_drank_2, parent: :bottle do
      before(:create) do |bottle|
        bottle.wine = create(:wine_with_grapes_e)
        bottle.reviewdate = -2.days.from_now.strftime('%d %b %Y')
        bottle.score = 93
        bottle.comments = 'Fantastic'
        bottle.in_fridge = false
        bottle.price = 29.95
      end
    end

    factory :bottle_drank_3, parent: :bottle do
      before(:create) do |bottle|
        bottle.wine = create(:wine_with_grapes_c)
        bottle.reviewdate = -4.days.from_now.strftime('%d %b %Y')
        bottle.score = 87
        bottle.comments = 'Good'
        bottle.in_fridge = false
        bottle.price = 14.95
      end
    end

    factory :bottle_in_cellar_later, parent: :bottle do
      before(:create) do |bottle|
        bottle.wine = create(:wine_with_grapes_b)
        bottle.comments = 'RRR'
        bottle.in_fridge = true
        bottle.drink_from = Time.new.strftime('%Y').to_i + 3
        bottle.drink_to = Time.new.strftime('%Y').to_i + 5
        bottle.bought = 'Apr 2011'
      end
    end

    factory :bottle_in_cellar_sooner, parent: :bottle do
      before(:create) do |bottle|
        bottle.wine = create(:wine_with_grapes_c)
        bottle.comments = 'RRR'
        bottle.in_fridge = true
        bottle.drink_to = Time.new.strftime('%Y').to_i + 1
        bottle.bought = 'Apr 2012'
      end
    end

    factory :bottle_in_cellar_now, parent: :bottle do
      before(:create) do |bottle|
        bottle.wine = create(:wine_with_grapes_d)
        bottle.in_fridge = true
        bottle.comments = 'RRR'
        bottle.drink_to = Time.new.strftime('%Y').to_i + 1
        bottle.drink_from = Time.new.strftime('%Y').to_i
        bottle.bought = 'May 2013'
      end
    end
  end
end