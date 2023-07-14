## Case Study of MySql
USE sakila;

# TASK 1 :
/* Display the first names, last names, actor IDs and details of the last_updated column.*/
SELECT * FROM actor;
SELECT actor_id, first_name, last_name, last_update FROM actor;

---------------------------------------------------------------------------------------------------------------------------------------------------------

# TASK 2 :
/* Many actors have adopted attractive screen names, mostly at the behest of producers and directors.
The management wants to know the following.*/
SELECT * FROM actor;

# Task 2.1:
-- Display the full names of all actors.
SELECT concat(first_name, "  ", last_name) AS "Actor Names" FROM actor;

# Task 2.2:
-- Display the first names of actors along with the count of repeated first names.
SELECT first_name, count(first_name) FROM actor GROUP BY first_name ORDER BY count(first_name) DESC;

# Task 2.3:
-- Display the last name of actors along with the count of repeated last names.
SELECT last_name, count(last_name) FROM actor GROUP BY last_name ORDER BY count(last_name) DESC;

---------------------------------------------------------------------------------------------------------------------------------------------------------

# TASK 3 :
/* Display the count of movies grouped by the rating.*/
SELECT * from film;
SELECT rating, count(title) AS "Count of Movies" FROM film GROUP BY rating;

---------------------------------------------------------------------------------------------------------------------------------------------------------

# TASK 4 :
/* Calculate and Display the average rental rates based on the movie ratings.*/
SELECT rating, avg(rental_rate) AS "Average Rental Rate (in $)" FROM film GROUP BY rating;

---------------------------------------------------------------------------------------------------------------------------------------------------------

# TASK 5 :
/* The management wants the data about replacement cost of movies.*/
SELECT * FROM film;

# Task 5.1:
-- Display the movie titles where the replacement cost is up to $9.
SELECT title, replacement_cost FROM film WHERE replacement_cost < 10;

# Task 5.2:
-- Display the movie titles where the replacement cost is between $15 and $20.
SELECT title, replacement_cost FROM film WHERE replacement_cost BETWEEN 15 AND 20;

# Task 5.3:
-- Display the movie titles with highest replacement cost and the lowest rental cost.
SELECT max(replacement_cost) FROM film;
SELECT min(rental_rate) FROM film;
SELECT title FROM film WHERE replacement_cost = (SELECT max(replacement_cost) FROM film);
SELECT title FROM film WHERE rental_rate = (SELECT min(rental_rate) FROM film);

---------------------------------------------------------------------------------------------------------------------------------------------------------

# TASK 6 :
/* The management needs to know the list all the movies along with the number of actors listed for each movie.*/
SELECT * FROM actor;
SELECT * FROM film;
SELECT * FROM film_actor;

SELECT film.title, count(actor.actor_id) AS "Number of Actors" FROM film INNER JOIN film_actor
ON film.film_id = film_actor.film_id 
INNER JOIN actor ON film_actor.actor_id = actor.actor_id
GROUP BY film.title;

---------------------------------------------------------------------------------------------------------------------------------------------------------

# TASK 7 :
/* Display the movie titles starting with the letters 'K' and 'Q'.*/
SELECT title FROM film WHERE title LIKE ('K%') OR title like ('Q%');

---------------------------------------------------------------------------------------------------------------------------------------------------------

# TASK 8 :
/* Display the first names and last names of all actors who are part of 'AGENT TRUMAN' movie.*/
SELECT actor.first_name, actor.last_name FROM film INNER JOIN film_actor
ON film.film_id = film_actor.film_id 
INNER JOIN actor ON film_actor.actor_id = actor.actor_id
WHERE film.title = "AGENT TRUMAN";

---------------------------------------------------------------------------------------------------------------------------------------------------------

# TASK 9 :
/* The management wants to promote the movies that fall under the 'children' category.
Identify and Display the names of movies in the family category.*/
SELECT * FROM film;
SELECT * FROM category;
SELECT * FROM film_category;

SELECT film.title AS "Names of Movies" FROM category INNER JOIN film_category
ON category.category_id = film_category.category_id
INNER JOIN film ON film.film_id = film_category.film_id
WHERE category.name = "Family" OR category.name =  "Children";

---------------------------------------------------------------------------------------------------------------------------------------------------------

# TASK 10 :
/* Display the names of most frequently rented movies in decending order, so that the management can
maintain more copies of such movies.*/
SELECT * FROM film;
SELECT * FROM inventory;
SELECT * FROM rental;

SELECT count(rental_id) from rental;
SELECT film.title, count(rental.rental_id) FROM inventory INNER JOIN film
ON inventory.film_id = film.film_id
INNER JOIN rental ON rental.inventory_id = inventory.inventory_id
GROUP BY film.title
ORDER BY count(rental.rental_id)
DESC;

---------------------------------------------------------------------------------------------------------------------------------------------------------

# TASK 11 :
/* Calculate and Display the number of movie categories where the average 
difference between movie replacement cost and rental rate is greater than $15.*/
SELECT * FROM film_category;
SELECT * FROM film;
SELECT * FROM category;

SELECT category.name, count(category.name) FROM category INNER JOIN film_category
ON category.category_id = film_category.category_id
INNER JOIN film ON film.film_id = film_category.film_id
GROUP BY category.name
HAVING (SELECT (avg(replacement_cost) - avg(rental_rate)) FROM film) > 15;

---------------------------------------------------------------------------------------------------------------------------------------------------------

# TASK 12 :
/* The management wants to identify all the genres that consist of 60-70 movies. The genre details are captured in the category column.
Display the names of these categories and the number of movies per category, sorted by number of movies.*/
SELECT * FROM category;
SELECT * FROM film_category;

SELECT category.name, count(film_category.film_id) AS Number_of_Movie
FROM film_category INNER JOIN category
USING (category_id)
GROUP BY category.category_id
HAVING Number_of_Movie  >60 AND Number_of_Movie <70
ORDER BY Number_of_Movie ASC;

---------------------------------------------------------------------------------------------------------------------------------------------------------










