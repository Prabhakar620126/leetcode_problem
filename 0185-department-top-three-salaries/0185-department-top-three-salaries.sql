/* Write your T-SQL query statement below */
with cte as (
select d.name as Department  , e.name as Employee, e.salary as Salary , dense_rank()over(partition by departmentId order by salary desc ) as rn
from employee  as e 
left join department as d 
on e.departmentId =d.id
)
select Department , Employee , Salary
from cte  
where rn <=3
