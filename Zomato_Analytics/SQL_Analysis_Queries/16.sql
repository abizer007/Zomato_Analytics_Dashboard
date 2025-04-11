-- Query 16: Food preference (veg vs. non-veg) by gender
-- Analyzes how food preference (vegetarian vs non-vegetarian) varies across different genders.
SELECT 
  u.gender, 
  f.veg_or_non_veg, 
  COUNT(*) AS total_orders
FROM orders o
JOIN users u ON o.user_id = u.user_id
JOIN menu m ON o.r_id = m.r_id
JOIN food f ON m.f_id = f.f_id
GROUP BY u.gender, f.veg_or_non_veg;