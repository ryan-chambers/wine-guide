require 'spec_helper'

describe ReportsController do

  describe "GET 'cellar'" do
    it "returns http success" do
      get 'cellar'
      response.should be_success
    end
    
    it "renders the 'cellar' template" do
      get 'cellar'
      response.should render_template('cellar')
    end
    
    it "assigns all wines in cellar to @wines variable" do
      s1 = create(:bottle_drank)
      s2 = create(:bottle_in_cellar)

      get 'cellar'
      assigns[:wines].should == [s2.wine]
    end
  end
end
