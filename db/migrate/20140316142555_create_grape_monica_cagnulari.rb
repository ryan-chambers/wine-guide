class CreateGrapeMonicaCagnulari < ActiveRecord::Migration[4.2]
  def up
    Grape.create :name => "Monica Cagnulari"
  end
end
