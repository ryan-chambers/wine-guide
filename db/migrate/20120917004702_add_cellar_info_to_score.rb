class AddCellarInfoToScore < ActiveRecord::Migration[4.2]
  def change
    add_column :scores, :to, :integer
    add_column :scores, :from, :integer
    add_column :scores, :in_fridge, :boolean
  end
end
