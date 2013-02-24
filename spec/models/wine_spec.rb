require 'spec_helper'

describe Wine do
  describe "validations" do
    before do
      @wine = Wine.new
      @wine.should_not be_valid
    end
    
    [:year, :country].each do |attr|
      it "must have #{attr}" do
        @wine.errors.get(attr).should_not be_nil
      end
    end
  end
end
