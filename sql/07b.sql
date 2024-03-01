/*
 * This problem is the same as 07.sql,
 * but instead of using the NOT IN operator, you are to use a LEFT JOIN.
 */

SELECT f.title
FROM film f
JOIN inventory i USING (film_id)
LEFT JOIN rental USING (inventory_id)
LEFT JOIN customer USING (customer_id)
LEFT JOIN address USING (address_id)
LEFT JOIN city c USING (city_id)
GROUP BY f.title
HAVING COUNT(CASE WHEN c.country_id = 103 THEN 1 END) = 0
ORDER BY title;
