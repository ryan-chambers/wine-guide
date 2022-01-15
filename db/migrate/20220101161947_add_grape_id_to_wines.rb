class AddGrapeIdToWines < ActiveRecord::Migration[6.0]
  def change
    add_reference :wines, :grape, foreign_key: true
  end
end
