class RemoveGrapeTintaRoriz < ActiveRecord::Migration[5.2]
  def change
    Grape.where(name: 'Tinta Roriz').destroy_all
  end
end
