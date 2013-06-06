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
      assigns[:wines].should == [s2.wine, s3.wine]
    end

    it "assigns wines ready to drink soon when told to" do
      s1 = create(:bottle_drank)
      s2 = create(:bottle_in_cellar_later)
      s3 = create(:bottle_in_cellar_sooner)

      get 'cellar', :term => 'soon'
      assigns[:wines].should == [s3.wine]
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
end
