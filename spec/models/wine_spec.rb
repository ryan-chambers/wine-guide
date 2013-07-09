require 'spec_helper'

describe Wine do
  describe "validations" do
    before do
      @wine = Wine.new
      @wine.should_not be_valid
    end

    [:year, :country].each do |attr|
      it "must have #{attr}" do
        @wine.errors.get(attr).should_not be_nil
      end
    end
  end

  describe "bottles" do
    it "knows its favourite bottles don't have scores less than 90" do
      b1 = create(:bottle_drank)

      expect(b1.wine.favourite_bottles).to eq([])
    end    

    it "knows its favourite bottles have scores greater or equal to 90" do
      b1 = create(:bottle_drank_2)

      expect(b1.wine.favourite_bottles).to eq([b1])
    end    
  end

  describe "finders" do
    it "finds all wines with scores greater than 90" do
      b1 = create(:bottle_drank)
      b2 = create(:bottle_drank_2)

      expect(Wine.find_favourites 90).to eq([b2.wine])
    end

    it "finds all wines with bottles indicating they are in the cellar" do
      s1 = create(:bottle_drank)
      s2 = create(:bottle_in_cellar_later)
      s3 = create(:bottle_in_cellar_sooner)
      s4 = create(:bottle_in_cellar_now)

      expect(Wine.find_in_cellar).to eq([s2.wine, s3.wine, s4.wine])
    end

    it "finds all wines that will be ready to drink in the next two years" do
      s1 = create(:bottle_in_cellar_later)
      s2 = create(:bottle_in_cellar_sooner)
      s3 = create(:bottle_in_cellar_now)

      expect(Wine.find_in_cellar_ready_to_drink).to eq([s2.wine, s3.wine])      
    end

    it "finds all wines by winery name" do
      wine = create(:wine_with_grapes_a)

      expect(Wine.find_wines_by_winery_name('lvento')[0]).to eq(wine)
    end

    it "finds wines matching what is parsed from file" do
      w = create(:wine_with_grapes_a)
      winery = Winery.find_by_name('Alvento')
      
      expect(Wine.find_by_winery_year_lcbo_code(winery.id, 2011, '123456')).to eq([w])
    end

    it "doesn't find results when what is parsed from file doesn't have lcbo code" do
      w = create(:wine_with_grapes_b)
      winery = Winery.find_by_name('Vineland Estates')
      
      expect(Wine.find_by_winery_year_lcbo_code(winery.id, 2011, '')).to eq([])
    end
    
    it "finds all bottles drunk on today's date" do
      b = create(:bottle_drank)

      expect(Wine.find_wines_drank_this_day[0]).to eq(b.wine)
    end
  end
end
