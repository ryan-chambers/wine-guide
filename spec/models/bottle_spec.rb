require 'rails_helper'

describe Bottle do
  describe "validations" do
    before do
      @bottle = Bottle.new
      expect(@bottle).not_to be_valid
    end

    it "must have a price" do
      expect(@bottle.errors[:price]).not_to be_nil
    end

    it "may have a to date before the from date" do
      @bottle.drink_from = Time.new.strftime('%Y').to_i + 2
      @bottle.drink_to = Time.new.strftime('%Y').to_i + 3

      expect(@bottle).not_to be_valid

      expect(@bottle.errors[:drink_from]).to be_empty
    end

    it "must have a to date after the from date" do
      @bottle.drink_from = Time.new.strftime('%Y').to_i + 5
      @bottle.drink_to = Time.new.strftime('%Y').to_i + 4

      expect(@bottle).not_to be_valid

      expect(@bottle.errors[:drink_from]).not_to be_nil
    end
  end

  describe "fields" do
    it "must have a non-nil review day of year if review date is set" do
      @bottle = Bottle.new
      @bottle.reviewdate = '11 Jan 2009'
      expect(@bottle[:review_day_of_year]).not_to be_nil
    end

    it "must have a nil review day if in fridge" do
      @bottle = Bottle.new
      @bottle.in_fridge = true
      @bottle.reviewdate = '1 Jan 2009'
      @bottle.save
      expect(@bottle.errors[:reviewdate]).not_to be_nil
    end
  end

  describe "tweet" do
    before do
      @bottle = create(:alvento_sauvignonblanc_bottle_drank)
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
      b = create(:vineland_sauvignonblanc_bottle_in_cellar_later)
      expect(b.can_tweet).to eq(false)
    end
  end

  describe "report generator" do
    it "generates a country report based on bottles in the database" do
      create(:alvento_sauvignonblanc_bottle_drank)
      create(:kenwood_merlot_drank)
      create(:vineland_sauvignonblanc_drank)

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

    it "generates a score breakdown report based on bottles in the database" do
      create(:alvento_sauvignonblanc_bottle_drank)
      create(:kenwood_merlot_drank)
      create(:vineland_sauvignonblanc_drank)

      score_counts = Bottle.generate_score_breakdown_report

      score_counts.each do |c|
#         p "#{c.to_s}"
      end

      expect(score_counts[0].score).to eq(86)
      expect(score_counts[0].score_count).to eq(1)
      expect(score_counts[1].score).to eq(87)
      expect(score_counts[1].score_count).to eq(1)
      expect(score_counts[2].score).to eq(93)
      expect(score_counts[2].score_count).to eq(1)
    end

    it "generates a summary for a given year" do
      create(:alvento_sauvignonblanc_bottle_drank)
      create(:kenwood_merlot_drank)
      create(:vineland_sauvignonblanc_drank)
      year = Date.today.year

      year_summary = Bottle.generate_summary_for_year(year)

#      p "#{year_summary.to_s}"

      expect(year_summary.year).to eq(year)
      expect(year_summary.total_bottles).to eq(3)
      # TODO restore assertion
#      expect(year_summary.amount_spent).to eq(44)
    end

    it "generates a summary for all years" do
      create(:alvento_sauvignonblanc_bottle_drank)
      create(:kenwood_merlot_drank)
      create(:imocali_vernaccia_bottle_drank_last_year)

      yearly_report = Bottle.generate_yearly_report
      
      yearly_report.each do |c|
#         p "#{c.to_s}"
      end

      expect(yearly_report.length).to eq(2)
      expect(yearly_report[0].total_bottles).to eq(1)
      expect(yearly_report[1].total_bottles).to eq(2)
    end
  end

  describe "storage recommendation" do
    it "recommends storage in the cellar if price > $25 and drink to 3 or more years away" do
      b = create(:vineland_sauvignonblanc_bottle_in_cellar_later)
      b.price = 25.15
      b.drink_to = Date.today.year + 3
#      p "#{b.drink_to}"

      expect(b.recommended_storage).to eq(Bottle::CELLAR)
    end

    it "recommends storage in the fridge if price < $25" do
      b = create(:vineland_sauvignonblanc_bottle_in_cellar_later)
      b.price = 25

      expect(b.recommended_storage).to eq(Bottle::FRIDGE)
    end

    it "recommends storage in the fridge if drink from less than 3 years away" do
      b = create(:vineland_sauvignonblanc_bottle_in_cellar_later)
      b.price = 25.15
      b.drink_to = Date.today.year + 2

      expect(b.recommended_storage).to eq(Bottle::FRIDGE)
    end

    it "recommends storage in the fridge if drink to empty" do
      b = create(:vineland_sauvignonblanc_bottle_in_cellar_later)
      b.price = 25.15
      b.drink_to = nil

      expect(b.recommended_storage).to eq(Bottle::FRIDGE)
    end

    it "recommends nothing if the wine is not in the fridge" do
      b = create(:alvento_sauvignonblanc_bottle_drank)

      expect(b.recommended_storage).to eq('none')
    end
  end
end