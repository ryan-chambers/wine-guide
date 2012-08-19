class AddGrapesToWines < ActiveRecord::Migration
  def change
    add_column :wines, :grapes, :string
  end
end
