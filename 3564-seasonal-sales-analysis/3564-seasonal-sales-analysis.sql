/* Write your T-SQL query statement below */
WITH cte AS (
    SELECT 
        s.*,
        p.category,
        CASE 
            WHEN MONTH(sale_date) IN (12, 1, 2) THEN 'Winter'
            WHEN MONTH(sale_date) IN (3, 4, 5) THEN 'Spring'
            WHEN MONTH(sale_date) IN (6, 7, 8) THEN 'Summer'
            ELSE 'Fall'
        END AS season
    FROM sales AS s
    JOIN products AS p
        ON s.product_id = p.product_id
),

cte1 AS (
    SELECT 
        season,
        category,
        SUM(quantity) AS total_quantity,
        SUM(quantity * price) AS total_revenue,
        ROW_NUMBER() OVER (
            PARTITION BY season
            ORDER BY sum(quantity)desc ,
                SUM(quantity * price) DESC,
                category ASC
        ) AS rn
    FROM cte
    GROUP BY season, category
)

SELECT 
    season,
    category,
    total_quantity,
    total_revenue
FROM cte1
WHERE rn = 1;