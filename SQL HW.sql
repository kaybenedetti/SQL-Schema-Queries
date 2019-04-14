USE sakila;

SELECT * FROM actor;

SELECT CONCAT(first_name, ' ', last_name) AS actor_name
FROM actor;

SELECT * 
FROM actor
WHERE first_name = 'Joe';

SELECT *
FROM actor
WHERE last_name LIKE '%GEN%';

SELECT *
FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name;

SELECT *
FROM country
WHERE country IN ('Afganistan', 'Bangladesh', 'China');

ALTER TABLE actor
ADD COLUMN description BLOB;

ALTER TABLE actor
DROP description; 

SELECT last_name, COUNT(last_name) 
FROM actor
GROUP BY last_name
HAVING COUNT(last_name);

SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) > 1;

UPDATE actor
SET first_name = 'HARPO'
WHERE actor_ID = 172;

UPDATE actor
SET first_name = 'GROUPO'
WHERE actor_ID = 172;
     
SHOW CREATE TABLE address;

SELECT staff.first_name, staff.last_name, address.address
FROM address
JOIN staff ON
staff.address_id=address.address_id;

SELECT staff.first_name, staff.last_name, sum(payment.amount) as 'Total Payment'
FROM staff
JOIN payment ON
staff.staff_id=payment.staff_id
group by staff.first_name, staff.last_name;

SELECT title, count(actor_id) as 'Total'
FROM film_actor
INNER JOIN film 
USING (film_id)
GROUP BY title;

SELECT title, count(title) as 'Total Count'
FROM film
WHERE title='Hunchback Impossible';

SELECT first_name, last_name, sum(amount) as 'Total Payment'
FROM payment
JOIN customer
USING (customer_id)
GROUP BY first_name, last_name
ORDER BY last_name;

Select title
	FROM film
	WHERE title LIKE 'Q%' OR 'K%'
    AND language_id
    IN (
		SELECT language_id
        FROM language
        WHERE name='english');
        
SELECT last_name, first_name
	FROM actor
    WHERE actor_id
    IN (
		SELECT actor_id
        FROM film_actor
        WHERE film_id
        IN (
			SELECT film_id
            FROM film
			WHERE title= "Alone Trip"));
        

SELECT first_name, last_name, email
FROM customer
INNER JOIN address USING (address_id)
INNER JOIN city USING (city_id)
INNER JOIN country USING (country_id)
WHERE country= "Canada";


SELECT title as "Family Films"
	FROM film
	WHERE film_id
    IN (
		SELECT film_id
        FROM film_category
        WHERE category_id
        IN (
			SELECT category_id
            FROM category
            WHERE name= "family"));

SELECT title, count(rental_id)
FROM film
	INNER JOIN inventory USING (film_id)
	INNER JOIN rental USING (inventory_id)
GROUP BY title
ORDER BY count(rental_id) DESC;

SELECT store_id, count(amount)
FROM payment 
	INNER JOIN staff USING (staff_id)
    INNER JOIN store USING (store_id)
GROUP BY store_id
ORDER BY count(amount);
    
SELECT store_id, city, country
FROM store
	INNER JOIN address USING (address_id)
    INNER JOIN city USING (city_id)
    INNER JOIN country USING (country_id)
GROUP BY store_id;

SELECT name, sum(amount)
FROM category
	INNER JOIN film_category USING (category_id)
    INNER JOIN inventory USING (film_id)
    INNER JOIN rental USING (inventory_id)
    INNER JOIN payment USING (rental_id)
GROUP BY name
ORDER BY sum(amount) LIMIT 5;

CREATE VIEW top_genres
AS SELECT name, sum(amount)
FROM category
	INNER JOIN film_category USING (category_id)
    INNER JOIN inventory USING (film_id)
    INNER JOIN rental USING (inventory_id)
    INNER JOIN payment USING (rental_id)
GROUP BY name
ORDER BY sum(amount) LIMIT 5;

SELECT * FROM top_genres;

DROP VIEW top_genres;