-- Query 13: Restaurants with stable order quantity
-- Finds restaurants with low variation (standard deviation) in monthly order quantity.
WITH monthly_qty AS (
  SELECT o.r_id, DATE_TRUNC('month', o.order_date) AS month, SUM(o.sales_qty) AS total_quantity
  FROM orders o GROUP BY o.r_id, month
), stddevs AS (
  SELECT r_id, STDDEV_POP(total_quantity) AS qty_stddev FROM monthly_qty GROUP BY r_id
)
SELECT r.r_id, r.name, s.qty_stddev FROM stddevs s JOIN restaurants r ON s.r_id = r.r_id
WHERE s.qty_stddev IS NOT NULL ORDER BY s.qty_stddev ASC;