class CreateGrapeColombard < ActiveRecord::Migration
  def up
    Grape.create :name => "Colombard"
  end
end
