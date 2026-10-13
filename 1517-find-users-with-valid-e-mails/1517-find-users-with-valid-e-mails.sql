/* Write your T-SQL query statement below */
SELECT *
FROM Users
WHERE mail COLLATE Latin1_General_BIN2 LIKE '[A-Za-z]%'
  AND mail COLLATE Latin1_General_BIN2 LIKE '%@leetcode.com'
  AND mail COLLATE Latin1_General_BIN2
      NOT LIKE '%[^A-Za-z0-9_.-]%@leetcode.com';