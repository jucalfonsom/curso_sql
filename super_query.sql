SELECT DISTINCT nationality FROM authors;

UPDATE authors
SET nationality = 'GBR'
WHERE authors.nationality = 'ENG';

SELECT sum(price*copies) FROM books WHERE sellable = 1;

SELECT sellable, sum(price*copies) 
FROM books 
GROUP BY sellable;

SELECT COUNT(book_id), SUM(if(year < 1950, 1, 0)) AS '<1950' FROM books;

SELECT COUNT(book_id), SUM(if(year < 1950, 1, 0)) AS '<1950', SUM(if(year >= 1950, 1, 0)) AS '>1950' FROM books;

SELECT a.nationality, 
	COUNT(book_id) AS 'Num_books', 
	SUM(if(year < 1950, 1, 0)) AS '<1950', 
	SUM(if(year >= 1950 AND year < 1990, 1, 0)) AS '<1990',
    SUM(if(year >= 1990 AND year < 2000, 1, 0)) AS '<2000',
    SUM(if(year >= 2000, 1, 0)) AS '<hoy'
FROM books AS b
JOIN authors AS a
	ON a.author_id = b.author_id
WHERE a.nationality IS NOT NULL
GROUP BY a.nationality
ORDER BY Num_books DESC;