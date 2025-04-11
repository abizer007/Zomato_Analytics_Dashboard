-- Query 4: Average order value per customer and identify high-value customers
-- Finds customers whose lifetime spending exceeds 5000 and calculates their average order value.
SELECT u.user_id, u.name, AVG(o.sales_amount) AS avg_order_value, SUM(o.sales_amount) AS total_spent
FROM orders o JOIN users u ON o.user_id = u.user_id
GROUP BY u.user_id, u.name HAVING SUM(o.sales_amount) > 5000 ORDER BY total_spent DESC;