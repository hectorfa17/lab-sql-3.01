#Activity 1

#Drop column picture from staff.
USE sakila;

ALTER TABLE staff
DROP COLUMN picture;

SELECT * FROM staff;

#A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.

SELECT * 
FROM staff as s
JOIN customer as c
ON s.store_id = c.store_id
WHERE c.first_name = 'TAMMY' AND c.last_name = 'SANDERS';

INSERT INTO staff(staff_id, first_name, last_name, address_id, store_id, active, username, last_update) 
VALUES
(3, 'Tammy', 'Sanders', 79, 2, 1, 'Tammy', '2006-02-15 04:57:20');

SELECT * FROM staff;

#Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. 

SELECT * 
FROM film  as f
JOIN inventory as i
ON f.film_id = i.film_id
JOIN rental as r
ON i.inventory_id = r.inventory_id
JOIN customer as c
ON r.customer_id = c.customer_id
WHERE f.title = 'ACADEMY DINOSAUR' and c.last_name = 'HUNTER';

INSERT INTO rental(rental_date, inventory_id, customer_id, return_date, staff_id, last_update) 
VALUES
('2022-02-25 12:24:17',9,130,'2022-02-28 12:24:17', 2, '2022-02-25 12:25:00');

SELECT * FROM rental
WHERE return_date = '2022-02-28 12:24:17';



