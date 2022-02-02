require "rails_helper"

describe Grape do
  before(:each) do
    @grape = create(:sauvignonblanc)
  end

  describe "validations" do
    it "fails validation without name" do
      grape = Grape.new
      grape.save
      expect(grape.errors[:name]).not_to be_nil
    end

    it { is_expected.to validate_uniqueness_of(:name) }
  end

  describe "searches" do
    it "case-insensitively for all matching grapes" do
      expect(Grape.search_by_name 'SAUVIG').to eq([@grape])
    end

    it "returns all grapes when no search term entered" do
      g2 = create(:vernaccia)
      expect(Grape.search_by_name nil).to eq([@grape, g2])
    end

    it "returns all grapes sorted alphabetically" do
      g1 = create(:merlot)
      expect(Grape.findAll).to eq([g1, @grape])
    end
  end
end
