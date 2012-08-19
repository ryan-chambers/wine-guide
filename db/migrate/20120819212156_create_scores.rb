class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.date :reviewdate
      t.float :score
      t.text :comments
      t.references :wine
      t.float :price

      t.timestamps
    end
    add_index :scores, :wine_id
  end
end
