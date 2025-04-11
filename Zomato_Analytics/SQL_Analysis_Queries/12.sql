-- Query 12: Restaurants with increasing/decreasing sales trends
-- Analyzes correlation between monthly sales and time to identify trends.
WITH sales_monthly AS (
  SELECT o.r_id,
         DATE_TRUNC('month', o.order_date) AS month,
         SUM(o.sales_amount) AS monthly_sales
  FROM orders o
  WHERE o.r_id IS NOT NULL
  GROUP BY o.r_id, month
)
SELECT r.r_id, r.name,
       CORR(EXTRACT(EPOCH FROM sm.month), sm.monthly_sales) AS sales_trend
FROM sales_monthly sm
JOIN restaurants r ON sm.r_id = r.r_id
GROUP BY r.r_id, r.name
HAVING CORR(EXTRACT(EPOCH FROM sm.month), sm.monthly_sales) IS NOT NULL;