select wy.name, w.year, w.other 
from wines w, bottles b, wineries wy 
where w.id = b.wine_id and b.in_fridge = 't' and w.winery_id = wy.id
