require 'spec_helper'

describe Bottle do
  describe "validations" do
    before do
      @bottle = Bottle.new
      @bottle.should_not be_valid
    end
    
    it "must have a price" do
      @bottle.errors.get(:price).should_not be_nil
    end
  end
end