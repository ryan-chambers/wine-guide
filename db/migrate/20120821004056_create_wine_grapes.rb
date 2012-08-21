class CreateWineGrapes < ActiveRecord::Migration
  def change
    create_table :wine_grapes do |t|
      t.string :grape
      t.references :wine

      t.timestamps
    end
    add_index :wine_grapes, :wine_id
  end
end
