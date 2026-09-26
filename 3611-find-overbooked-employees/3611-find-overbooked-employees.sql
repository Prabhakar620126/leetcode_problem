/* Write your T-SQL query statement below */
with cte as (
    select m.employee_id, e.employee_name  , e.department ,  datepart(iso_week , meeting_date) as week_no , datepart(year , meeting_date) as yr , sum(duration_hours) as weekly_hour 
from meetings as m
join employees as e 
on m.employee_id = e.employee_id 
group by datepart(iso_week , meeting_date) , datepart(year , meeting_date), m.employee_id , e.employee_name  , e.department
having sum(duration_hours) >20)
select employee_id , employee_name , department ,count(*) as meeting_heavy_weeks
from cte 
group by employee_id , employee_name , department 
having count(week_no)>=2
order by meeting_heavy_weeks desc , employee_name 