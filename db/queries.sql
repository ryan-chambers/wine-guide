--select * from wines wines, wineries wineries
--where wines.winery_id = wineries.id
--and wineries.name = ''

--select * from wines where id = 283

update wines set other = 'Antagonist', lcbo_code = '467662' where id = 283;