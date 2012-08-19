class CreateWineries < ActiveRecord::Migration
  def change
    create_table :wineries do |t|
      t.string :name

      t.timestamps
    end
  end
end
