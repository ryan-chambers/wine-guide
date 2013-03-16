require "spec_helper"

describe Winery do
  # not really used, but this is how to use factory girl
  setup do
    @winery = build(:alvento)
  end

  describe "validations" do
    it "fails validation without name" do
      winery = Winery.new
      winery.save
      winery.errors.get(:name).should_not be_nil
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
      Winery.new.should respond_to(:wines)
    end
  end

  # FIXME add test case for name uniqueness
end