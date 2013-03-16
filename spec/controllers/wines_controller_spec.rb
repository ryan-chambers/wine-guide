require 'spec_helper'

describe WinesController do
  describe "get 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
    
    it "renders the 'index' template" do
      get :index
      response.should render_template('index')
    end
    
    it "assigns all wines to @wines variable when no term specified" do
      w1 = create(:wine_with_grapes_a)
      w2 = create(:wine_with_grapes_b)
      
      get :index
      assigns[:wines].should == [w1, w2]
    end
    
    it "assigns matching wines to @wines variable when term is specified" do
      w1 = create(:wine_with_grapes_a)
      w2 = create(:wine_with_grapes_b)

      get :index, :term => 'Alv'
      assigns[:wines].should == [w1]
    end
  end
  
  describe "get 'new'" do
    it "fails without validation" do
      get 'new'
      response.should_not be_success
    end

    it "succeeds with validation" do
      authenticate_with_http_digest
      get 'new'
      response.should be_success
      assigns[:wine].should_not be_nil
    end
  end

  describe "post 'create'" do
    context "when successful" do
      before do
        authenticate_with_http_digest
        grape = create(:grape)
        @grape_id = grape.id
        @wine_params = {:wine => {:country => 'Canada', :year => '2012'}, 
          :winery_name => 'Alvento', 
          :grape_ids => @grape_id}
      end

      it "redirects to wine page" do
        post :create, @wine_params
        assert_redirected_to wine_path(assigns(:wine))
      end

      it "creates a wine record" do
        lambda {
          post :create, @wine_params
        }.should change(Wine, :count).by(1)
      end
    end

    context "when failure" do
      before do
        authenticate_with_http_digest
      end

      it "re-renders the 'new' template" do
        post :create
        response.should render_template('new')
      end

      it "should not create a wine record" do
        post :create
        response.should render_template('new')
        lambda {
          post :create, @wine_params
        }.should_not change(Wine, :count)
      end
    end
  end
end
