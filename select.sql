SELECT name, email, gender from clients LIMIT 10;
DESC clients;
SELECT name, email, gender from clients WHERE gender = 'M';
SELECT birthdate from clients;
SELECT year(birthdate) from clients;
SELECT NOW();
SELECT YEAR(NOW());
SELECT YEAR(NOW()) - YEAR(birthdate) FROM clients;
SELECT name, YEAR(NOW()) - YEAR(birthdate) FROM clients LIMIT 10;
SELECT * FROM clients WHERE name like '%Saave%';
SELECT name, email, YEAR(NOW()) - YEAR(birthdate) AS edad, gender
FROM clients
WHERE gender = 'F' AND name LIKE '%Lop%';

SELECT COUNT(*) FROM books;
SELECT COUNT(*) FROM authors;
SELECT * FROM authors WHERE author_id > 0 AND author_id <= 5;
SELECT * FROM books WHERE author_id BETWEEN 1 AND 5;

#JOINS

SELECT b.book_id, a.name, a.author_id, b.title
FROM books AS b
JOIN authors AS a
	ON a.author_id = b.author_id
WHERE a.author_id BETWEEN 1 AND 5;

SELECT * FROM authors WHERE author_id = 4;

SELECT * FROM books WHERE author_id = 4;

INSERT INTO transactions(transaction_id,book_id,client_id,`type`,`finished`) 
VALUES(1,12,34,'sell',1),
(2,54,87,'lend',0),
(3,3,14,'sell',1),
(4,1,54,'sell',1),
(5,12,81,'lend',1),
(6,12,81,'return',1),
(7,87,29,'sell',1);

SELECT * FROM transactions;

SELECT c.name, b.title, a.name, t.type
FROM transactions AS t
JOIN books AS b
	ON t.book_id = b.book_id
JOIN clients AS c
	ON t.client_id = c.client_id
JOIN authors AS a
	ON b.author_id = a.author_id
WHERE c.gender = 'M'
	AND t.type IN ('sell', 'lend');


SELECT b.title, a.name
FROM authors AS a, books AS b
WHERE a.author_id = b.author_id
LIMIT 10;

SELECT b.title, a.name
FROM books AS b
JOIN authors AS a
	ON a.author_id = b.author_id
LIMIT 10;

SELECT a.author_id, a.name, a.nationality, b.title
FROM authors AS a
JOIN books AS b
	ON b.author_id = a.author_id
WHERE a.author_id BETWEEN 1 AND 5
ORDER BY a.author_id DESC;

#LEFT JOIN - Traer los autores que tienen y no tienen libros
SELECT a.author_id, a.name, a.nationality, COUNT(b.book_id) AS 'Num_books'
FROM authors AS a
LEFT JOIN books AS b
	ON b.author_id = a.author_id
WHERE a.author_id BETWEEN 1 AND 5
GROUP BY a.author_id
ORDER BY a.author_id ASC;


#¿qué nacionalidades hay?
SELECT nationality
FROM authors
GROUP BY nationality;

SELECT DISTINCT nationality
FROM authors
ORDER BY nationality;

#¿cuántos escritores hay de cada nacionalidad
SELECT nationality, COUNT(author_id) AS 'Num_authors'
FROM authors
GROUP BY nationality
ORDER BY Num_authors DESC, nationality ASC;

SELECT nationality, COUNT(author_id) AS 'Num_authors'
FROM authors
WHERE nationality IS NOT NULL
GROUP BY nationality
ORDER BY Num_authors DESC, nationality ASC;


#¿cuántos libros de cada nacionalidad
SELECT a.nationality, COUNT(b.book_id) AS 'Num_books'
FROM authors AS a
INNER JOIN books AS b
	ON b.author_id = a.author_id
WHERE a.nationality IS NOT NULL
GROUP BY a.nationality
ORDER BY Num_books DESC;

#Promedio, desviación estándar del precio de libros
SELECT AVG(price) AS 'Promedio', STDDEV(price) AS 'Desviación estándar'
FROM books;

SELECT nationality, 
	COUNT(book_id) as 'Num_books', 
	AVG(price) AS 'Promedio', 
	STDDEV(price) AS 'Desviación estándar'
FROM books AS b
JOIN authors AS a
	ON a.author_id = b.author_id
GROUP BY nationality
ORDER BY Num_books DESC;

#Idem pero por nacionalidad


#precio máximo y mínimo de un libro
SELECT MAX(price) AS 'Máximo', MIN(price) AS 'Mínimo'
FROM books;

#reporte de préstamos quién, qué y cuándo
SELECT c.name, t.type, b.title, a.name, a.nationality, t.created_at
FROM transactions AS t
LEFT JOIN clients AS c
	ON c.client_id = t.client_id
LEFT JOIN books AS b
	ON b.book_id = t.book_id
LEFT JOIN authors AS a
	ON a.author_id = b.author_id
GROUP BY c.name;

SELECT c.name, t.type, b.title, 
	CONCAT (a.name, "( ", a.nationality, ")") as Author, 
    TO_DAYS(NOW()) - TO_DAYS(t.created_at) AS Ago
FROM transactions AS t
LEFT JOIN clients AS c
	ON c.client_id = t.client_id
LEFT JOIN books AS b
	ON b.book_id = t.book_id
LEFT JOIN authors AS a
	ON a.author_id = b.author_id
GROUP BY c.name;

INSERT INTO transactions(book_id, client_id, type, created_at)
VALUES (6, 76, 'sell', '2018-01-01');

#DELETE

SELECT COUNT(clients.client_id)
FROM clients;

DELETE FROM clients 
WHERE client_id = 85
LIMIT 1;

SELECT * FROM clients
WHERE client_id BETWEEN 80 AND 100;

#UPDATE
SELECT * 
FROM clients 
WHERE client_id BETWEEN 70 AND 90;

UPDATE clients
SET active = 0
WHERE client_id = 80
LIMIT 1;