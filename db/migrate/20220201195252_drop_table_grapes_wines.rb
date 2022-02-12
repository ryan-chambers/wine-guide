class DropTableGrapesWines < ActiveRecord::Migration[6.0]
  def change
    drop_table :grapes_wines
  end
end
