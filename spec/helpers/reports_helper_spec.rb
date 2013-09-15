require "spec_helper"

describe ReportsHelper do
  before do
    @b1 = create(:bottle_in_cellar_later)
    @b2 = create(:bottle_in_cellar_sooner)
    @b3 = create(:bottle_in_cellar_now)
    @wines = [@b1.wine, @b2.wine, @b3.wine]
  end

  it "should determine the latest drinking year of range of a list of wines with bottles in the cellar" do
    expect(helper.determine_max_year @wines).to be > Time.new.strftime('%Y').to_i
  end

  it "should return the year drinking range" do
    expect(helper.determine_years @wines).to_not be_nil
  end

  it "should calculate the number of bottles per year in range" do
    year_range = helper.determine_years @wines 
    bpy = helper.determine_bottles_per_year(year_range, @wines)
    expect(bpy).to_not be_nil
    expect(bpy.length).to eq(year_range.length)
  end
end
