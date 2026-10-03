/* Write your T-SQL query statement below */

WITH cte AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY user_id 
               ORDER BY event_date DESC
           ) AS rn
    FROM subscription_events
)

SELECT
    user_id,
    MAX(CASE WHEN rn = 1 THEN plan_name END) AS current_plan,
    MAX(CASE WHEN rn = 1 THEN monthly_amount END) AS current_monthly_amount,
    MAX(monthly_amount) AS max_historical_amount,
    DATEDIFF(DAY, MIN(event_date), MAX(event_date)) AS days_as_subscriber
FROM cte
GROUP BY user_id
HAVING
    -- Currently active: latest event is NOT cancel
    MAX(CASE WHEN rn = 1 THEN event_type END) <> 'cancel'

    -- At least one downgrade
    AND SUM(CASE WHEN event_type = 'downgrade' THEN 1 ELSE 0 END) >= 1

    -- Subscriber for at least 60 days
    AND DATEDIFF(DAY, MIN(event_date), MAX(event_date)) >= 60

    -- Current revenue is less than 50% of historical maximum
    AND MAX(CASE WHEN rn = 1 THEN monthly_amount END)
        < 0.5 * MAX(monthly_amount)

ORDER BY
    days_as_subscriber DESC,
    user_id ASC;