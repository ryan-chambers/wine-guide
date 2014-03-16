class CreateGrapePascaleDiCagliari < ActiveRecord::Migration
  def up
    Grape.create :name => "Pascale Di Cagliari"
  end
end
