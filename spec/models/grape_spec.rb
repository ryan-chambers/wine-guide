require "spec_helper"

describe Grape do
  before(:each) do
    @grape = create(:sauvignonblanc)
  end

  describe "validations" do
    it "fails validation without name" do
      grape = Grape.new
      grape.save
      grape.errors.get(:name).should_not be_nil
    end

    it { should validate_uniqueness_of(:name) }
  end

  describe "searches" do
    it "case-insensitively for all matching grapes" do
      expect(Grape.search_by_name 'SAUVIG').to eq([@grape])
    end
  end
end
