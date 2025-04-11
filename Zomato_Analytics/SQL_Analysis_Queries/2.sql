-- Query 2: Yearly sales per restaurant and identify highest sales year
-- Calculates yearly total sales per restaurant and identifies the highest sales year for each restaurant.
WITH SalesByYear AS (
  SELECT EXTRACT(YEAR FROM o.order_date) AS year, o.r_id, r.name AS restaurant_name, SUM(o.sales_amount) AS total_sales
  FROM orders o JOIN restaurants r ON o.r_id = r.r_id
  GROUP BY year, o.r_id, r.name
),
MaxSalesYear AS (
  SELECT r_id, MAX(total_sales) AS max_sales FROM SalesByYear GROUP BY r_id
)
SELECT s.year, s.restaurant_name, s.total_sales, ms.max_sales,
  CASE WHEN s.total_sales = ms.max_sales THEN 'Highest Sales' ELSE 'Not Highest' END AS sales_comparison
FROM SalesByYear s JOIN MaxSalesYear ms ON s.r_id = ms.r_id
ORDER BY s.r_id, s.year;

-- Total sales by year (Overall)
SELECT EXTRACT(YEAR FROM order_date) AS year, SUM(sales_amount) AS total_sales
FROM orders
GROUP BY year
ORDER BY year ASC;