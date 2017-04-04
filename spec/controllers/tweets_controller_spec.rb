require 'rails_helper'

describe TweetsController do
  describe "get 'bottle'" do
    it "returns the default tweet for a bottle" do
      bottle = create(:alvento_sauvignonblanc_bottle_drank)

      get :bottle, params: {:bottle_id => bottle.id }, :format => :json

#      puts response.body

      expect(response).to be_success
      expect(response.body).to include(bottle.wine.year.to_s)
      expect(response.header['Content-Type']).to include 'application/json'
    end

    it "returns empty for a bottle that should not be tweeted" do
      bottle = create(:imocali_vernaccia_bottle_now)

      get :bottle, params: {:bottle_id => bottle.id}, :format => :json

      expect(response).to be_success
      expect(response.body).not_to include(bottle.wine.year.to_s)
      expect(response.header['Content-Type']).to include 'application/json'
    end
  end

  describe "post 'tweet_bottle'" do
    it "returns http success when authenticated" do
      authenticate_with_http_digest

      wine = create(:kenwood_merlot)

      post 'tweet_bottle', params: {:wine_id => wine.id }

      assert_redirected_to wine_path(assigns(:wine))
    end

    it "returns failure when not authenticated" do
      wine = create(:kenwood_merlot)

      post 'tweet_bottle', params: { :wine_id => wine.id }

      expect(response.response_code).to eq(401)
    end
  end
end
