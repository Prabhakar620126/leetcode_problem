WITH cte AS (
    SELECT 
        m.user_id,
        u.name,
        COUNT(*) AS no_rate
    FROM movierating AS m
    LEFT JOIN users AS u
        ON m.user_id = u.user_id
    GROUP BY m.user_id, u.name
),

cte1 AS (
    SELECT 
        m.movie_id,
        mo.title,
        cast(sum(m.rating)*1.0 /count(*) as decimal(10,2)) AS average_rating
    FROM movierating AS m
    LEFT JOIN movies AS mo
        ON m.movie_id = mo.movie_id
    WHERE m.created_at >= '2020-02-01'
      AND m.created_at < '2020-03-01'
    GROUP BY m.movie_id, mo.title
),

user_result AS (
    SELECT TOP 1
        name AS results
    FROM cte
    ORDER BY no_rate DESC, name ASC
),

movie_result AS (
    SELECT TOP 1
        title AS results
    FROM cte1
    ORDER BY average_rating DESC, title ASC
)

SELECT results
FROM user_result

UNION ALL

SELECT results
FROM movie_result;