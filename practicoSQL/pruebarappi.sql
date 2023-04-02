SELECT *
FROM rappi.COMPANIES;


SELECT PEOPLE.name, filtered.named
FROM (
	SELECT rappi.COMPANIES.id AS id_comp, rappi.COMPANIES.name AS named
	FROM rappi.COMPANIES
	INNER JOIN rappi.LOCATIONS
	ON rappi.COMPANIES.location_id = rappi.LOCATIONS.id
) AS filtered
	INNER JOIN rappi.PEOPLE
	ON id_comp = rappi.PEOPLE.company_id
	
	
SELECT PEOPLE.name, COMPANIES.name
FROM rappi.COMPANIES
INNER JOIN rappi.PEOPLE
ON COMPANIES.id = PEOPLE.company_id
WHERE COMPANIES.id = (
	SELECT *
	FROM rappi.COMPANIES
	INNER JOIN rappi.LOCATIONS
	ON COMPANIES.location_id = LOCATIONS.id
);


SELECT PEOPLE.name, COMPANIES.name
FROM (
	SELECT rappi.COMPANIES.*
	FROM rappi.COMPANIES
	INNER JOIN rappi.LOCATIONS
	ON COMPANIES.location_id = LOCATIONS.id
)
INNER JOIN rappi.PEOPLE
ON COMPANIES.id = PEOPLE.company_id;


SELECT PEOPLE.name, COMPANIES.name
FROM rappi.COMPANIES
INNER JOIN rappi.PEOPLE
ON COMPANIES.id = PEOPLE.company_id;

SELECT COMPANIES.id, COMPANIES.name
FROM rappi.COMPANIES
INNER JOIN rappi.LOCATIONS
ON COMPANIES.location_id = LOCATIONS.id;



SELECT PEOPLE.name, COMPANIES.name
FROM rappi.COMPANIES
INNER JOIN rappi.PEOPLE
ON COMPANIES.id = PEOPLE.company_id
WHERE COMPANIES.id IN (
	SELECT COMPANIES.id
	FROM rappi.COMPANIES
	INNER JOIN rappi.LOCATIONS
	ON COMPANIES.location_id = LOCATIONS.id
);

SELECT COMPANIES.id
FROM rappi.COMPANIES;


SELECT PEOPLE.name, COMPANIES.name
FROM rappi.COMPANIES
INNER JOIN rappi.PEOPLE
ON COMPANIES.id = PEOPLE.company_id
WHERE COMPANIES.location_id = (
	SELECT COMPANIES.id
	FROM rappi.COMPANIES
	INNER JOIN rappi.LOCATIONS
	ON COMPANIES.location_id = LOCATIONS.id
);

SELECT COMPANIES.location_id, COUNT(COMPANIES.location_id) AS number_of_companies
FROM rappi.COMPANIES
INNER JOIN rappi.LOCATIONS
ON COMPANIES.location_id = LOCATIONS.id
GROUP BY COMPANIES.location_id
ORDER BY number_of_companies DESC
LIMIT 1;

--Respuesta

SELECT PEOPLE.name, COMPANIES.name
FROM rappi.COMPANIES
INNER JOIN rappi.PEOPLE
ON COMPANIES.id = PEOPLE.company_id
WHERE COMPANIES.id = (
	SELECT COMPANIES.location_id, COUNT(COMPANIES.location_id) AS number_of_companies
	FROM rappi.COMPANIES
	INNER JOIN rappi.LOCATIONS
	ON COMPANIES.location_id = LOCATIONS.id
	GROUP BY COMPANIES.location_id
	ORDER BY number_of_companies DESC
	LIMIT 1
);



SELECT PEOPLE.name, COMPANIES.name
FROM (
	
)
INNER JOIN rappi.PEOPLE
ON COMPANIES.id = PEOPLE.company_id;

SELECT COMPANIES.id, COMPANIES.name, COMPANIES.location_id, COUNT(COMPANIES.location_id) AS number_of_companies
	FROM rappi.COMPANIES
	INNER JOIN rappi.LOCATIONS
	ON COMPANIES.location_id = LOCATIONS.id
	GROUP BY COMPANIES.id, COMPANIES.name, COMPANIES.location_id
	ORDER BY number_of_companies DESC
	LIMIT 1




SELECT COMPANIES.id, COMPANIES.name, COMPANIES.location_id, COUNT(COMPANIES.location_id) AS number_of_companies
FROM rappi.COMPANIES
INNER JOIN rappi.LOCATIONS
ON COMPANIES.location_id = LOCATIONS.id
GROUP BY COMPANIES.id, COMPANIES.name, COMPANIES.location_id
ORDER BY number_of_companies DESC
LIMIT 1;






--esta si

SELECT PEOPLE.name, COMPANIES.name
FROM rappi.COMPANIES
INNER JOIN rappi.PEOPLE
ON COMPANIES.id = PEOPLE.company_id
WHERE COMPANIES.id = (
	SELECT COMPANIES.id
	FROM (
		SELECT COMPANIES.id, COMPANIES.location_id, COUNT(COMPANIES.location_id) AS number_of_companies
		FROM rappi.COMPANIES
		INNER JOIN rappi.LOCATIONS
		ON COMPANIES.location_id = LOCATIONS.id
		GROUP BY COMPANIES.id, COMPANIES.name, COMPANIES.location_id
		ORDER BY number_of_companies DESC
		LIMIT 1)
);

SELECT PEOPLE.name, COMPANIES.name
FROM rappi.PEOPLE
INNER JOIN (
	SELECT COMPANIES.id, COMPANIES.name, COMPANIES.location_id, COUNT(COMPANIES.location_id) AS number_of_companies
	FROM rappi.COMPANIES
	INNER JOIN rappi.LOCATIONS
	ON COMPANIES.location_id = LOCATIONS.id
	GROUP BY COMPANIES.id, COMPANIES.name, COMPANIES.location_id
	ORDER BY number_of_companies DESC
	--LIMIT 1
) AS COMPANIES
ON COMPANIES.id = PEOPLE.company_id;

SELECT COUNT(*) AS 
FROM rappi.LOCATIONS
ORDER BY 



SELECT CONCAT(pa2.nombre, ' ', pa2.apellido) AS tutor,
		COUNT(*) AS alumnos_por_tutor
FROM platzi.alumnos AS pa
	INNER JOIN platzi.alumnos AS pa2
	ON pa.tutor_id = pa2.id
GROUP BY tutor
ORDER BY alumnos_por_tutor DESC
LIMIT 10;


SELECT DISTINCT COMPANIES.location_id, COUNT(COMPANIES.location_id) AS number_of_companies
FROM rappi.COMPANIES
GROUP BY COMPANIES.location_id
ORDER BY number_of_companies DESC
LIMIT 1


--Respuesta avanzada
SELECT PEOPLE.name, COMPANIES.name
FROM rappi.PEOPLE
INNER JOIN (
	SELECT COMPANIES.id, COMPANIES.name
	FROM rappi.COMPANIES
	INNER JOIN(
		SELECT DISTINCT COMPANIES.location_id, COUNT(COMPANIES.location_id) AS number_of_companies
		FROM rappi.COMPANIES
		GROUP BY COMPANIES.location_id
		ORDER BY number_of_companies DESC
		LIMIT 1
	) AS filtered_companies
	ON filtered_companies.location_id = COMPANIES.location_id
) AS COMPANIES
ON COMPANIES.id = PEOPLE.company_id





--PRUEBA DOS



SELECT invoice.invoice_number, customer.customer_name, COUNT(invoice.invoice_number) AS invoices_count
FROM customer
INNER JOIN invoice
ON invoice.customer_id = customer.id
GROUP BY invoice.invoice_number, customer.customer_name;