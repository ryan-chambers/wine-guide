class CreateGrapeMolinara < ActiveRecord::Migration
  def up
    Grape.create :name => "Molinara"
  end
end
