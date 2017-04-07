require 'rails_helper'

describe WineriesController do
  describe "get 'search'" do
  	# TODO RC worth testing?
  end

  describe "get 'show'" do
  	it "should be successful" do
      w1 = create(:vineland)
      get 'show', params: {id: w1.id}
      expect(response).to be_success
    end
  end
end