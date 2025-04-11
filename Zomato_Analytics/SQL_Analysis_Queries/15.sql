-- Query 15: Most popular cuisines across restaurant rating tiers
-- Identifies the most ordered cuisines categorized by restaurant rating (High, Medium, Low, Unrated).
SELECT 
  CASE 
    WHEN CAST(r.rating AS NUMERIC) >= 4.5 THEN 'High Rated'
    WHEN CAST(r.rating AS NUMERIC) >= 3.5 THEN 'Medium Rated'
    WHEN CAST(r.rating AS NUMERIC) >= 0 THEN 'Low Rated'
    ELSE 'Unrated'
  END AS rating_tier,
  mc.cuisine,
  COUNT(*) AS total_orders
FROM orders o
JOIN menu m ON o.r_id = m.r_id
JOIN menu_cuisine mc ON m.menu_id = mc.menu_id
JOIN restaurants r ON o.r_id = r.r_id
WHERE r.rating ~ '^[0-9.]+' 
GROUP BY rating_tier, mc.cuisine
ORDER BY rating_tier, total_orders DESC;