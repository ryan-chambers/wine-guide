require 'rails_helper'

describe GrapesController do

  describe "GET 'search'" do
    it "returns http success" do
      get 'search'
      expect(response).to be_success
    end
  end
end
