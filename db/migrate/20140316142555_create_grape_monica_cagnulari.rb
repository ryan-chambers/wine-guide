class CreateGrapeMonicaCagnulari < ActiveRecord::Migration
  def up
    Grape.create :name => "Monica Cagnulari"
  end
end
