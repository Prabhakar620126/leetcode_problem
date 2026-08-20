/* Write your T-SQL query statement below */
with cte as (
select lat ,lon  , count(*) as count
from insurance 
group by lat, lon 
having count(*)=1),
cte2 as (
select  tiv_2015 , count(*) as count1
from insurance 
group by tiv_2015 
having count(*)>1)

select round(sum(round(tiv_2016,2)),2) as tiv_2016
from insurance  as i 
join  cte  as c
on i.lat=c.lat and i.lon=c.lon 
join  cte2 as c2  
on i.tiv_2015 = c2.tiv_2015






