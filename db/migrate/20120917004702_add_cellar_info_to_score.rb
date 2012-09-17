class AddCellarInfoToScore < ActiveRecord::Migration
  def change
    add_column :scores, :to, :integer
    add_column :scores, :from, :integer
    add_column :scores, :in_fridge, :boolean
  end
end
