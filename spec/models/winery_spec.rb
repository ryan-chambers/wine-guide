require "rails_helper"

describe Winery do
  describe "validations" do
    it "fails validation without name" do
      winery = Winery.new
      winery.save
      expect(winery.errors[:name]).not_to be_nil
    end

    it do
      is_expected.to validate_uniqueness_of(:name).
      case_insensitive
    end
  end  

  describe "finders" do
    it "finds wineries case-insensitively" do
      winery_name = "Alvento"
      alvento = Winery.create!(name: winery_name)
  
      expect(Winery.find_by_name 'ALVENTO').to eq(alvento)
    end
    
    it "gets everything when searching by nil" do
      w1 = create(:alvento)
      w2 = Winery.create!(name: 'Wine 2')
      expect(Winery.search_by_name nil).to eq([w1, w2])
    end
  
    it "searches for all partially matching names when searching by term" do
      w1 = create(:alvento)
      w2 = Winery.create!(name: 'Wine 2')
      expect(Winery.search_by_name 'VEN').to eq([w1])
    end    
  end

  describe "associations" do
    it "has many wines" do
      expect(Winery.new).to respond_to(:wines)
    end
  end

  # FIXME add test case for name uniqueness
end