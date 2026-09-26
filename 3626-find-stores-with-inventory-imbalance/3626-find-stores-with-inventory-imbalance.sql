WITH ranked_inventory AS (
    SELECT 
        store_id,
        product_name,
        quantity,
        ROW_NUMBER() OVER (
            PARTITION BY store_id 
            ORDER BY price DESC, inventory_id ASC
        ) AS max_rn,
        ROW_NUMBER() OVER (
            PARTITION BY store_id 
            ORDER BY price ASC, inventory_id ASC
        ) AS min_rn
    FROM inventory
)
SELECT 
    r.store_id,
    s.store_name,
    s.location,
    MAX(CASE WHEN r.max_rn = 1 THEN r.product_name END) AS most_exp_product,
    MAX(CASE WHEN r.min_rn = 1 THEN r.product_name END) AS cheapest_product,
    CAST(
        (MAX(CASE WHEN r.min_rn = 1 THEN r.quantity END) * 1.0) /
        NULLIF(MAX(CASE WHEN r.max_rn = 1 THEN r.quantity END), 0)
        AS DECIMAL(10, 2)
    ) AS imbalance_ratio
FROM ranked_inventory AS r
JOIN stores AS s 
    ON r.store_id = s.store_id
GROUP BY 
    r.store_id,
    s.store_name,
    s.location
HAVING 
    COUNT(*) >= 3 
    AND MAX(CASE WHEN r.max_rn = 1 THEN r.quantity END) < MAX(CASE WHEN r.min_rn = 1 THEN r.quantity END)
ORDER BY 
    imbalance_ratio DESC,
    s.store_name ASC;