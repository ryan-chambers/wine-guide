class RemoveGrapeGrenacheNoir < ActiveRecord::Migration[5.2]
  def up
    Grape.where(name: 'Grenache Noir').destroy_all
  end
end
