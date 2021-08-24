class CreateGrapeMalaga < ActiveRecord::Migration[4.2]
  def up
    Grape.create :name => "Malaga"
  end
end
