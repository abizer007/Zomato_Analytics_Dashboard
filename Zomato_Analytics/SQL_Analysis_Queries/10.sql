-- Query 10: Best-selling food items by occupation
-- Determines popular food items based on customers' occupations.
SELECT u.occupation, f.item, COUNT(*) AS total_orders
FROM orders o JOIN users u ON o.user_id = u.user_id JOIN menu m ON o.r_id = m.r_id JOIN food f ON m.f_id = f.f_id
GROUP BY u.occupation, f.item ORDER BY u.occupation, total_orders DESC;