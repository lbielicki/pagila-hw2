/*
 * Compute the total revenue for each film.
 * The output should include another new column "revenue percent" that shows the percent of total revenue that comes from the current film and all previous films.
 * That is, the "revenue percent" column is 100*"total revenue"/sum(revenue)
 *
 * HINT:
 * The `to_char` function can be used to achieve the correct formatting of your percentage.
 * See: <https://www.postgresql.org/docs/current/functions-formatting.html#FUNCTIONS-FORMATTING-EXAMPLES-TABLE>
 */

WITH revenue_data AS (
    SELECT
        RANK() OVER (ORDER BY COALESCE(SUM(p.amount), 0.00) DESC) AS rank,
        f.title,
        COALESCE(SUM(p.amount), 0.00) AS revenue,
        SUM(COALESCE(SUM(p.amount), 0.00)) OVER (ORDER BY COALESCE(SUM(p.amount), 0.00) DESC) AS "total revenue",
        ((SUM(COALESCE(SUM(p.amount), 0.00)) OVER (ORDER BY COALESCE(SUM(p.amount), 0.00) DESC)) / SUM(SUM(p.amount)) OVER ()) * 100 AS percent_revenue
    FROM
        film f
    LEFT JOIN
        inventory i ON f.film_id = i.film_id
    LEFT JOIN
        rental r ON i.inventory_id = r.inventory_id
    LEFT JOIN
        payment p ON r.rental_id = p.rental_id
    GROUP BY
        f.title
)
SELECT
    rank,
    title,
    revenue,
    "total revenue",
    CASE
        WHEN percent_revenue = 100.00 THEN '100.00' -- If percent revenue is already 100, return 100.00
        ELSE TO_CHAR(percent_revenue, 'FM00.00') -- Otherwise, format as normal
    END AS "percent revenue"
FROM
    revenue_data
ORDER BY
    rank, title;

