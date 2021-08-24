class RemovePurchasedDateFromWines < ActiveRecord::Migration[4.2]
  def change
    remove_column :wines, :purchased_date, :date
  end
end
