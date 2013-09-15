class RemovePurchasedDateFromWines < ActiveRecord::Migration
  def change
    remove_column :wines, :purchased_date, :date
  end
end
