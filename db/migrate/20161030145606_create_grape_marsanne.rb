class CreateGrapeMarsanne < ActiveRecord::Migration
  def up
    Grape.create :name => "Marsanne"
  end
end
