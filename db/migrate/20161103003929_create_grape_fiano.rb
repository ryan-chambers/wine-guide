class CreateGrapeFiano < ActiveRecord::Migration[4.2]
  def up
    Grape.create :name => "Fiano"
  end
end
