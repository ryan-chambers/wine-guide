class FixBottleToFromColumns < ActiveRecord::Migration
  def up
    rename_column(:bottles, :to, :drink_to)
    rename_column(:bottles, :from, :drink_from)
  end

  def down
    rename_column(:bottles, :drink_to, :to)
    rename_column(:bottles, :drink_from, :from)
  end
end
