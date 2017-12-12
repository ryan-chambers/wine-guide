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

  describe "reports" do
    it "generates a grape report" do
      @bottle = create(:alvento_sauvignonblanc_bottle_drank)

      gr = Grape.generate_grape_report(@bottle.wine.grapes[0].id)
      expect(gr.total_bottles).to eq(1)
      expect(gr.avg_price).to eq(19.95)
      expect(gr.avg_score).to eq(86.0)
#      p "#{gr}"
    end
  end
end
