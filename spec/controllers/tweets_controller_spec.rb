require 'spec_helper'

describe TweetsController do
  describe "get 'bottle'" do
    it "returns the default tweet for a bottle" do
      bottle = create(:bottle_drank)

      get :bottle, :bottle_id => bottle.id, :format => :json

#      puts response.body

      response.should be_success
      expect(response.body).to include(bottle.wine.year.to_s)
      response.header['Content-Type'].should include 'application/json'
    end

    it "returns empty for a bottle that should not be tweeted" do
      bottle = create(:bottle_in_cellar_now)

      get :bottle, :bottle_id => bottle.id, :format => :json

      response.should be_success
      expect(response.body).not_to include(bottle.wine.year.to_s)
      response.header['Content-Type'].should include 'application/json'
    end
  end

  describe "post 'tweet_bottle'" do
    it "returns http success when authenticated" do
      authenticate_with_http_digest

      wine = create(:wine_with_grapes_e)

      post 'tweet_bottle', :wine_id => wine.id

      assert_redirected_to wine_path(assigns(:wine))
    end

    it "returns failure when not authenticated" do
      wine = create(:wine_with_grapes_e)

      post 'tweet_bottle', :wine_id => wine.id

      expect(response.response_code).to eq(401)
    end
  end
end
