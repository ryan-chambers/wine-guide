class CreateGrapeCanaiolo < ActiveRecord::Migration[4.2]
  def up
    Grape.create :name => "Canaiolo"
  end
end
