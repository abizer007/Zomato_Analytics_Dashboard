-- Query 11: Order quantity variation per restaurant over time
-- Measures correlation of sales quantity with time to understand quantity trends.
WITH qty_trend AS (
  SELECT o.r_id,
         DATE_TRUNC('month', o.order_date) AS month,
         SUM(o.sales_qty) AS total_quantity
  FROM orders o
  WHERE o.r_id IS NOT NULL
  GROUP BY o.r_id, month
)
SELECT r.r_id, r.name,
       CORR(EXTRACT(EPOCH FROM qt.month), qt.total_quantity) AS qty_trend_score
FROM qty_trend qt
JOIN restaurants r ON qt.r_id = r.r_id
GROUP BY r.r_id, r.name
HAVING CORR(EXTRACT(EPOCH FROM qt.month), qt.total_quantity) IS NOT NULL;