/* Write your T-SQL query statement below */
-- select lb.book_id , lb.title , lb.author , lb.genre , lb.publication_year  , lb.total_copies , count(br.return_date)
-- from library_books as lb
-- left join borrowing_records as br 
-- on lb.book_id = br.book_id 
-- group by lb.book_id  , lb.title , lb.author , lb.genre , lb.publication_year  , lb.total_copies 
with cte as (
select book_id , count(*) as count
from borrowing_records 
where return_date is null
group by book_id)
select lb.book_id , lb.title , lb.author , lb.genre , lb.publication_year , lb.total_copies as current_borrowers
from library_books as lb
left join cte as c 
on lb.book_id= c.book_id 
where lb.total_copies=c.count
order by current_borrowers desc , lb.title asc