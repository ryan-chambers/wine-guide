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
    it "finds all wines with scores indicating they are in the cellar" do
      s1 = create(:score_drank)
      s2 = create(:score_in_cellar)
      
      expect(Wine.find_wines_in_cellar).to eq([s2.wine])
    end
  end
end
