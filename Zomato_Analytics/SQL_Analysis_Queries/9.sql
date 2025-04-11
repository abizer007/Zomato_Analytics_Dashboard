-- Query 9: Customers with highest lifetime spending
-- Finds the top 10 customers with the greatest total lifetime spending.
SELECT u.user_id, u.name, SUM(o.sales_amount) AS lifetime_spending
FROM orders o JOIN users u ON o.user_id = u.user_id GROUP BY u.user_id, u.name
ORDER BY lifetime_spending DESC LIMIT 10;