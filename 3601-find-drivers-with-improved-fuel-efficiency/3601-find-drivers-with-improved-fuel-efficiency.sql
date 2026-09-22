WITH cte AS (
    SELECT 
        driver_id,
        CASE 
            WHEN MONTH(trip_date) IN (1,2,3,4,5,6) 
                THEN 'first half'
            ELSE 'second half'
        END AS season,
        AVG(
            CAST(distance_km AS DECIMAL(10,4)) 
            / NULLIF(fuel_consumed, 0)
        ) AS eff
    FROM trips
    GROUP BY 
        driver_id,
        CASE 
            WHEN MONTH(trip_date) IN (1,2,3,4,5,6) 
                THEN 'first half'
            ELSE 'second half'
        END
),
cte2 AS (
    SELECT 
        c.driver_id,
        d.driver_name,

        MAX(CASE 
                WHEN season = 'first half' 
                THEN eff
            END) AS fi_eff,

        MAX(CASE 
                WHEN season = 'second half' 
                THEN eff
            END) AS se_eff

    FROM cte AS c
    JOIN drivers AS d
        ON c.driver_id = d.driver_id

    GROUP BY 
        c.driver_id,
        d.driver_name
)

SELECT 
    driver_id,
    driver_name,
    CAST(fi_eff AS DECIMAL(10,2)) AS first_half_avg,
    CAST(se_eff AS DECIMAL(10,2)) AS second_half_avg,
    CAST(se_eff - fi_eff AS DECIMAL(10,2)) AS efficiency_improvement
FROM cte2
WHERE fi_eff IS NOT NULL
  AND se_eff IS NOT NULL
  and se_eff - fi_eff >0
ORDER BY 
    se_eff - fi_eff DESC,
    driver_name ASC;