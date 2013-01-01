select * from wines wines, wineries wineries
where wines.winery_id = wineries.id
and wineries.name = ''
