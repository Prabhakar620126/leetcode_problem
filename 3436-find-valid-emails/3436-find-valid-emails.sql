/* Write your T-SQL query statement below */
-- SELECT user_id , email
-- FROM Users
-- WHERE email LIKE '[a-zA-Z0-9_]%@[a-zA-Z]%.com' AND
--       email NOT LIKE '%..%' AND 
--       email NOT LIKE '%.%@%' AND
--       email NOT LIKE '%@[a-zA-Z]%[0-9]%' and 
--       email not like '%|%'
-- ORDER BY user_id

/* Write your T-SQL query statement below */
SELECT user_id, email
FROM Users
WHERE email LIKE '%_@_%.com'
  AND email NOT LIKE '%@%@%'
  AND email NOT LIKE '%[^a-zA-Z0-9_]%@%'
  AND email NOT LIKE '%@%[^a-zA-Z]%.com'
ORDER BY user_id ASC;