require "spec_helper"

describe Winery do
  it "find a winery case-insensitively" do
    alviento = Winery.create!(name: "Alviento")

    expect(Winery.find_by_name 'ALVIENTO').to eq(alviento)
  end
  
  it "fails validation without name" do
    FactoryGirl.build(:winery, :name => "").should_not be_valid
  end
end