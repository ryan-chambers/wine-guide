class CreateGrapeTannat < ActiveRecord::Migration
  def up
    Grape.create :name => "Tannat"
  end
end
