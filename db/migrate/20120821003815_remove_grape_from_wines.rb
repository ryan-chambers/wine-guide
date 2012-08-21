class RemoveGrapeFromWines < ActiveRecord::Migration
  def up
    remove_column :wines, :grapes
  end

  def down
    add_column :wines, :grapes, :string
  end
end
