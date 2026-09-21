/* Write your T-SQL query statement below */

with cte as (
select s.* ,p.category,case when month(sale_date) in (12,1,2) then 'Winter'  when month(sale_date) in (3,4,5) then 'Spring' when month(sale_date) in (6,7,8) then 'Summer' else 'Fall'
end as season
from sales as s
join products as p
on s.product_id=p.product_id),
cte1 as (
select season , category , sum(quantity) as total_quantity , sum(quantity*price) as total_revenue , row_number() over(partition by season order by sum(quantity) desc ,sum(quantity*price) desc , category asc)  as rn
from cte
group by season , category)
select season , category , total_quantity , total_revenue 
from cte1
where rn=1