/* Write your T-SQL query statement below */

select p.product_id , p.product_name
from sales as s 
left join product as p
on s.product_id = p.product_id
group by p.product_id , p.product_name
having min(sale_date)>='2019-01-01' and max(sale_date)<='2019-03-31'