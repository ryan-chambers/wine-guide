class CreateGrapeTannat < ActiveRecord::Migration[4.2]
  def up
    Grape.create :name => "Tannat"
  end
end
