require 'spec_helper'

describe ExportController do

  before do
    authenticate_with_http_digest
  end

  describe "GET 'export'" do
    it "returns http success" do
      get 'export'
      response.should be_success
    end
  end
end
