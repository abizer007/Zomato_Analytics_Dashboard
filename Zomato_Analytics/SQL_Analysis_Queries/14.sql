-- Query 14: High ratings but low sales restaurants (potentially under-marketed)
-- Spots high-rated restaurants with disproportionately low sales.
SELECT r.r_id, r.name, r.rating, SUM(o.sales_amount) AS total_sales
FROM orders o
JOIN restaurants r ON o.r_id = r.r_id
WHERE r.rating ~ '^[0-9.]+'
GROUP BY r.r_id, r.name, r.rating
HAVING CAST(r.rating AS NUMERIC) >= 4.5 AND SUM(o.sales_amount) < 5000;