/* Write your T-SQL query statement below */

WITH cte AS (
    SELECT
        user_id,
        reaction,
        COUNT(*) AS reaction_count
    FROM reactions
    GROUP BY user_id, reaction
),
cte2 AS (
    SELECT
        user_id,
        SUM(reaction_count) AS total_count,
        MAX(reaction_count) AS max_count
    FROM cte
    GROUP BY user_id
),
cte3 AS (
    SELECT
        user_id,
        reaction,
        reaction_count,
        ROW_NUMBER() OVER (
            PARTITION BY user_id
            ORDER BY reaction_count DESC, reaction
        ) AS rn
    FROM cte
)
SELECT
    c3.user_id,
    c3.reaction AS dominant_reaction,
    ROUND(
        1.0 * c3.reaction_count / c2.total_count,
        2
    ) AS reaction_ratio
FROM cte3 AS c3
JOIN cte2 AS c2
    ON c3.user_id = c2.user_id
WHERE c3.rn = 1
  AND 1.0 * c3.reaction_count / c2.total_count >= 0.60
  AND (
      SELECT COUNT(DISTINCT r.content_id)
      FROM reactions AS r
      WHERE r.user_id = c3.user_id
  ) >= 5
ORDER BY
    reaction_ratio DESC,
    c3.user_id ASC;