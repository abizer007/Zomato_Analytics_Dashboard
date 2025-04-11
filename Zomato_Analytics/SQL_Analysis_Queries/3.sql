-- Query 3: Most ordered cuisines per country and city
-- Determines the popularity of cuisines by counting orders per country and city.
SELECT r.country, r.city, mc.cuisine, COUNT(*) AS total_orders
FROM orders o
JOIN restaurants r ON o.r_id = r.r_id
JOIN menu m ON o.r_id = m.r_id
JOIN menu_cuisine mc ON m.menu_id = mc.menu_id
GROUP BY r.country, r.city, mc.cuisine ORDER BY total_orders DESC;