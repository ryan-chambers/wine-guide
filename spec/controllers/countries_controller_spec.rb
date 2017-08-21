require 'rails_helper'

describe CountriesController do

  describe "GET 'countries'" do
    it "returns partial search results for Canada - Niagara" do
      get 'index', params: {country: 'Canada', region_partial: 'Niagara'}, :format => :json
      p "#{response.parsed_body}"
      expect(response).to be_success
      expect(response.parsed_body).to include('VQA Niagara River')
      expect(response.parsed_body).not_to include('VQA Creek Shores')
    end
  end
end
