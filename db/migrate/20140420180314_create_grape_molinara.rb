class CreateGrapeMolinara < ActiveRecord::Migration[4.2]
  def up
    Grape.create :name => "Molinara"
  end
end
