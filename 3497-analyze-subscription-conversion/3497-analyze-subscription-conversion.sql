/* Write your T-SQL query statement below */
with cte as (
select distinct user_id , cast(avg(case when activity_type='free_trial' then activity_duration*1.0 end) as decimal(10,2)) as trial_avg_duration  , cast(avg(case when activity_type='paid' then activity_duration*1.0 end)as decimal(10,2)) as paid_avg_duration 
from useractivity 
group by user_id )
select * 
from cte 
where paid_avg_duration  is not null and trial_avg_duration is not null
order by user_id