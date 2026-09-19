/* Write your T-SQL query statement below */
with cte as (
select * , row_number() over(partition by student_id , subject order by exam_date ) as first_rn  ,row_number() over(partition by student_id , subject order by exam_date desc ) as last_rn 
from scores)

select student_id , subject ,max(case when first_rn=1 then score end) as first_score , max(case when last_rn=1 then score end) as Latest_score 
from cte 
group by student_id , subject 
having max(case when last_rn=1 then score end) > max(case when first_rn=1 then score end)
order by student_id , subject 
 