/* Write your T-SQL query statement below */
with cte as (
select * , row_number() over(partition by user_id order by event_date desc) as rn_des , case when event_type ='downgrade' then 1 end as down_cont 
from subscription_events )

select user_id , max(case when rn_des=1 then plan_name end) as current_plan , max(case when rn_des= 1 then  monthly_amount  end) as  current_monthly_amount , max(monthly_amount) as max_historical_amount , datediff(day , min(event_date), max(event_date)) as days_as_subscriber
from cte 
group by user_id
having count(down_cont)>=1 
and max(case when rn_des=1   then plan_name  end) <>'cancle' 
and datediff(day , min(event_date), max(event_date)) >=60
and  max(case when rn_des= 1 then  monthly_amount end ) < 0.5 * max(monthly_amount)
order by datediff(day , min(event_date), max(event_date)) desc , user_id asc 
