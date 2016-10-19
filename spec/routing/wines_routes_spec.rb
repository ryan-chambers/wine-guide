require 'rails_helper'

describe "routes for wines" do
  it 'should route /wines to wines controller' do
    expect(get('/wines')).to route_to('wines#index')
  end
end