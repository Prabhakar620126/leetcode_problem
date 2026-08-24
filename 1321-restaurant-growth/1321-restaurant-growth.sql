/* Write your T-SQL query statement below */
with cte as (
select visited_on , sum(amount) as amount ,row_number() over(order by visited_on) as rn
from customer 
group by visited_on 
),
cte2 as (
select visited_on , rn  , sum(amount) over( order by visited_on rows between 6 preceding and current row) as amount 
from cte)
select visited_on , amount , cast(round(amount/7.0,2) as decimal(10,2)) as average_amount
from cte2
where rn >=7
