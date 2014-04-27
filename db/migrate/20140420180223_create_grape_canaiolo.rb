class CreateGrapeCanaiolo < ActiveRecord::Migration
  def up
    Grape.create :name => "Canaiolo"
  end
end
