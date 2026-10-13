/* Write your T-SQL query statement below */
-- with cte as (
--     select * , value as string_split
--     from logs 
--     cross apply string_split(ip,'.')
-- ),
-- cte1 as (
--     select log_id , ip,  value  , count(*) over (partition  by log_id) as count
--     from cte
-- ),
-- cte2 as (
--     select  log_id , ip
--     from cte1
--     where count !=4
--     or cast(value as int) >255
--     or value like '0[0-9]%'
--     group by log_id , ip
-- )
-- select ip , count(*) as invalid_count
-- from cte2
-- group by ip
-- order by invalid_count desc , ip desc

SELECT ip, COUNT(*) AS invalid_count
FROM logs
WHERE LEN(ip) - LEN(REPLACE(ip, '.', '')) <> 3
   OR EXISTS (
       SELECT 1
       FROM STRING_SPLIT(ip, '.')
       WHERE TRY_CAST(value AS INT) > 255
          OR TRY_CAST(value AS INT) IS NULL
          OR value LIKE '0[0-9]%'
   )
GROUP BY ip
ORDER BY invalid_count DESC, ip DESC;