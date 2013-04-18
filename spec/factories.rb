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
      end
    end

    factory :wine_with_grapes_b, parent: :wine do
      before(:create) do |wine|
        wine.winery = create(:vineland)
        wine.grapes << build(:grape)
      end
    end
  end
  
  factory :score do
    price 19.95
    
    factory :score_drank, parent: :score do
      before(:create) do |score|
        score.wine = create(:wine_with_grapes_a)
        score.reviewdate = Date.new
        score.score = 86
        score.comments = 'Okay'
        score.in_fridge = false
      end
    end
    
    factory :score_in_cellar, parent: :score do
      before(:create) do |score|
        score.wine = create(:wine_with_grapes_b)
        score.in_fridge = true
        score.from = 2014
        score.to = 2017
        score.score = 0
      end
    end
  end
end