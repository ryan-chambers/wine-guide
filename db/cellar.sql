select wy.name, w.other, w.year, b.drink_to, b.price, g.name
from wines w, bottles b, wineries wy, grapes_wines wg, grapes g
where w.id = b.wine_id and b.in_fridge = 't' and w.winery_id = wy.id and g.id = wg.grape_id and wg.wine_id = w.id
