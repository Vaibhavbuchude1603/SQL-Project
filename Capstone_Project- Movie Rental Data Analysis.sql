-- 1st Capstone Project SQL
USE sakila;
SELECT * FROM actor;
SELECT * FROM category;
SELECT * FROM film;
SELECT * FROM inventory;
SELECT * FROM rental;
SELECT * FROM film_actor;
SELECT * FROM film_category;

/* Task 1: Display the full names of actors available in the database. */
SELECT actor_id, concat(first_name, '  ', last_name) AS Actor_Names FROM actor;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* Task 2: Management wants to knwo if there are any names of the actors appearing frequentyly. */
/* i. Display the number of times each first name appears in the database. */
SELECT first_name, count(first_name) AS Total_Count FROM actor GROUP BY first_name ORDER BY Total_Count DESC;

/* ii. What is the count of actors that have unique first names in the database?
Display the first names of all these actors. */
SELECT first_name, count(first_name) AS Total_Count FROM actor GROUP BY first_name HAVING Total_Count = 1 ORDER BY first_name;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* Task 3: The management is interested to analyze the similarity in the last names of the actors. */
/* i. Display the number of times each last name appears in the database. */
SELECT last_name, count(last_name) AS Total_Count FROM actor GROUP BY last_name ORDER BY Total_Count DESC;

/* ii. Display all unique last names in the database. */
SELECT last_name, count(last_name) AS Total_Count FROM actor GROUP BY last_name HAVING Total_Count = 1 ORDER BY last_name;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* Task 4: The management wants to analyze the movies based on their ratings to determine if they are suitable for kids or some parental assistance is required. */
SELECT * FROM film;
/* i. Display the list of records for the movies with the rating "R". (The movies with the rating "R" are not suitable for audience under 17 year of age). */
SELECT film_id, title, rental_duration, rental_rate, length, replacement_cost FROM film WHERE rating = "R";

/* ii. Display the list of records for the movies that are not rated "R". */
SELECT film_id, title, rental_duration, rental_rate, length, replacement_cost FROM film WHERE rating != "R";

/* iii. Display the list of records for the movies that are suitable for audience below 13 years of age. */
SELECT film_id, title, rental_duration, rental_rate, length, replacement_cost FROM film WHERE rating = "G";

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* Task 5: The board members want to understand the replacement cost of a movie copy (disc - DVD/Blue Ray).
The replacement cost refers to the amount charged to the customer if the movie disc is not returned or is returned in a damaged state. */
/* i. Display the list of records for the movies where the replacement cost is up to $11. */
SELECT film_id, title, rating, replacement_cost FROM film WHERE replacement_cost <= 11;

/* ii. Display the list of records for the movies where the replacement cost is between $11 and $20. */
SELECT film_id, title, rating, replacement_cost FROM film WHERE replacement_cost BETWEEN 11 AND 20;

/* iii. Display the list of records for the all movies in descending order of their replacement costs. */
SELECT film_id, title, rating, replacement_cost FROM film ORDER BY replacement_cost DESC;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* Task 6: Display the names of the top 3 movies with the greatest number of actors. */
SELECT * FROM actor;
SELECT * FROM film;
SELECT * FROM film_actor;
SELECT film.title, count(actor.actor_id) AS Number_of_Actors FROM film 
INNER JOIN film_actor USING (film_id)
INNER JOIN actor USING (actor_id)
GROUP BY film.title
ORDER BY Number_of_Actors DESC
LIMIT 3;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* Task 7: 'Music of Queen' and 'Kris Kristofferson' have seen an unlikely resurgence. As an unintended consequence,
films starting with the letters 'K' and 'Q' have also soared in popularity.
Display the titles of the movies starting with the letters 'K' and 'Q'. */
SELECT title FROM film WHERE title LIKE ('K%') OR title LIKE ('Q%');

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* Task 8: The film 'Agent Truman' has been a great success. Display the names of all actors who appeared in this film. */
SELECT actor.first_name, actor.last_name FROM actor 
INNER JOIN film_actor USING (actor_id)
INNER JOIN film USING (film_id)
WHERE film.title = "AGENT TRUMAN";

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* Task 9: Sales have been lagging among young families, so the management wants to promote family movies. 
Identify all the movies categorized as family films. */
SELECT * FROM film;
SELECT * FROM category;
SELECT * FROM film_category;
SELECT film.title AS "Name of Movie", film.rating, category.name AS Category FROM film 
INNER JOIN film_category USING (film_id)
INNER JOIN category USING (category_id)
WHERE category.name = "family";

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* Task 10: The management wants to observe the rental rates and rental frequencies (Number of time the movie disc is rented). */
/* i. Display the maximum, minimum and average rental rates of movies based on their ratings.
The output must be sorted in descending order of the average rental rates. */
SELECT * FROM film;
SELECT * FROM inventory;
SELECT * FROM rental;
SELECT rating, max(rental_rate), min(rental_rate), avg(rental_rate) FROM film GROUP BY rating ORDER BY avg(rental_rate) DESC;

/* ii. Display the movies in descending order of their rental frequencies, so the management can maintain more copies of those movies. */
SELECT film.title, count(rental.rental_id) AS Rental_Frequency, film.rating FROM film
INNER JOIN inventory USING (film_id)
INNER JOIN rental USING (inventory_id)
GROUP BY film.film_id, film.title
ORDER BY Rental_Frequency DESC;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* Task 11: In how many film categories, the difference between the average film replacement cost (disc - DVD/Blue Ray)
and the average film rental rate is greated than $15?
Display the list of all film categories identified above, along with the corresponding average film replacement cost and average film rental rate. */
SELECT * FROM film;
SELECT * FROM film_category;
SELECT * FROM category;
SELECT category.name, avg(replacement_cost), avg(rental_rate), (avg(replacement_cost) - avg(rental_rate)) AS Difference FROM category 
INNER JOIN film_category USING (category_id)
INNER JOIN film USING (film_id)
GROUP BY category.name
HAVING Difference > 15
ORDER BY Difference 
DESC;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* Task 12: Display the film categories in which the number of movies is greater than 70. */
SELECT category.name AS category, count(film.title) AS movie_count FROM category
INNER JOIN film_category USING (category_id)
INNER JOIN film USING (film_id)
GROUP BY category.name
HAVING count(film.title) > 70;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* 1. Display the count of actors. */
SELECT count(actor_id) FROM actor;

/* 2. Display the total number of movies. */
SELECT count(title) FROM film;

/* 3. Display the count of all ratings separately. */
SELECT rating, count(rating) AS Total_Count FROM film GROUP BY rating ORDER BY Total_Count DESC;

/* 4. Display the movie title which have highest and lowest replacement cost. */
SELECT max(replacement_cost) AS High_Replacement, min(replacement_cost) AS Low_Replacement FROM film;
SELECT title, replacement_cost FROM film WHERE replacement_cost = (SELECT max(replacement_cost) from film);
SELECT title, replacement_cost FROM film WHERE replacement_cost = (SELECT min(replacement_cost) from film);

/* 5. Display the count of movie title which has highet and lowest replacement cost. */
SELECT count(title) FROM film WHERE replacement_cost = (SELECT max(replacement_cost) from film);
SELECT count(title) FROM film WHERE replacement_cost = (SELECT min(replacement_cost) from film);

/* 6. Display the names of these categories and the number of movies per category, sorted by number of movies. */
SELECT * FROM category;
SELECT * FROM film_category;
SELECT category.name, count(film_category.film_id) AS Number_of_Movie FROM film_category 
INNER JOIN category USING (category_id)
GROUP BY category.category_id
ORDER BY Number_of_Movie DESC;

/* 7. Identify the store_id having the highest number of active and inactive customers. */
SELECT store_id, (count(store_id)) FROM customer WHERE ACTIVE = 1 GROUP BY store_id;
SELECT store_id, (count(store_id)) FROM customer WHERE ACTIVE = 0 GROUP BY store_id;

/* 8. Identify the top three movies rating that have the longest running time. */
SELECT title AS "Movies", rating, length FROM film ORDER BY length DESC LIMIT 10;

/* 9. Find the most popular movies based on rental duration. */
SELECT title AS "Movies", rental_duration FROM film ORDER BY rental_duration DESC;

/* 10. Find the maxinum, minimum, total and average replacement cost of all movies based on ratings. */
SELECT rating, max(replacement_cost) AS High_Replacement, 
min(replacement_cost) AS Low_Replacement, 
sum(replacement_cost) AS Total_Replacement,
avg(replacement_cost) AS Avg_Replacement 
FROM film GROUP BY rating ORDER BY Total_Replacement DESC;

/* 11. Find the maxinum, minimum, total and average rental rate of all movies based on ratings. */
SELECT rating, max(rental_rate) AS High_Rental_Rate, 
min(rental_rate) AS Low_Rental_Rate, 
sum(rental_rate) AS Total_Rental_Rate,
avg(rental_rate) AS Avg_Rental_Rate 
FROM film GROUP BY rating ORDER BY Total_Rental_Rate DESC;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
