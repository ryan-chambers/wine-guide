class CreateGrapeColombard < ActiveRecord::Migration[4.2]
  def up
    Grape.create :name => "Colombard"
  end
end
