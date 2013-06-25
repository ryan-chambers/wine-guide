class SetBaroloBarbarescoRegions < ActiveRecord::Migration
  def up
    execute "update wines set region = 'Barolo' where id in (select wine_id from grapes_wines where grape_id in (select id from grapes where name = 'Barolo'))"
    execute "update wines set region = 'Barbaresco' where id in (select wine_id from grapes_wines where grape_id in (select id from grapes where name = 'Barbaresco'))"
  end

  def down
  end
end
