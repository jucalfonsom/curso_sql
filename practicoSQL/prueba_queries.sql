SELECT *
FROM platzi.alumnos AS pa;

SELECT *
FROM platzi.carreras AS pc;

SELECT *
FROM platzi.alumnos AS pa
JOIN platzi.carreras AS pc
ON pa.carrera_id = pc.id;

SELECT pc.carrera, COUNT(pa.id) AS Num_est
FROM platzi.alumnos AS pa
JOIN platzi.carreras AS pc
ON pa.carrera_id = pc.id
GROUP BY pc.carrera
ORDER BY num_est DESC
LIMIT 5;

SELECT *
FROM platzi.alumnos AS pa
FETCH FIRST 1 ROWS ONLY;

SELECT *
FROM (
	SELECT ROW_NUMBER() 
	() AS row_id, *
	FROM platzi.alumnos AS pa
) AS alumnos_with_row_num
WHERE row_id = 10;

'Reto: primeros 5 registros con todo lo visto antes'

SELECT *
FROM platzi.alumnos AS pa
FETCH FIRST 5 ROWS ONLY;

SELECT *
FROM platzi.alumnos AS pa
LIMIT 5;

SELECT *
FROM (
	SELECT ROW_NUMBER() OVER() AS row_id, *
	FROM platzi.alumnos AS pa
) AS alumnos_with_row_num
WHERE row_id<=5;

SELECT *
FROM (
	SELECT ROW_NUMBER() OVER() AS row_id, *
	FROM platzi.alumnos AS pa
) AS alumnos_with_row_num
WHERE row_id BETWEEN 1
	AND 5;
	
'Obtener la segunda colegiatura más alta'
SELECT DISTINCT colegiatura
FROM platzi.alumnos AS pa
WHERE 2 = (
	SELECT COUNT(DISTINCT colegiatura)
	FROM platzi.alumnos AS pa2
	WHERE pa.colegiatura <= pa2.colegiatura
);

SELECT DISTINCT colegiatura, tutor_id
FROM platzi.alumnos
WHERE tutor_id = 20
ORDER BY colegiatura DESC
LIMIT 1 OFFSET 1;

SELECT *
FROM platzi.alumnos AS pa
INNER JOIN (
	SELECT DISTINCT colegiatura
	FROM platzi.alumnos AS pa2
	WHERE tutor_id = 20
	ORDER BY colegiatura DESC
	LIMIT 1 OFFSET 1
) AS segunda_mayor_colegiatura
ON pa.colegiatura = segunda_mayor_colegiatura.colegiatura;

SELECT * 
FROM platzi.alumnos AS pa
WHERE colegiatura = (
	SELECT DISTINCT colegiatura
	FROM platzi.alumnos
	WHERE tutor_id = 20
	ORDER BY colegiatura DESC
	LIMIT 1 OFFSET 1
);

'Reto 2: Traer la segunda mitad de la tabla platzi.alumnos'

SELECT *
FROM platzi.alumnos AS pa
WHERE pa.id >(
	SELECT COUNT(pa2.id)/2
	FROM platzi.alumnos AS pa2
);

SELECT * 
FROM platzi.alumnos
OFFSET (
	SELECT COUNT(pa2.id)/2
	FROM platzi.alumnos AS pa2
);

'Solución profesor'

SELECT ROW_NUMBER() OVER() AS row_id, *
FROM platzi.alumnos
OFFSET(
	SELECT COUNT(*)/2
	FROM platzi.alumnos
);


'Arrays'

SELECT *
FROM (
	SELECT ROW_NUMBER() OVER() AS row_id, *
	FROM platzi.alumnos
) AS alumnos_with_row_nums
WHERE row_id IN (1,5,10,12,15,20);

SELECT *
FROM platzi.alumnos AS pa
WHERE pa.id IN (
	SELECT pa2.id
	FROM platzi.alumnos AS pa2
	WHERE tutor_id = 30
);

'Reto 3: Seleccionar los resultados que no se encuentren en el set tutor_id=30'

SELECT *
FROM platzi.alumnos AS pa
WHERE pa.tutor_id IN (
	SELECT pa2.tutor_id
	FROM platzi.alumnos AS pa2
	WHERE NOT tutor_id = 30
);

SELECT *
FROM platzi.alumnos AS pa
WHERE NOT pa.tutor_id = 30;

'Fechas'

SELECT EXTRACT(YEAR FROM fecha_incorporacion) AS anio_incorporacion, *
FROM platzi.alumnos;

SELECT DATE_PART('YEAR', fecha_incorporacion) AS anio_incorporacion, *
FROM platzi.alumnos;

SELECT DATE_PART('YEAR', fecha_incorporacion) AS anio_incorporacion, 
		DATE_PART('MONTH', fecha_incorporacion) AS mes_incorporacion,
		DATE_PART('DAY', fecha_incorporacion) AS dia_incorporacion
FROM platzi.alumnos;

'Reto 4: extraer horas, minutos y segundos'

SELECT fecha_incorporacion,
		DATE_PART('YEAR', fecha_incorporacion) AS anio_incorporacion, 
		DATE_PART('MONTH', fecha_incorporacion) AS mes_incorporacion,
		DATE_PART('DAY', fecha_incorporacion) AS dia_incorporacion,
		DATE_PART('HOUR', fecha_incorporacion) AS hora_incorporacion,
		DATE_PART('MINUTE', fecha_incorporacion) AS minuto_incorporacion,
		DATE_PART('SECOND', fecha_incorporacion) AS segundo_incorporacion
FROM platzi.alumnos;


SELECT *
FROM platzi.alumnos AS pa
WHERE (
	EXTRACT(YEAR FROM pa.fecha_incorporacion)
) = 2018;

SELECT *
FROM platzi.alumnos AS pa
WHERE (
	DATE_PART('YEAR', fecha_incorporacion)
) = 2019;


SELECT *
FROM (
	SELECT *, DATE_PART('YEAR', fecha_incorporacion) AS anio_incorporacion
	FROM platzi.alumnos
) AS alumnos_with_anio
WHERE alumnos_with_anio.anio_incorporacion = 2020;

'Reto 5: Alumnos en mayo 2018'

SELECT *
FROM (
	SELECT *, 
			DATE_PART('YEAR', fecha_incorporacion) AS anio_incorporacion,
			DATE_PART('MONTH', fecha_incorporacion) AS mes_incorporacion
	FROM platzi.alumnos
) AS alumnos_with_anio
WHERE alumnos_with_anio.anio_incorporacion = 2018
	AND alumnos_with_anio.mes_incorporacion = 5;
	

SELECT *
FROM platzi.alumnos AS pa
WHERE (DATE_PART('YEAR', pa.fecha_incorporacion)) = 2018
	AND (DATE_PART('MONTH', pa.fecha_incorporacion)) = 5;

'Duplicados'

INSERT INTO platzi.alumnos (id, nombre, apellido, email, colegiatura, fecha_incorporacion, carrera_id, tutor_id) 
VALUES (1001, 'Pamelina', null, 'pmylchreestrr@salon.com', 4800, '2020-04-26 10:18:51', 12, 16);

'El id es distinto pero la demás data es igual'
SELECT *
FROM platzi.alumnos AS pa
WHERE (
	SELECT COUNT(*)
	FROM platzi.alumnos AS pa2
	WHERE pa.id = pa2.id
) > 1;

SELECT (platzi.alumnos.*)::text, COUNT(*)
FROM platzi.alumnos
GROUP BY platzi.alumnos.*
HAVING COUNT(*)>1;

'Seleccionar todos sin el id'
SELECT (platzi.alumnos.nombre,
	   platzi.alumnos.apellido,
	   platzi.alumnos.email,
	   platzi.alumnos.colegiatura,
	   platzi.alumnos.fecha_incorporacion,
	   platzi.alumnos.carrera_id,
	   platzi.alumnos.tutor_id)::text, COUNT(*)
FROM platzi.alumnos
GROUP BY platzi.alumnos.nombre,
	   platzi.alumnos.apellido,
	   platzi.alumnos.email,
	   platzi.alumnos.colegiatura,
	   platzi.alumnos.fecha_incorporacion,
	   platzi.alumnos.carrera_id,
	   platzi.alumnos.tutor_id
HAVING COUNT(*)>1;

SELECT *
FROM (
	SELECT id,
	ROW_NUMBER() OVER(
		PARTITION BY
			nombre,
			apellido,
			email,
			colegiatura,
			fecha_incorporacion,
			carrera_id,
			tutor_id
		ORDER BY id ASC
	) AS row,
	*
	FROM platzi.alumnos
) AS duplicados
WHERE duplicados.row > 1;

'Reto 6: Borrar duplicados de la tabla'

DELETE
FROM platzi.alumnos AS pa
WHERE pa.id IN (
	SELECT duplicados.id
	FROM (
		SELECT ROW_NUMBER() OVER(
			PARTITION BY
			nombre,
			apellido,
			email,
			colegiatura,
			fecha_incorporacion,
			carrera_id,
			tutor_id
			ORDER BY id ASC) AS row, *
			FROM platzi.alumnos
		) AS duplicados
		WHERE duplicados.row > 1
);


'Rangos'

SELECT *
FROM platzi.alumnos
WHERE tutor_id IN (1,2,3,4);


SELECT *
FROM platzi.alumnos
WHERE tutor_id >= 1
	AND tutor_id <= 10;
	

SELECT *
FROM platzi.alumnos
WHERE tutor_id BETWEEN 1 AND 10;

SELECT int4range(10, 20) @>3;
SELECT int4range(10, 20) @>11;

SELECT numrange(11.1, 22.2) && numrange(20.0, 30.0);
SELECT numrange(11.1, 12.2) && numrange(20.0, 30.0);

SELECT UPPER(int8range(15, 25));
SELECT LOWER(int8range(15, 25));

SELECT int4range(10, 20) * int4range(15, 25);

SELECT ISEMPTY(numrange(1, 5));


SELECT *
FROM platzi.alumnos
WHERE int4range(10, 20) @>tutor_id;

'Reto 7: intersección entre dos rangos entre tutor_id y carrera_id'
SELECT int4range(MIN(tutor_id), MAX(tutor_id)) *int4range(MIN(carrera_id), MAX(carrera_id))
FROM platzi.alumnos;

SELECT numrange(
	(SELECT MIN(tutor_id) FROM platzi.alumnos),
	(SELECT MAX(tutor_id) FROM platzi.alumnos)
) * numrange(
	(SELECT MIN(carrera_id) FROM platzi.alumnos),
	(SELECT MAX(carrera_id) FROM platzi.alumnos)
	
);


'Máximos y mínimos'
SELECT fecha_incorporacion
FROM platzi.alumnos
ORDER BY fecha_incorporacion DESC
LIMIT 1;

SELECT carrera_id, MAX(fecha_incorporacion)
FROM platzi.alumnos
GROUP BY carrera_id
ORDER BY carrera_id;

'Reto 8: El mínimo nombre alfabético de la tabla y por tutor'
SELECT nombre
FROM platzi.alumnos
ORDER BY nombre ASC
LIMIT 1;

SELECT tutor_id, MIN(nombre)
FROM platzi.alumnos
GROUP BY tutor_id
ORDER BY tutor_id ASC;

'Self join'

SELECT pa.nombre, 
		pa.apellido,
		pa2.nombre,
		pa2.apellido
FROM platzi.alumnos AS pa
	INNER JOIN platzi.alumnos AS pa2
	ON pa.tutor_id = pa2.id;


SELECT CONCAT(pa2.nombre, ' ', pa2.apellido) AS tutor,
		COUNT(*) AS alumnos_por_tutor
FROM platzi.alumnos AS pa
	INNER JOIN platzi.alumnos AS pa2
	ON pa.tutor_id = pa2.id
GROUP BY tutor
ORDER BY alumnos_por_tutor DESC
LIMIT 10;

'Reto 9: Promedio de alumnos por tutor'
SELECT AVG(alum_tutor.alumnos_por_tutor) AS promedio_alumnos_por_tutor
FROM (
	SELECT CONCAT(pa2.nombre, ' ', pa2.apellido) AS tutor,
			COUNT(*) AS alumnos_por_tutor
	FROM platzi.alumnos AS pa
		INNER JOIN platzi.alumnos AS pa2
		ON pa.tutor_id = pa2.id
	GROUP BY tutor
) AS alum_tutor


'Resolviendo diferencias'
SELECT carrera_id, COUNT(*) AS cuenta
FROM platzi.alumnos
GROUP BY carrera_id
ORDER BY cuenta DESC;


SELECT a.nombre,
		a.apellido,
		a.carrera_id,
		c.id,
		c.carrera
FROM platzi.alumnos AS a
	LEFT JOIN platzi.carreras AS c
	ON a.carrera_id = c.id
WHERE c.id IS NULL
ORDER BY a.carrera_id;

'Reto 10: Left Join pero sin excluir'
SELECT a.nombre,
		a.apellido,
		a.carrera_id,
		c.id,
		c.carrera
FROM platzi.alumnos AS a
	FULL OUTER JOIN platzi.carreras AS c
	ON a.carrera_id = c.id
ORDER BY a.carrera_id;


'Explorar JOINS'

--Exclusive Left Join
SELECT a.nombre,
		a.apellido,
		a.carrera_id,
		c.id,
		c.carrera
FROM platzi.alumnos AS a
	LEFT JOIN platzi.carreras AS c
	ON a.carrera_id = c.id
WHERE c.id IS NULL;

--Left Join
SELECT a.nombre,
		a.apellido,
		a.carrera_id,
		c.id,
		c.carrera
FROM platzi.alumnos AS a
	LEFT JOIN platzi.carreras AS c
	ON a.carrera_id = c.id
ORDER BY c.id DESC;

--Right Join
SELECT a.nombre,
		a.apellido,
		a.carrera_id,
		c.id,
		c.carrera
FROM platzi.alumnos AS a
	RIGHT JOIN platzi.carreras AS c
	ON a.carrera_id = c.id
ORDER BY c.id DESC;

--Exclusive Right Join
SELECT a.nombre,
		a.apellido,
		a.carrera_id,
		c.id,
		c.carrera
FROM platzi.alumnos AS a
	RIGHT JOIN platzi.carreras AS c
	ON a.carrera_id = c.id
WHERE a.carrera_id IS NULL
ORDER BY c.id DESC;

--Inner Join
SELECT a.nombre,
		a.apellido,
		a.carrera_id,
		c.id,
		c.carrera
FROM platzi.alumnos AS a
	INNER JOIN platzi.carreras AS c
	ON a.carrera_id = c.id
ORDER BY c.id DESC;

--Diferencia simétrica
SELECT a.nombre,
		a.apellido,
		a.carrera_id,
		c.id,
		c.carrera
FROM platzi.alumnos AS a
	FULL OUTER JOIN platzi.carreras AS c
	ON a.carrera_id = c.id
WHERE a.carrera_id IS NULL 
	OR c.id IS NULL
ORDER BY a.carrera_id DESC, c.id DESC;

'Triangulando'
SELECT lpad('sql', 15, '*');

SELECT lpad('*', id, '*'), carrera_id
FROM platzi.alumnos
WHERE id < 10
ORDER BY carrera_id;

SELECT lpad('*', CAST(row_id AS int), '*')
FROM (
	SELECT ROW_NUMBER() OVER(ORDER BY carrera_id) AS row_id, *
	FROM platzi.alumnos
) AS alumnos_with_row_id
WHERE row_id <= 5
ORDER BY carrera_id;

SELECT rpad('sql', 15, '*');

SELECT rpad('*', id, '*'), carrera_id
FROM platzi.alumnos
WHERE id < 10
ORDER BY carrera_id;

SELECT rpad('*', CAST(row_id AS int), '*')
FROM (
	SELECT ROW_NUMBER() OVER(ORDER BY carrera_id) AS row_id, *
	FROM platzi.alumnos
) AS alumnos_with_row_id
WHERE row_id <= 5
ORDER BY carrera_id;


'Generar rangos'
SELECT * 
FROM generate_series(1, 4);

SELECT * 
FROM generate_series(5, 1, -2);

SELECT current_date + s.a AS dates
FROM generate_series(0, 14, 7) AS s(a);

SELECT *
FROM generate_series('2020-09-01 00:00:00'::timestamp,
					 '2020-09-04 12:00:00'::timestamp,
					 '10 hours');

SELECT a.id,
		a.nombre,
		a.apellido,
		a.carrera_id,
		s.a
FROM platzi.alumnos AS a
	INNER JOIN generate_series(0, 10) AS s(a)
	ON a.carrera_id = s.a
ORDER BY a.carrera_id;


'Regex'

SELECT email
FROM platzi.alumnos
WHERE email ~*'[A-Z0-9._%+-]+@google[A-Z0-9.-]+\.[A-Z]{2,4}';


'Arbolito'
SELECT lpad('\', s.a, rpad(lpad('/', d.e, ' '), s.a, '*'))
FROM generate_series(18, 26) AS s(a), 
	 generate_series(17,0,-2) AS d(e)
LIMIT 10;
