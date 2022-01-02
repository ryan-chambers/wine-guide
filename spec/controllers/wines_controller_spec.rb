require 'rails_helper'

describe WinesController do
  describe "get 'index'" do
    it "should be successful" do
      get 'index'
      expect(response).to be_successful
    end

    it "renders the 'index' template" do
      get :index
      expect(response).to render_template('index')
    end

    it "assigns all wines to @wines variable when no term specified" do
      w1 = create(:alvento_sauvignonblanc)
      w2 = create(:vineland_sauvignonblanc)

      get :index
      expect(assigns[:wines]).to eq([w1, w2])
    end

    it "assigns wineries searched by winery name when non-LCBO code term is specified" do
      w1 = create(:alvento_sauvignonblanc)
      w2 = create(:vineland_sauvignonblanc)

      get :index, params: {:term => 'Alv'}
      expect(assigns[:wines]).to eq([w1])
    end

    it "assigns wineries searched by LCBO code when specified" do
      w1 = create(:alvento_sauvignonblanc)
      w2 = create(:vineland_sauvignonblanc)

      get :index, params: {:term => '98765432'}
      expect(assigns[:wines]).to eq([w2])
    end
  end

  describe "get 'new'" do
    it "fails without validation" do
      get 'new'
      expect(response).not_to be_successful
    end

    it "succeeds with validation" do
      authenticate_with_http_digest
      get 'new'
      expect(response).to be_successful
      expect(assigns[:wine]).not_to be_nil
    end
  end

  describe "post 'create'" do
    context "when successful" do
      before do
        authenticate_with_http_digest
        grape = create(:sauvignonblanc)
        @wine_params = {:wine => {:country => 'Canada', :year => '2012'}, 
          :winery_name => 'Alvento', 
          :grape_name => grape.name}
      end

      it "redirects to wine page" do
        post :create, params: @wine_params
        assert_redirected_to wine_path(assigns(:wine))
      end

      it "creates a wine record" do
        expect {
          post :create, params: @wine_params
        }.to change(Wine, :count).by(1)
      end
    end

    context "when failure" do
      before do
        authenticate_with_http_digest
        @wine_params = {:wine => {:not_real => 'phoney'}}
      end

      it "re-renders the 'new' template" do
        post :create, params: @wine_params
        expect(response).to render_template('new')
      end

      it "should not create a wine record" do
        post :create, params: @wine_params
        expect(response).to render_template('new')
        expect {
          post :create, params: @wine_params
        }.not_to change(Wine, :count)
      end
    end
  end

  it "knows the format of an LCBO code" do
    expect(WinesController.is_lcbo_code '').to be_nil
    expect(WinesController.is_lcbo_code 'RR').to be_nil
    expect(WinesController.is_lcbo_code '123').not_to be_nil
    expect(WinesController.is_lcbo_code '1234').not_to be_nil
    expect(WinesController.is_lcbo_code '12345').not_to be_nil
    expect(WinesController.is_lcbo_code '123456').not_to be_nil
    expect(WinesController.is_lcbo_code '1234567').not_to be_nil
    expect(WinesController.is_lcbo_code '12345678').not_to be_nil
  end
end
