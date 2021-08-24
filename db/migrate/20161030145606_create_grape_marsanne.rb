class CreateGrapeMarsanne < ActiveRecord::Migration[4.2]
  def up
    Grape.create :name => "Marsanne"
  end
end
