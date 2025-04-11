-- Query 8: Repeat vs. one-time customers
-- Classifies customers based on frequency of distinct order dates.
SELECT user_id, COUNT(DISTINCT order_date) AS order_count,
CASE WHEN COUNT(DISTINCT order_date) > 1 THEN 'Repeat' ELSE 'One-time' END AS customer_type
FROM orders GROUP BY user_id;