/* Write your T-SQL query statement below */
with cte as(
select p.employee_id , p.review_date , p.rating , row_number()over(partition by employee_id order by review_date desc) as rn 
from performance_reviews as p),
cte1 as (
select employee_id  , max(case when rn=1 then rating end) as latest_rate , max(case when rn=3 then rating end) as first_rate 
from cte
group by employee_id
having max(rn)>=3)
select c.employee_id , e.name , (latest_rate-first_rate) as improvement_score
from cte1 as c
join employees as e 
on c.employee_id=e.employee_id
where (latest_rate-first_rate)>1
order by improvement_score desc , name asc