/* Write your T-SQL query statement below */
with cte as (
    select user_id , upper(substring(name,1,1)) as first_ , lower(substring(name,2,len(name))) as last_
from users)
select user_id , concat(first_, last_) as name
from cte
order by user_id
