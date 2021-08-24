class CreateGrapePascaleDiCagliari < ActiveRecord::Migration[4.2]
  def up
    Grape.create :name => "Pascale Di Cagliari"
  end
end
