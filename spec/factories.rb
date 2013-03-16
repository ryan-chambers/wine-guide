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
end