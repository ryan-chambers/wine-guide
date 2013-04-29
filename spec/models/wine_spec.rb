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

  describe "finders" do
    it "finds all wines with bottles indicating they are in the cellar" do
      s1 = create(:bottle_drank)
      s2 = create(:bottle_in_cellar)

      expect(Wine.find_wines_in_cellar).to eq([s2.wine])
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
  end
end
