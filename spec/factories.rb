FactoryGirl.define do
  factory :alvento, class: Winery do
    name 'Alvento'
    initialize_with { Winery.find_or_create_by(name: name)}
  end

  factory :vineland, class: Winery do
    name 'Vineland Estates'
    initialize_with { Winery.find_or_create_by(name: name)}
  end

  factory :cavesprings, class: Winery do
    name 'Cave Springs'
    initialize_with { Winery.find_or_create_by(name: name)}
  end

  factory :lailey, class: Winery do
    name 'Lailey'
    initialize_with { Winery.find_or_create_by(name: name)}
  end

  factory :imocali, class: Winery do
    name 'I Mocali'
    initialize_with { Winery.find_or_create_by(name: name)}
  end

  factory :kenwood, class: Winery do
    name 'Kenwood'
    initialize_with { Winery.find_or_create_by(name: name)}
  end
  
  factory :sauvignonblanc, class: Grape do
    name 'Sauvignon Blanc'
    initialize_with { Grape.find_or_create_by(name: name)}
  end

  factory :vernaccia, class: Grape do
    name 'Vernaccia'
    initialize_with { Grape.find_or_create_by(name: name)}
  end

  factory :merlot, class: Grape do
    name 'Merlot'
    initialize_with { Grape.find_or_create_by(name: name)}
  end

  factory :wine do
    year 2011
    other 'Reserve'

    factory :alvento_sauvignonblanc, parent: :wine do
      before(:create) do |wine|
        wine.country = 'Canada'
        wine.region = 'VQA Niagara'
        wine.winery = create(:alvento)
        wine.grapes << create(:sauvignonblanc)
        wine.lcbo_code = '123456'
        wine.other = 'Reserve'
      end
    end

    factory :vineland_sauvignonblanc, parent: :wine do
      before(:create) do |wine|
        wine.country = 'Canada'
        wine.region = 'VQA Niagara'
        wine.winery = create(:vineland)
        wine.grapes << build(:sauvignonblanc)
        wine.lcbo_code = '98765432'
      end
    end

    factory :cavesprings_sauvignonblanc, parent: :wine do
      before(:create) do |wine|
        wine.country = 'Canada'
        wine.region = 'VQA Niagara'
        wine.winery = create(:cavesprings)
        wine.grapes << build(:sauvignonblanc)
      end
    end

    factory :imocali_vernaccia, parent: :wine do
      before(:create) do |wine|
        wine.country = 'Italy'
        wine.winery = create(:imocali)
        wine.grapes << build(:vernaccia)
      end
    end

    factory :kenwood_merlot, parent: :wine do
      before(:create) do |wine|
        wine.country = 'USA'
        wine.winery = create(:kenwood)
        wine.grapes << build(:merlot)
      end
    end

    factory :lailey_merlot, parent: :wine do
      before(:create) do |wine|
        wine.country = 'Canada'
        wine.winery = create(:lailey)
        wine.grapes << build(:merlot)
      end
    end
  end

  factory :bottle do
    price 19.95

    factory :alvento_sauvignonblanc_bottle_drank, parent: :bottle do
      before(:create) do |bottle|
        bottle.wine = create(:alvento_sauvignonblanc)
        bottle.reviewdate = Time.new.strftime('%d %b %Y')
        bottle.score = 86
        bottle.comments = 'Okay'
        bottle.in_fridge = false
        bottle.price = 19.95
      end
    end

    factory :kenwood_merlot_drank, parent: :bottle do
      before(:create) do |bottle|
        bottle.wine = create(:kenwood_merlot)
        bottle.reviewdate = -2.days.from_now.strftime('%d %b %Y')
        bottle.score = 93
        bottle.comments = 'Fantastic'
        bottle.in_fridge = false
        bottle.price = 29.95
      end
    end

    factory :vineland_sauvignonblanc_drank, parent: :bottle do
      before(:create) do |bottle|
        bottle.wine = create(:vineland_sauvignonblanc)
        bottle.reviewdate = -4.days.from_now.strftime('%d %b %Y')
        bottle.score = 87
        bottle.comments = 'Good'
        bottle.in_fridge = false
        bottle.price = 14.95
      end
    end

    factory :vineland_sauvignonblanc_bottle_in_cellar_later, parent: :bottle do
      before(:create) do |bottle|
        bottle.wine = create(:vineland_sauvignonblanc)
        bottle.comments = 'RRR'
        bottle.in_fridge = true
        bottle.drink_from = Time.new.strftime('%Y').to_i + 3
        bottle.drink_to = Time.new.strftime('%Y').to_i + 5
        bottle.bought = 'Apr 2011'
      end
    end

    factory :cavesprings_sauvignonblanc_bottle_in_cellar_sooner, parent: :bottle do
      before(:create) do |bottle|
        bottle.wine = create(:cavesprings_sauvignonblanc)
        bottle.comments = 'RRR'
        bottle.in_fridge = true
        bottle.drink_to = Time.new.strftime('%Y').to_i + 1
        bottle.bought = 'Apr 2012'
      end
    end

    factory :imocali_vernaccia_bottle_now, parent: :bottle do
      before(:create) do |bottle|
        bottle.wine = create(:imocali_vernaccia)
        bottle.in_fridge = true
        bottle.comments = 'RRR'
        bottle.drink_to = Time.new.strftime('%Y').to_i + 1
        bottle.drink_from = Time.new.strftime('%Y').to_i
        bottle.bought = 'May 2013'
      end
    end
  end
end