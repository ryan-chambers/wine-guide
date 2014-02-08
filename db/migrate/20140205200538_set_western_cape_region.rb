class SetWesternCapeRegion < ActiveRecord::Migration
  def change
    execute "update wines set region = 'WO Western Cape' where region = 'Western Cape'"
  end
end
