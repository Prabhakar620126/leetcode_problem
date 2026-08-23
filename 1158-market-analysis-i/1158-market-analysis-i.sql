/* Write your T-SQL query statement below */
with cte as(
select order_date , buyer_id , seller_id 
from Orders
where year(order_date) = 2019),
cte2 as (select u.user_id , u.join_date, c.seller_id 
from users as u
left join cte  as c 
on u.user_id = c.buyer_id)
select user_id  as buyer_id , join_date , count(seller_id) as orders_in_2019
from cte2
group by user_id , join_date 
order by user_id , join_date 
