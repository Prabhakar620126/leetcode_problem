/* Write your T-SQL query statement below */
with cte as (
    select book_id , sum(case when session_rating>=4  then 1 else 0 end) as greter_count, sum(case when  session_rating<=2 then 1 else 0 end) as lower_count , max(session_rating) as max_rate , min(session_rating) as min_rate  , count(*) as total_count
from reading_sessions
group by book_id 
having count(*)>=5 and sum(case when session_rating>=4  then 1 else 0 end)>=1 and sum(case when  session_rating<=2 then 1 else 0 end) >=1 )
select c.book_id , b.title , b.author ,b.genre , b.pages , (c.max_rate - c.min_rate ) as rating_spread  , round(1.0*(c.greter_count+c.lower_count)/c.total_count ,2) as polarization_score 
from cte as c
left join books as b 
on c.book_id = b.book_id  
where 1.0*(c.greter_count+c.lower_count)/c.total_count >=0.6
order by polarization_score desc , b.title desc