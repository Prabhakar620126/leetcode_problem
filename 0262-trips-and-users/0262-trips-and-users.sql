/* Write your T-SQL query statement below */
with cte as (
select status , request_at 
from Trips 
where client_id   not in (
    select users_id  from Users where banned = 'Yes'
    )
    and 
    driver_id   not in (
    select users_id  from Users where banned = 'Yes'
    )
)
select request_at as Day, CAST(
        SUM(CASE WHEN status LIKE 'cancelled%' THEN 1 ELSE 0 END) * 1.0
        / count(*)
        AS DECIMAL(10,2)
    ) AS [Cancellation Rate]
from cte 
group by request_at 
having request_at between '2013-10-01' and '2013-10-03'
