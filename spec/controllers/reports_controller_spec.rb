require 'rails_helper'

describe ReportsController do

  describe "GET 'cellar'" do
    it "returns http success" do
      get 'cellar'
      expect(response).to be_successful
    end

    it "renders the 'cellar' template" do
      get 'cellar'
      expect(response).to render_template('cellar')
    end

    it "assigns all wines in cellar to @wines variable by default" do
      b1 = create(:alvento_sauvignonblanc_bottle_drank)
      b2 = create(:vineland_sauvignonblanc_bottle_in_cellar_later)
      b3 = create(:cavesprings_sauvignonblanc_bottle_in_cellar_sooner)

      get 'cellar'
      expect(assigns[:wines]).to eq([b2.wine, b3.wine])
    end

    it "assigns wines ready to drink soon when told to" do
      s1 = create(:alvento_sauvignonblanc_bottle_drank)
      s2 = create(:vineland_sauvignonblanc_bottle_in_cellar_later)
      s3 = create(:cavesprings_sauvignonblanc_bottle_in_cellar_sooner)

      get 'cellar', params: {:term => 'soon'}
      expect(assigns[:wines]).to eq([s3.wine])
    end
  end

  describe "GET 'maturity_profile'" do
    it "generates a breakdown of bottles vs. year" do
      s1 = create(:vineland_sauvignonblanc_bottle_in_cellar_later)
      s2 = create(:cavesprings_sauvignonblanc_bottle_in_cellar_sooner)
      s3 = create(:imocali_vernaccia_bottle_now)

      get 'maturity_profile'

      expect(response).to be_successful

      expect(assigns[:labels]).not_to be_nil
      expect(assigns[:bottles]).not_to be_nil
    end
  end

  describe "GET 'score_breakdown'" do
    it "assigns score breakdown to param" do
      s1 = create(:vineland_sauvignonblanc_bottle_in_cellar_later)
      s2 = create(:cavesprings_sauvignonblanc_bottle_in_cellar_sooner)
      s3 = create(:imocali_vernaccia_bottle_now)

      get 'score_breakdown'

      expect(response).to be_successful

      expect(assigns[:scores]).not_to be_nil
      expect(assigns[:score_counts]).not_to be_nil
    end
  end

  describe "GET 'country'" do
    it "returns http succcess" do
      b1 = create(:alvento_sauvignonblanc_bottle_drank)

      get 'country'
      expect(response).to be_successful
    end

    it "renders the 'country' template" do
      b1 = create(:alvento_sauvignonblanc_bottle_drank)

      get 'country'
      expect(response).to render_template('country')
    end

    it "assigns country report data to @country_summaries" do
      create(:alvento_sauvignonblanc_bottle_drank)
      create(:kenwood_merlot_drank)
      create(:vineland_sauvignonblanc_drank)

      get 'country'

      expect(assigns[:country_summaries]).not_to be_nil
    end
  end

  describe "GET 'yearly'" do
    it "returns http succcess" do
      b1 = create(:alvento_sauvignonblanc_bottle_drank)

      get 'country'

      expect(response).to be_successful
    end

    it "renders the 'yearly' template" do
      create(:alvento_sauvignonblanc_bottle_drank)

      get 'yearly'

      expect(response).to render_template('yearly')
    end

    it "assigns country report data to @yearly_summaries" do
      create(:alvento_sauvignonblanc_bottle_drank)
      create(:kenwood_merlot_drank)
      create(:imocali_vernaccia_bottle_drank_last_year)

      get 'yearly'

      expect(assigns[:yearly_summaries]).not_to be_nil
    end
  end

  describe "GET 'this_day_in_wine'" do
    it "returns http success" do
      get 'this_day_in_wine'
      expect(response).to be_successful
    end

    it "renders the 'this_day_in_wine' template" do
      get 'this_day_in_wine'
      expect(response).to render_template('this_day_in_wine')
    end

    it "assigns country report data to @wines" do
      create(:alvento_sauvignonblanc_bottle_drank)

      get 'this_day_in_wine'

      expect(assigns[:wines]).not_to be_nil
    end
  end

  describe "GET 'favourite_wines'" do
    it "returns http success" do
      get 'favourite_wines'
      expect(response).to be_successful
    end

    it "renders the 'favourite_wines' template" do
      get 'favourite_wines'
      expect(response).to render_template('favourite_wines')
    end

    it "assigns country report data to @wines" do
      create(:kenwood_merlot_drank)

      get 'favourite_wines'

      expect(assigns[:wines]).not_to be_nil
    end
  end

  describe "GET 'recent_good_bottles'" do
    it "returns http success" do
      get 'recent_good_bottles'
      expect(response).to be_successful
    end

    it "only assigns > 87 bottles for recently drank wines to @wines" do
      create(:kenwood_merlot_drank)
      create(:alvento_sauvignonblanc_bottle_drank)

      get 'favourite_wines'

      expect(assigns[:wines]).not_to be_nil
      expect(assigns(:wines).count).to eq 1
    end
  end

  describe "GET 'grapes'" do
    it "returns http success" do
      create(:kenwood_merlot_drank)

      get 'grapes', params: {:grape_filter => 'merlot'}

      expect(response).to be_successful
      expect(assigns[:grape_report]).not_to be_nil
    end
  end
end
