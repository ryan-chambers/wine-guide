class CreateWines < ActiveRecord::Migration
  def change
    create_table :wines do |t|
      t.string :region
      t.string :country
      t.string :other
      t.integer :year
      t.integer :winery_id
      t.string :lcbo_code
      t.boolean :in_cellar
      t.date :purchased_date
      t.date :drink_from
      t.date :drink_until

      t.timestamps
    end
  end
end
