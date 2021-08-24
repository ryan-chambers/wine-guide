class CreateGrapeGraciano < ActiveRecord::Migration[4.2]
  def up
    Grape.create :name => "Graciano"
  end
end
