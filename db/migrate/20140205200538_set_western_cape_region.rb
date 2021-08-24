class SetWesternCapeRegion < ActiveRecord::Migration[4.2]
  def change
    execute "update wines set region = 'WO Western Cape' where region = 'Western Cape'"
  end
end
