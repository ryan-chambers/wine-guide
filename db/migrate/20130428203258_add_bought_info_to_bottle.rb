class AddBoughtInfoToBottle < ActiveRecord::Migration[4.2]
  def change
    add_column :bottles, :bought, :string
  end
end
