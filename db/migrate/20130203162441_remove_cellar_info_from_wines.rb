class RemoveCellarInfoFromWines < ActiveRecord::Migration
  def up
    remove_column :wines, :in_cellar
    remove_column :wines, :drink_from
    remove_column :wines, :drink_until
  end

  def down
    add_column :wines, :drink_until, :date
    add_column :wines, :drink_from, :date
    add_column :wines, :in_cellar, :boolean
  end
end
