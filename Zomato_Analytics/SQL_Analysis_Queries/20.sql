-- Query 20: Menu items with increasing sales momentum
-- Identifies food items with sales growth comparing the recent 90-day period to previous periods.
WITH recent_sales AS (
  SELECT 
    m.f_id, 
    SUM(o.sales_qty) AS qty_last_60
  FROM orders o
  JOIN menu m ON o.r_id = m.r_id
  WHERE o.order_date >= CURRENT_DATE - INTERVAL '90 days'
  GROUP BY m.f_id
),
previous_sales AS (
  SELECT 
    m.f_id, 
    SUM(o.sales_qty) AS qty_prev
  FROM orders o
  JOIN menu m ON o.r_id = m.r_id
  WHERE o.order_date < CURRENT_DATE - INTERVAL '90 days'
  GROUP BY m.f_id
)
SELECT 
  f.item, 
  COALESCE(r.qty_last_60, 0) AS qty_last_60, 
  COALESCE(p.qty_prev, 0) AS qty_prev
FROM food f
LEFT JOIN recent_sales r ON f.f_id = r.f_id
LEFT JOIN previous_sales p ON f.f_id = p.f_id
ORDER BY qty_last_60 DESC;