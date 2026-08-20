WITH cte AS (
    SELECT requester_id AS id
    FROM requestaccepted

    UNION ALL

    SELECT accepter_id AS id
    FROM requestaccepted
),
cte2 AS (
    SELECT
        id,
        COUNT(*) AS num
    FROM cte
    GROUP BY id
)
SELECT TOP 1
    id,
    num
FROM cte2
ORDER BY num DESC, id ASC;