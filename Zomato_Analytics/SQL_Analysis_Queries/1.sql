-- Query 1: Top 5 highest-rated restaurants in each city
-- Finds the top 5 restaurants per city based on ratings and rating counts.
WITH RankedRestaurants AS (
  SELECT city, r_id, name, rating,
         ROW_NUMBER() OVER (PARTITION BY city ORDER BY rating DESC, rating_count DESC) AS rank
  FROM restaurants WHERE rating IS NOT NULL
)
SELECT city, r_id, name, rating FROM RankedRestaurants WHERE rank <= 5;