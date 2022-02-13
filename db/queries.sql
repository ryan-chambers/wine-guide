--select * from wines wines, wineries wineries
--where wines.winery_id = wineries.id
--and wineries.name = ''

--select * from wines where id = 283

update wines set other = 'Antagonist', lcbo_code = '467662' where id = 283;


-- count of grapes
select g.id, g.name, coalesce(w.count, 0) as number_of_wines
from grapes g
left join
(select grape_id, count(*) as count
from wines
group by grape_id)
w on (g.id = w.grape_id)
order by number_of_wines desc