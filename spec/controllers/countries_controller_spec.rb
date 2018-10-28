require 'rails_helper'

describe CountriesController do

  describe "GET 'countries'" do
    it "returns partial search results for Canada - Niagara" do
      get 'index', params: {country: 'Canada', region_partial: 'Niagara'}, :format => :json
#      p "#{response.parsed_body}"
      expect(response).to be_successful
      # TODO could parse to array and check all results
      expect(response.parsed_body).to include('VQA Niagara River')
      expect(response.parsed_body).not_to include('VQA Creek Shores')
    end

    it "returns partial search results for Canada - Creek" do
      get 'index', params: {country: 'Canada', region_partial: 'Creek'}, :format => :json
#      p "#{response.parsed_body}"
      expect(response).to be_successful
      # TODO could parse to array and check all results
      expect(response.parsed_body).not_to include('VQA Niagara River')
      expect(response.parsed_body).to include('VQA Creek Shores')
    end

    it "returns full region list when partial region not provided" do
      get 'index', params: {country: 'Canada'}, :format => :json
#      p "#{response.parsed_body}"
      expect(response).to be_successful
      expect(response.parsed_body).to include('VQA Niagara River')
      expect(response.parsed_body).to include('VQA Creek Shores')
    end

    it "returns error for invalid country" do
      # TODO
    end
  end
end
