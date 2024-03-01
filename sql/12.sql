/*
 * List the title of all movies that have both the 'Behind the Scenes' and the 'Trailers' special_feature
 *
 * HINT:
 * Create a select statement that lists the titles of all tables with the 'Behind the Scenes' special_feature.
 * Create a select statement that lists the titles of all tables with the 'Trailers' special_feature.
 * Inner join the queries above.
 */


SELECT f.title
FROM film f
JOIN (
    SELECT fi.film_id
    FROM film fi
    WHERE 'Behind the Scenes' = ANY(fi.special_features)
) bs ON f.film_id = bs.film_id
JOIN (
    SELECT fi.film_id
    FROM film fi
    WHERE 'Trailers' = ANY(fi.special_features)
) tr ON f.film_id = tr.film_id
ORDER BY f.title;

