-- 1. Crear base de datos llamada: películas.
CREATE DATABASE Drilling_S5_M5_Peliculas;

SELECT * FROM Peliculas;
SELECT * FROM Reparto;

/* 2. Creando las  tablas  correspondientes, determinando  la  relación  entre  ambas.  Los  nombres  de  los  atributos  en  la  tabla  películas 
serán: id, pelicula, estreno, director. Y los nombres de los atributos en la tabla reparto serán: id_pelicula, actor. */
CREATE TABLE Peliculas (
	ID INT NOT NULL PRIMARY KEY,
	Pelicula VARCHAR(150) NOT NULL,
	Estreno INT NOT NULL,
	Director VARCHAR(150) NOT NULL
);

CREATE TABLE Reparto (
	ID_Pelicula INT NOT NULL,
	Actor VARCHAR(150) NOT NULL,
	FOREIGN KEY (ID_Pelicula) REFERENCES Peliculas (ID)
);

-- 3. Cargar ambos archivos a su tabla correspondiente. (HECHO)

-- 7. Listar todos los actores que aparecen en la película "Titanic", indicando el título de la película, año de estreno, director y todo el reparto.
SELECT Pelicula, Estreno, Director, Actor
FROM Peliculas
JOIN Reparto ON Peliculas.ID = Reparto.ID_Pelicula
WHERE pelicula = 'Titanic';

-- 8. Listar los 10 directores más populares, indicando su nombre y cuántas películas aparecen en el top 100.
SELECT Director, COUNT(Director) AS Top_100
FROM Peliculas
WHERE ID IN (
    SELECT ID_Pelicula
    FROM Reparto
    WHERE ID_Pelicula IN (
        SELECT ID
        FROM Peliculas
        ORDER BY Estreno DESC
        LIMIT 100
    )
)
GROUP BY Director
ORDER BY Top_100 DESC
LIMIT 10;

-- 9. Indicar cuántos actores distintos hay.
SELECT COUNT(DISTINCT Actor) AS Total_Actores_DIstintos
FROM Reparto;

-- 10.   Indicar las películas estrenadas entre los años 1990 y 1999 (ambos incluidos), ordenadas por título de manera ascendente.
SELECT Pelicula, Estreno
FROM Peliculas
WHERE Estreno BETWEEN 1990 AND 1999
ORDER BY Pelicula ASC;

-- 11.  Listar los actores de la película más nueva (Maximo 15). 
SELECT Actor
FROM Peliculas
INNER JOIN Reparto ON Peliculas.ID = Reparto.ID_Pelicula
WHERE Estreno = (SELECT MAX(Estreno) FROM Peliculas)
LIMIT 15;

-- 12.  Inserte los datos de una nueva película solo en memoria, y otra película en el disco duro. 
INSERT INTO Peliculas (ID, Pelicula, Estreno, Director)
VALUES (101, 'Avengers: Endgame', 2019, 'Anthony Russo');

BEGIN;
INSERT INTO Peliculas (ID, Pelicula, Estreno, Director)
VALUES (102, 'Everything Everywhere All at Once', 2022, 'Dan Kwan');
COMMIT;

-- 13.  Actualice 5 directores utilizando ROLLBACK. 
BEGIN TRANSACTION;
UPDATE Peliculas
SET Director = CASE Director 
  WHEN 'Jon Favreau' THEN 'Jayro Bustamante' 
  WHEN 'Sam Raimi' THEN 'Mati Diop'
  WHEN 'Stanley Kubrick' THEN 'Hamaguchi Ryusuke'
  WHEN 'Guillermo del Toro' THEN 'Kirsten Johnson'
  WHEN 'Hayao Miyazaki' THEN 'Jennifer Kent'
  ELSE Director
  END;
ROLLBACK; 

-- 14.  Inserte 3 actores a la película “Rambo” utilizando SAVEPOINT 
BEGIN TRANSACTION;
SAVEPOINT Insertando_Actores;
INSERT INTO Reparto (ID_Pelicula, Actor)
SELECT ID, 'Alexis Sanchez'
FROM Peliculas
WHERE Pelicula = 'Rambo';
INSERT INTO Reparto (ID_Pelicula, Actor)
SELECT ID, 'Arturo Vidal'
FROM Peliculas
WHERE Pelicula = 'Rambo';
INSERT INTO Reparto (ID_Pelicula, Actor)
SELECT ID, 'Claudio Bravo'
FROM Peliculas
WHERE Pelicula = 'Rambo';
ROLLBACK;

-- 15.  Elimina las películas estrenadas el año 2008 solo en memoria. 
DELETE FROM Reparto
WHERE ID_Pelicula IN (SELECT ID FROM Peliculas WHERE Estreno = 2008);

DELETE FROM Peliculas 
WHERE Estreno = 2008;

-- 16.  Inserte 2 actores para cada película estrenada el 2001. 
INSERT INTO Reparto (ID_Pelicula, Actor)
SELECT ID, 'Pedro Pascal'
FROM Peliculas 
WHERE Estreno = 2001;

INSERT INTO Reparto (ID_Pelicula, Actor)
SELECT ID, 'Vin Diesel'
FROM Peliculas 
WHERE Estreno = 2001;

-- 17.  Actualice la película “King Kong” por el nombre de “Donkey Kong”, sin efectuar cambios en disco duro.
UPDATE Peliculas
SET Pelicula = 'Donkey Kong'
WHERE Pelicula = 'King Kong';


