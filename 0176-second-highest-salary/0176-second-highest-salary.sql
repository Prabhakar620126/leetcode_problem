/* Write your T-SQL query statement below */
with cte as (
    select  * , dense_rank() over(order by salary desc) as rn 
    from employee  )

select max(salary)  as SecondHighestSalary
from cte 
where rn=2



