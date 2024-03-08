/*
 * Management also wants to create a "best sellers" list for each category.
 *
 * Write a SQL query that:
 * For each category, reports the five films that have been rented the most for each category.
 *
 * Note that in the last query, we were ranking films by the total amount of payments made,
 * but in this query, you are ranking by the total number of times the movie has been rented (and ignoring the price).
 */

SELECT name, title, "total rentals"
FROM (
    SELECT name, title, COUNT(*) AS "total rentals", RANK() OVER (PARTITION BY name ORDER BY COUNT(*) DESC, title DESC) AS rank
    FROM category
    JOIN film_category USING (category_id)
    JOIN film USING (film_id)
    JOIN inventory USING (film_id)
    JOIN rental USING (inventory_id)
GROUP BY name, title
) AS a
where rank <= 5
order by name, "total rentals" DESC, title;
