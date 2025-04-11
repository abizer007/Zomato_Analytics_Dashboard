-- Query 19: Restaurants with highest sales variation by day of the week
-- Finds restaurants that have large fluctuations in sales throughout the week.
WITH daily_sales AS (
  SELECT 
    r.r_id, 
    EXTRACT(DOW FROM o.order_date) AS day_of_week, 
    SUM(o.sales_amount) AS daily_sales
  FROM orders o
  JOIN restaurants r ON o.r_id = r.r_id
  GROUP BY r.r_id, day_of_week
)
SELECT 
  r.r_id, 
  r.name, 
  MAX(daily_sales) - MIN(daily_sales) AS sales_variation
FROM daily_sales d
JOIN restaurants r ON d.r_id = r.r_id
GROUP BY r.r_id, r.name
ORDER BY sales_variation DESC;