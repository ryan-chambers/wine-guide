class CreateGrapeFiano < ActiveRecord::Migration
  def up
    Grape.create :name => "Fiano"
  end
end
