class CreateGrapeGraciano < ActiveRecord::Migration
  def up
    Grape.create :name => "Graciano"
  end
end
