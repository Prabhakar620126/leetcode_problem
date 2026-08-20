/* Write your T-SQL query statement below */
SELECT *
FROM products
WHERE PATINDEX(
    '%[^a-zA-Z0-9]SN[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][^a-zA-Z0-9]%',
    (' ' + description + ' ') COLLATE Latin1_General_100_BIN2
) > 0
ORDER BY product_id;