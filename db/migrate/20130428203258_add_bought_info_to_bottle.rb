class AddBoughtInfoToBottle < ActiveRecord::Migration
  def change
    add_column :bottles, :bought, :string
  end
end
