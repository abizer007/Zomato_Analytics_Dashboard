-- 1. Top 5 Highest-Rated Restaurants in Each City
SELECT city, name, CAST(rating AS FLOAT) AS rating
FROM (
    SELECT city, name, rating,
           ROW_NUMBER() OVER (PARTITION BY city ORDER BY CAST(NULLIF(rating,'--') AS FLOAT) DESC) AS rating_rank
    FROM restaurants
    WHERE rating != '--'
) ranked
WHERE rating_rank <= 5
ORDER BY city, rating DESC;

-- 2. Restaurants with Highest Sales Revenue in Last 6 Months
SELECT r.id, r.name, SUM(o.sales_amount) AS total_sales_last_6mo
FROM orders o
JOIN restaurants r ON o.r_id = r.id
WHERE o.order_date >= (CURRENT_DATE - INTERVAL '6 months')
GROUP BY r.id, r.name
ORDER BY total_sales_last_6mo DESC
LIMIT 5;

-- 3. Most Ordered Cuisines in Each Country and City
SELECT r.Country, r.city, m.cuisine, COUNT(*) AS order_count
FROM orders o
JOIN restaurants r ON o.r_id = r.id
JOIN menu m ON m.r_id = r.id
GROUP BY r.Country, r.city, m.cuisine
ORDER BY r.Country, r.city, order_count DESC;

-- 4. Average Order Value per Customer & High-Value Customers
SELECT u.user_id, u.name, AVG(o.sales_amount) AS avg_order_value,
       SUM(o.sales_amount) AS total_spent
FROM orders o
JOIN users u ON o.user_id = u.user_id
GROUP BY u.user_id, u.name
ORDER BY avg_order_value DESC
LIMIT 5;

-- 5. Most Frequently Ordered Menu Items Across Restaurant Categories
SELECT m.cuisine AS restaurant_category, f.item AS food_item, COUNT(*) AS order_count
FROM orders o
JOIN menu m ON o.r_id = m.r_id
JOIN food f ON m.f_id = f.f_id
GROUP BY m.cuisine, f.item
ORDER BY order_count DESC;

-- 6. Restaurants with Low Ratings (<3) but High Sales
SELECT r.id, r.name, r.city, CAST(r.rating AS FLOAT) AS rating, SUM(o.sales_amount) AS total_sales
FROM restaurants r
JOIN orders o ON o.r_id = r.id
WHERE CAST(NULLIF(r.rating,'--') AS FLOAT) < 3
GROUP BY r.id, r.name, r.city, rating
HAVING SUM(o.sales_amount) > (SELECT AVG(sales_amount) FROM orders)
ORDER BY total_sales DESC;

-- 7. Sales Trends by Quarter
SELECT EXTRACT(YEAR FROM order_date) AS year,
       EXTRACT(QUARTER FROM order_date) AS quarter,
       SUM(sales_amount) AS total_sales
FROM orders
GROUP BY year, quarter
ORDER BY year, quarter;

-- 8. Repeat Customers vs. One-Time Customers
SELECT
    SUM(CASE WHEN cnt = 1 THEN 1 ELSE 0 END) AS one_time_customers,
    SUM(CASE WHEN cnt > 1 THEN 1 ELSE 0 END) AS repeat_customers
FROM (
    SELECT user_id, COUNT(*) AS cnt FROM orders GROUP BY user_id
) customer_counts;

-- 9. Customers with Highest Lifetime Spending
SELECT u.user_id, u.name, SUM(o.sales_amount) AS total_spent
FROM orders o
JOIN users u ON o.user_id = u.user_id
GROUP BY u.user_id, u.name
ORDER BY total_spent DESC
LIMIT 5;

-- 10. Best-Selling Food Categories Across Cities
SELECT city, category, total_orders FROM (
    SELECT r.city, f.veg_or_non_veg AS category, COUNT(*) AS total_orders,
           ROW_NUMBER() OVER (PARTITION BY r.city ORDER BY COUNT(*) DESC) AS rn
    FROM orders o
    JOIN restaurants r ON o.r_id = r.id
    JOIN menu m ON m.r_id = r.id
    JOIN food f ON m.f_id = f.f_id
    GROUP BY r.city, category
) t WHERE rn = 1
ORDER BY city;

-- 12. Restaurants with Increasing or Decreasing Sales Trends
WITH yearly_sales AS (
    SELECT r_id, EXTRACT(YEAR FROM order_date) AS year,
           SUM(sales_amount) AS total_sales
    FROM orders
    GROUP BY r_id, year
)
SELECT r.name, ys1.year AS previous_year, ys2.year AS current_year,
       ys1.total_sales AS previous_sales, ys2.total_sales AS current_sales,
       CASE
         WHEN ys2.total_sales > ys1.total_sales THEN 'Increasing'
         WHEN ys2.total_sales < ys1.total_sales THEN 'Decreasing'
         ELSE 'Stable'
       END AS sales_trend
FROM yearly_sales ys1
JOIN yearly_sales ys2 ON ys1.r_id = ys2.r_id AND ys2.year = ys1.year + 1
JOIN restaurants r ON r.id = ys1.r_id
ORDER BY r.name;

-- 14. Restaurants with High Ratings (>=4) but Low Sales
SELECT r.id, r.name, r.city, CAST(r.rating AS FLOAT) AS rating,
       COALESCE(SUM(o.sales_amount),0) AS total_sales
FROM restaurants r
LEFT JOIN orders o ON o.r_id = r.id
WHERE CAST(NULLIF(r.rating,'--') AS FLOAT) >= 4
GROUP BY r.id, r.name, r.city, rating
HAVING COALESCE(SUM(o.sales_amount),0) < (SELECT AVG(total_sales) FROM 
    (SELECT r_id, SUM(sales_amount) total_sales FROM orders GROUP BY r_id) avg_table)
ORDER BY rating DESC, total_sales ASC;

-- 16. Veg vs Non-Veg Food Preference by Region
SELECT r.Country, f.veg_or_non_veg, COUNT(*) AS total_orders
FROM orders o
JOIN restaurants r ON o.r_id = r.id
JOIN menu m ON m.r_id = r.id
JOIN food f ON m.f_id = f.f_id
GROUP BY r.Country, f.veg_or_non_veg
ORDER BY r.Country, total_orders DESC;

-- Corrected Query for Impact of Ratings on Order Volume and Revenue
SELECT 
    CORR(rating_metrics.rating, rating_metrics.total_orders) AS corr_rating_orders,
    CORR(rating_metrics.rating, rating_metrics.total_revenue) AS corr_rating_revenue
FROM (
    SELECT 
        r.id, 
        CAST(r.rating AS FLOAT) AS rating, 
        COUNT(o.sales_amount) AS total_orders, 
        SUM(o.sales_amount) AS total_revenue
    FROM restaurants r
    LEFT JOIN orders o ON o.r_id = r.id
    WHERE r.rating != '--'
    GROUP BY r.id, r.rating
) AS rating_metrics;

