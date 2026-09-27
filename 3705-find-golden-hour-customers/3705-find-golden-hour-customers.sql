/* Write your T-SQL query statement below */
SELECT 
    customer_id,
    COUNT(*) AS total_orders,

    round(100.0 * SUM(
        CASE 
            WHEN CAST(order_timestamp AS TIME) BETWEEN '11:00:00' AND '14:00:00'
              OR CAST(order_timestamp AS TIME) BETWEEN '18:00:00' AND '21:00:00'
            THEN 1 
            ELSE 0 
        END
    ) / COUNT(*),0) AS peak_hour_percentage,

    round(AVG(1.0*order_rating),2) AS average_rating

FROM restaurant_orders

GROUP BY customer_id

HAVING COUNT(*) >= 3

   AND 100.0 * SUM(
        CASE 
            WHEN CAST(order_timestamp AS TIME) BETWEEN '11:00:00' AND '14:00:00'
              OR CAST(order_timestamp AS TIME) BETWEEN '18:00:00' AND '21:00:00'
            THEN 1 
            ELSE 0 
        END
   ) / COUNT(*) >= 60

   AND AVG(order_rating) >= 4.0

   AND 1.0 * SUM(
        CASE 
            WHEN order_rating IS NOT NULL THEN 1 
            ELSE 0 
        END
   ) / COUNT(*) >= 0.5

ORDER BY 
    average_rating DESC,
    customer_id DESC;