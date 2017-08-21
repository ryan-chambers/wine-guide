require 'rails_helper'

describe CountriesController do

  describe "GET 'countries'" do
    it "returns partial search results for Canada" do
      get 'index', params: {country: 'Canada'}, :format => :json
      expect(response).to be_success
    end
  end
end
