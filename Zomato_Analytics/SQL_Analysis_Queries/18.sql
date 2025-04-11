-- Query 18: Average sales and order count by restaurant rating tier
-- Calculates total orders and revenue, grouped by restaurant rating tiers.
SELECT 
  CASE 
    WHEN CAST(r.rating AS NUMERIC) >= 4.5 THEN 'High Rated'
    WHEN CAST(r.rating AS NUMERIC) >= 3.5 THEN 'Medium Rated'
    WHEN CAST(r.rating AS NUMERIC) >= 0 THEN 'Low Rated'
    ELSE 'Unrated'
  END AS rating_tier,
  COUNT(*) AS total_orders,
  SUM(o.sales_amount) AS total_revenue
FROM orders o
JOIN restaurants r ON o.r_id = r.r_id
WHERE r.rating ~ '^[0-9.]+$'
GROUP BY rating_tier
ORDER BY total_revenue DESC;