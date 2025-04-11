-- Query 17: Customers who place consistently low-spend orders
-- Identifies customers with the lowest average order value consistently.
SELECT 
  u.user_id, 
  u.name, 
  AVG(o.sales_amount) AS avg_order_value
FROM users u
JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.name
ORDER BY avg_order_value ASC;