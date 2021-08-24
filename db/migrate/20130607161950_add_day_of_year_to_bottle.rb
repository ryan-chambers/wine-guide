class AddDayOfYearToBottle < ActiveRecord::Migration[4.2]
  def change
    add_column :bottles, :review_day_of_year, :string
  end
end
