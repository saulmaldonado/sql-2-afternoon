-- #1

SELECT * FROM invoice i
JOIN invoice_line il ON il.invoice_id = i.invoice_id
WHERE il.unit_price > 0.99

-- #2

SELECT i.invoice_date, c.first_name, c.last_name, i.total FROM invoice i
JOIN customer c ON i.customer_id = c.customer_id

-- #3

SELECT c.first_name, c.last_name, e.first_name, e.last_name FROM customer C
JOIN employee e ON c.support_rep_id = e.employee_id

-- #4

SELECT a.title, ar.name FROM album a
JOIN artist ar ON a.artist_id = ar.artist_id

-- #5

SELECT ptr.track_id FROM playlist_track ptr
JOIN playlist p ON ptr.playlist_id = p.playlist_id
WHERE p.name = 'Music'

-- #6

SELECT t.name FROM track t
JOIN playlist_track pt ON pt.track_id = t.track_id
WHERE pt.playlist_id = 5

-- #7

SELECT t.name, pl.name FROM track t
JOIN playlist_track pt ON pt.track_id = t.track_id
JOIN playlist pl ON pt.playlist_id = pl.playlist_id

-- #8

SELECT t.name, a.title FROM track t
JOIN album a ON a.album_id = t.album_id
JOIN genre g ON t.genre_id = g.genre_id
WHERE g.name = 'Alternative & Punk'

-- nested queries

-- #1

SELECT * FROM invoice
WHERE invoice_id IN (SELECT invoice_id FROM invoice_line WHERE unit_price > 0.99) 

-- #2

SELECT * FROM playlist_track
WHERE playlist_id IN (SELECT playlist_id FROM playlist WHERE name = 'Music')

-- #3

SELECT name FROM track
WHERE track_id IN (SELECT track_id FROM playlist_track WHERE playlist_id = 5)

-- #4

SELECT * FROM track
WHERE genre_id IN (SELECT genre_id FROM genre WHERE name = 'Comedy')

-- #5

SELECT * FROM track
WHERE album_id IN (SELECT album_id FROM album WHERE title = 'Fireball')

-- #6

SELECT * FROM track
WHERE album_id IN (SELECT album_id FROM album WHERE artist_id IN (SELECT artist_id FROM artist WHERE name = 'Queen')) 

-- updating rows

-- #1

UPDATE customer
SET fax = null
WHERE FAX IS NOT null

-- #2

UPDATE customer
SET company = 'Self'
WHERE company IS null

-- #3

UPDATE customer
SET last_name = 'Thompson'
WHERE first_name = 'Julia' AND last_name = 'Barnett'

-- #4

UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl'

-- #5

update track
SET composer = 'The darkness around us'
WHERE genre_id = (SELECT genre_id FROM genre WHERE name = 'Metal') 
AND composer IS NULL

-- group by
-- #1

SELECT COUNT(*), g.name FROM track t
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.name

-- #2

SELECT COUNT(*), g.name FROM track t
JOIN genre g ON t.genre_id = g.genre_id
WHERE g.name = 'Pop' OR g.name = 'Rock'
GROUP BY g.name

-- #3

SELECT (a.name), COUNT(al.title) from artist a
JOIN album al ON al.artist_id = a.artist_id
GROUP BY a.name

-- distinct

-- #1

SELECT DISTINCT composer
FROM track

-- #2

SELECT DISTINCT billing_postal_code
FROM invoice

-- #3

SELECT DISTINCT company
FROM customer

-- delete rows

-- #1

DELETE FROM practice_delete
WHERE type = 'bronze'

-- #2

DELETE FROM practice_delete
WHERE type = 'silver'

-- #3

DELETE FROM practice_delete
WHERE value = 150




CREATE TABLE users (user_id SERIAL PRIMARY KEY, name VARCHAR(150), email VARCHAR(150));

CREATE TABLE products(product_id SERIAL PRIMARY KEY, name VARCHAR(150), email VARCHAR(150))


-- eCommerce



CREATE TABLE users (user_id SERIAL PRIMARY KEY, name VARCHAR(150), email VARCHAR(150));
CREATE TABLE products(product_id SERIAL PRIMARY KEY, name VARCHAR(150), price INT);
CREATE TABLE orders(order_id SERIAL PRIMARY KEY, product_id INT);

INSERT INTO users (name, email)
VALUES ('Bob', 'bob@yahoo.com'),
('Bill', 'bill@gmail.com'),
('Ben', 'ben@hotmail.com');

INSERT INTO products (name, price)
VALUES ('Shirt', 20),
('Hoodie', 40),
('Hat', 50);

INSERT INTO orders (product_id)
VALUES (1),(2),(3);

SELECT p.name FROM orders o
JOIN products p ON p.product_id = o.product_id
WHERE o.order_id = 1;

SELECT p.name, o.order_id FROM orders o
JOIN products p ON p.product_id = o.product_id;

SELECT o.order_id, SUM(p.price) FROM orders o
JOIN products p ON p.product_id = o.product_id
GROUP BY o.order_id;

ALTER TABLE users
ADD COLUMN order_id INT,
ADD CONSTRAINT order_id FOREIGN KEY (order_id) REFERENCES orders (order_id)
SELECT * FROM users

UPDATE users
SET order_id = 1
WHERE name = 'Bill'
UPDATE users
SET order_id = 2
WHERE name = 'Bob'
UPDATE users
SET order_id = 3
WHERE name = 'Ben'

SELECT o.order_id, u.name from users u 
JOIN orders o ON o.order_id = u.order_id
JOIN products p ON o.product_id = p.product_id

SELECT u.name, COUNT(*) from orders o
JOIN users u ON u.order_id = o.order_id
GROUP BY u.name

SELECT u.name, SUM(p.price) FROM users u
JOIN orders o ON u.order_id = o.order_id
JOIN products p ON p.product_id = o.product_id
GROUP BY u.name






