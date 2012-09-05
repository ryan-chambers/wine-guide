class RemoveWineGrape < ActiveRecord::Migration
  def up
   drop_table :wine_grapes
  end

  def down
  end
end
