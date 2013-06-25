class RemoveGrapesBaroloBarbaresco < ActiveRecord::Migration
  def up
    migrate_grape 'Barolo'
    migrate_grape 'Barbaresco'
  end

  def migrate_grape(grape_name)
    nebbiolo = Grape.find_by_name 'Nebbiolo'

    grape = Grape.find_by_name grape_name
    Wine.find_by_grapes(grape_name).each do |wine|
      wine.update_attribute :grapes, [nebbiolo]
    end

    Grape.destroy grape.id
  end

  def down
  end
end
