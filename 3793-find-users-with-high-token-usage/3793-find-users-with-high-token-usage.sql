/* Write your T-SQL query statement below */
-- with cte as (
-- select   user_id , count(*) as counts , round(avg(cast(tokens as decimal(10,2))),2) as average
-- from prompts
-- group by user_id
-- having count(*) >2 )
-- select distinct c.user_id , c.counts  as prompt_count , c.average as avg_tokens 
-- from cte as c 
-- join prompts as p 
-- on c.user_id = p.user_id 
-- where p.tokens>c.average
-- order by avg_tokens desc , user_id asc

/* Write your T-SQL query statement below */


SELECT USER_ID,COUNT(PROMPT) AS prompt_count ,CAST(AVG(CAST(TOKENS AS DECIMAL(10,2))) AS DECIMAL(10,2)) AS avg_tokens
FROM PROMPTS
GROUP BY USER_ID
HAVING COUNT(PROMPT) >= 3 
AND MAX(TOKENS) > CAST(AVG(CAST(TOKENS AS DECIMAL(10,2))) AS DECIMAL(10,2)) 
ORDER BY avg_tokens DESC,USER_ID 
