/* Write your T-SQL query statement below */
with cte as (
select  pr.product_id as product1_id , p.product_id as product2_id , count(distinct pr.user_id) as customer_count
from productpurchases as pr
join productpurchases as p
on pr.user_id=p.user_id and pr.product_id < p.product_id
group by pr.product_id , p.product_id  
having count(distinct pr.user_id) >=3
),
cte1 as (
select pf.product_id as product1_id , prf.product_id as product2_id , pf.category as product1_category , prf.category as product2_category 
from productinfo as pf 
join productinfo as prf 
on pf.product_id < prf.product_id )
select c.product1_id ,c.product2_id ,c1.product1_category ,c1.product2_category ,c.customer_count 
from cte as c
join cte1 as c1
on c.product1_id=c1.product1_id and c.product2_id=c1.product2_id
order by c.customer_count desc ,c.product1_id , c.product2_id 
