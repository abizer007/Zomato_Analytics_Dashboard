-- Query 6: Restaurants with low ratings but high sales
-- Identifies restaurants that have ratings below 3.0 but sales over 10,000 indicating potential quality issues.
SELECT r.r_id, r.name, r.rating, SUM(o.sales_amount) AS total_sales
FROM orders o JOIN restaurants r ON o.r_id = r.r_id WHERE r.rating ~ '^[0-9.]+'
GROUP BY r.r_id, r.name, r.rating HAVING CAST(r.rating AS NUMERIC) < 3.0 AND SUM(o.sales_amount) > 10000
ORDER BY total_sales DESC;