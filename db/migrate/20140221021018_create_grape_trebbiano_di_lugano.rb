class CreateGrapeTrebbianoDiLugano < ActiveRecord::Migration
  def up
    Grape.create :name => 'Trebbiano di Lugano'
  end
end
