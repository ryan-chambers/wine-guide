class RemoveGrapeTintoRoriz < ActiveRecord::Migration[5.2]
  def change
    Grape.where(name: 'Tinto Roriz').destroy_all
  end
end
