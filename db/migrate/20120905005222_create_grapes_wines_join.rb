class CreateGrapesWinesJoin < ActiveRecord::Migration
  def up
    create_table 'grapes_wines', :id => false do |t|
      t.column 'grape_id', :integer
      t.column 'wine_id', :integer
    end
  end

  def down
    drop_table :grapes_wines
  end
end
