class CreateGrapeTrebbianoDiLugano < ActiveRecord::Migration[4.2]
  def up
    Grape.create :name => 'Trebbiano di Lugano'
  end
end
