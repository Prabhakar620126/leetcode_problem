/* Write your T-SQL query statement below */
WITH cte AS (
    SELECT c1.patient_id , min(case when c1.result='Positive' and c2.result='Negative' then c1.test_date end)  as st_date ,
    min(case when c1.result='Positive' and c2.result ='Negative' then c2.test_date end) as end_date
    FROM covid_tests c1
    join covid_tests c2
    on c1.patient_id=c2.patient_id and c1.test_date < c2.test_date
    group by c1.patient_id
)
SELECT 
    c.patient_id,
    p.patient_name,
    p.age,
    DATEDIFF(day, c.st_date, c.end_date) AS recovery_time
FROM cte AS c
JOIN patients AS p
    ON c.patient_id = p.patient_id
WHERE c.st_date IS NOT NULL
  AND c.end_date IS NOT NULL
 and DATEDIFF(day, c.st_date, c.end_date) >0 
 order by recovery_time , p.patient_name;