require "spec_helper"

describe Winery do
  setup do
    @winery = build(:winery)
  end

  it "find a winery case-insensitively" do
    expect(Winery.find_by_name 'ALVIENTO').to eq(@winery)
  end
  
  it "fails validation without name" do
    FactoryGirl.build(:winery, :name => "").should_not be_valid
  end
end