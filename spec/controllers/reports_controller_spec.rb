require 'spec_helper'

describe ReportsController do

  describe "GET 'cellar'" do
    it "returns http success" do
      get 'cellar'
      response.should be_success
    end

    it "renders the 'cellar' template" do
      get 'cellar'
      response.should render_template('cellar')
    end

    it "assigns all wines in cellar to @wines variable by default" do
      s1 = create(:bottle_drank)
      s2 = create(:bottle_in_cellar_later)
      s3 = create(:bottle_in_cellar_sooner)

      get 'cellar'
      assigns[:wines].should == [s3.wine, s2.wine]
    end

    it "assigns wines ready to drink soon when told to" do
      s1 = create(:bottle_drank)
      s2 = create(:bottle_in_cellar_later)
      s3 = create(:bottle_in_cellar_sooner)

      get 'cellar', :term => 'soon'
      assigns[:wines].should == [s3.wine]
    end
  end

  describe "GET 'maturity_profile'" do
    it "generates a breakdown of bottles vs. year" do
      s1 = create(:bottle_in_cellar_later)
      s2 = create(:bottle_in_cellar_sooner)
      s3 = create(:bottle_in_cellar_now)

      get 'maturity_profile'

      response.should be_success

      assigns[:labels].should_not be_nil
      assigns[:bottles].should_not be_nil
    end
  end

  describe "GET 'score_breakdown'" do
    it "assigns score breakdown to param" do
      s1 = create(:bottle_in_cellar_later)
      s2 = create(:bottle_in_cellar_sooner)
      s3 = create(:bottle_in_cellar_now)

      get 'score_breakdown'

      response.should be_success

      assigns[:scores].should_not be_nil
      assigns[:score_counts].should_not be_nil
    end
  end

  describe "GET 'country'" do
    it "returns http succcess" do
      get 'country'
      response.should be_success
    end

    it "renders the 'country' template" do
      get 'country'
      response.should render_template('country')
    end

    it "assigns country report data to @country_summaries" do
      create(:bottle_drank)
      create(:bottle_drank_2)
      create(:bottle_drank_3)

      get 'country'

      assigns[:country_summaries].should_not be_nil
    end
  end

  describe "GET 'this_day_in_wine'" do
    it "returns http success" do
      get 'this_day_in_wine'
      response.should be_success
    end

    it "renders the 'this_day_in_wine' template" do
      get 'this_day_in_wine'
      response.should render_template('this_day_in_wine')
    end

    it "assigns country report data to @wines" do
      create(:bottle_drank)

      get 'this_day_in_wine'

      assigns[:wines].should_not be_nil
    end
  end

  describe "GET 'favourite_wines'" do
    it "returns http success" do
      get 'favourite_wines'
      response.should be_success
    end

    it "renders the 'favourite_wines' template" do
      get 'favourite_wines'
      response.should render_template('favourite_wines')
    end

    it "assigns country report data to @wines" do
      create(:bottle_drank_2)

      get 'favourite_wines'

      assigns[:wines].should_not be_nil
    end
  end
end
