require 'spec_helper'

describe Bottle do
  describe "validations" do
    before do
      @bottle = Bottle.new
      @bottle.should_not be_valid
    end

    it "must have a price" do
      @bottle.errors.get(:price).should_not be_nil
    end
  end

  describe "report generator" do
    it "generates a country report based on bottles in the database" do
      create(:bottle_drank)
      create(:bottle_drank_2)
      create(:bottle_drank_3)

      country_reports = Bottle.generate_country_report

      country_reports.each do |c|
#        p "#{c.to_s}"
      end

      expect(country_reports[0].country).to eq('Canada')
      expect(country_reports[0].avg_score).to eq(86.5)
      expect(country_reports[0].avg_price).to eq(17.45)
      expect(country_reports[0].total_bottles).to eq(2)
      expect(country_reports[1].country).to eq('USA')
    end
  end
end