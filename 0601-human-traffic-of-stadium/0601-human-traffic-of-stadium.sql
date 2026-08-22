/* Write your T-SQL query statement below */
with cte as (
select * ,lag(id)over(order by id)as lag_id , lead(id) over (order by id) as lead_id 
from stadium 
where people >=100 
),
cte2 as (
select *  , case when (id-lag_id) =1 and (lead_id-id)=1 then 1 else 0 end as is_valid
from cte)
select id, visit_date , people 
from cte2 
where is_valid=1
or id in (select lag_id from cte2 where is_valid =1 )
or id in (select lead_id from cte2 where is_valid =1 )
order by visit_date

