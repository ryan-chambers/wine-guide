--select * from grapes where name = 'Barolo' (11)
--select * from grapes where name = 'Barbaresco' (8)
--select * from grapes where name = 'Nebbiolo' (33)
--select grape_id, wine_id from grapes_wines where grape_id = 11 (11, 611)
--select grape_id, wine_id from grapes_wines where grape_id = (8, 611)
--insert into grapes_wines (grape_id, wine_id) values (8, 611)
delete from grapes where id = 8
