require "spec_helper"

describe Winery do
  setup do
    @winery = build(:winery)
  end

  it "find a winery case-insensitively" do
    winery_name = "Alvento"
    alviento = Winery.create!(name: winery_name)

    expect(Winery.find_by_name 'ALVENTO').to eq(alviento)
  end
  
  it "fails validation without name" do
    winery = Winery.new
    winery.save
    winery.errors.get(:name).should_not be_nil
  end
end