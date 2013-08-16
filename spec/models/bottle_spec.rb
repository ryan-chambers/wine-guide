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

  describe "fields" do
    it "must have a non-nil review day of year if review date is set" do
      @bottle = Bottle.new
      @bottle.reviewdate= '11 Jan 2009'
      expect(@bottle[:review_day_of_year]).not_to be_nil
    end
  end

  describe "tweet" do
    before do
      @bottle = create(:bottle_drank)
    end

    it "generates a tweet" do
      tweet = @bottle.to_tweet
#      p "#{tweet}"
      expect(tweet).not_to be_nil
      expect(tweet).to include(@bottle.wine.winery.name)
      expect(tweet).to include(@bottle.wine.grapes[0].name)
      expect(tweet).to include(@bottle.wine.other)
      expect(tweet).to include(@bottle.wine.year.to_s)
      expect(tweet).to include(@bottle.comments)
      expect(tweet).to include(@bottle.score.to_i.to_s + "/100")
      expect(tweet).to include(@bottle.price.to_s)
      expect(tweet.length).to be <= 140
    end

    it "limits a tweet to 140 characters by trimming comments, price and score" do
      @bottle.wine.winery.name = 'Very very very very very very long winery name'
      @bottle.wine.other = 'Very very very very very long other part of wine'
      @bottle.comments = 'very very very very very long comments for bottle of wine'
      tweet = @bottle.to_tweet
#      p "#{tweet}"
      expect(tweet).not_to be_nil
      expect(tweet).to include(@bottle.wine.winery.name)
      expect(tweet).to include(@bottle.wine.grapes[0].name)
      expect(tweet).to include(@bottle.wine.other)
      expect(tweet).to include(@bottle.wine.year.to_s)
      expect(tweet.length).to be <= 140
    end

    it "can tweet if the bottle is not in the fridge" do
      expect(@bottle.can_tweet).to eq(true)
    end

    it "cannot tweet if the bottle is not in the fridge" do
      b = create(:bottle_in_cellar_later)
      expect(b.can_tweet).to eq(false)
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