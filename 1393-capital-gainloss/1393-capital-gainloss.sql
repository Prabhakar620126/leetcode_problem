/* Write your T-SQL query statement below */
with cte as (
select * , case when operation='Sell' then price else -(price) end as up_price
from Stocks )
select stock_name , sum(up_price) as capital_gain_loss
from cte 
group by stock_name 