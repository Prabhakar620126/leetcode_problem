SELECT
    id,
    sum(CASE WHEN month = 'Jan' THEN revenue END) AS Jan_Revenue,
    sum(CASE WHEN month = 'Feb' THEN revenue END) AS Feb_Revenue,
    sum(CASE WHEN month = 'Mar' THEN revenue END) AS Mar_Revenue,
    sum(CASE WHEN month = 'Apr' THEN revenue END) AS Apr_Revenue,
    sum(CASE WHEN month = 'May' THEN revenue END) AS May_Revenue,
    sum(CASE WHEN month = 'Jun' THEN revenue END) AS Jun_Revenue,
    sum(CASE WHEN month = 'Jul' THEN revenue ENd) AS Jul_Revenue,
    sum(CASE WHEN month = 'Aug' THEN revenue END) AS Aug_Revenue,
    sum(CASE WHEN month = 'Sep' THEN revenue END) AS Sep_Revenue,
    sum(CASE WHEN month = 'Oct' THEN revenue END) AS Oct_Revenue,
    sum(CASE WHEN month = 'Nov' THEN revenue END) AS Nov_Revenue,
    sum(CASE WHEN month = 'Dec' THEN revenue END) AS Dec_Revenue
FROM Department 
group by id
