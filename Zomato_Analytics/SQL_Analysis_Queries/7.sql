-- Query 7: Sales trends by season, month, and week
-- Detects peak periods by aggregating total sales according to month, week, and season.
SELECT TO_CHAR(order_date, 'YYYY-MM') AS month, EXTRACT(WEEK FROM order_date) AS week,
  CASE 
    WHEN EXTRACT(MONTH FROM order_date) IN (12,1,2) THEN 'Winter'
    WHEN EXTRACT(MONTH FROM order_date) IN (3,4,5) THEN 'Spring'
    WHEN EXTRACT(MONTH FROM order_date) IN (6,7,8) THEN 'Summer'
    ELSE 'Autumn' END AS season,
SUM(sales_amount) AS total_sales FROM orders GROUP BY month, week, season ORDER BY month;