require 'spec_helper'

describe GrapesController do

  describe "GET 'seach'" do
    it "returns http success" do
      get 'search'
      response.should be_success
    end
  end
end
