require 'rails_helper'

describe ExportController do

  before do
    authenticate_with_http_digest
  end

  describe "GET 'export'" do
    it "returns http success" do
      get 'export'
      expect(response).to be_success
    end
  end
end
