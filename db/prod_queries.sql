--select avg(price), avg(score) from bottles where reviewdate >= '2014-01-01'
--select avg(price), avg(score) from bottles where reviewdate >= '2013-01-01' and reviewdate <= '2013-12-31'
--select avg(price), avg(score) from bottles where reviewdate >= '2012-01-01' and reviewdate <= '2012-12-31'
--select avg(price), avg(score) from bottles where reviewdate >= '2011-01-01' and reviewdate <= '2011-12-31'

--select * from bottles order by reviewdate
--update bottles set reviewdate = '2013-06-10' where id = 815
select min(reviewdate) from bottles
