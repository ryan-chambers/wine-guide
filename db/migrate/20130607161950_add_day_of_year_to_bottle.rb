class AddDayOfYearToBottle < ActiveRecord::Migration
  def change
    add_column :bottles, :review_day_of_year, :string
  end
end
