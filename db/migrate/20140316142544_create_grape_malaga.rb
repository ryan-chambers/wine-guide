class CreateGrapeMalaga < ActiveRecord::Migration
  def up
    Grape.create :name => "Malaga"
  end
end
