-- Query 5: Most frequently ordered menu items across restaurant categories
-- Lists menu items ranked by frequency of orders across all restaurant categories.
SELECT f.item, COUNT(*) AS times_ordered
FROM orders o JOIN menu m ON o.r_id = m.r_id JOIN food f ON m.f_id = f.f_id
GROUP BY f.item ORDER BY times_ordered DESC;