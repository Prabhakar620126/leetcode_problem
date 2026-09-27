/* Write your T-SQL query statement below */
select customer_id 
from customer_transactions 
group by customer_id 
having count(*)>=3 and datediff(day , min(transaction_date),max(transaction_date))>=30  and 
1.0*sum(case when transaction_type = 'refund' then 1 else 0 end)/count(*)  < 0.2