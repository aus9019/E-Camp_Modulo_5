CREATE DATABASE Rebound_S5_M5_Biblioteca

SELECT * FROM Editoriales;
SELECT * FROM Libros;

-- 1. Crear  tabla  “editoriales”,  con  los  atributos  código  y  nombre.  Definir  el  código  como  llave primaria.
CREATE TABLE Editoriales (
	Codigo INT NOT NULL PRIMARY KEY, 
	Nombre VARCHAR (100) NOT NULL
);

-- 2. Crear tabla “libros”, con los atributos código, título, y codigoeditorial. Definir el código como llave primaria, y codigoeditorial como llave foránea, referenciando a la tabla editoriales.
CREATE TABLE Libros (
	Codigo INT NOT NULL PRIMARY KEY, 
	Titulo VARCHAR(100) NOT NULL,
	Codigo_Editorial INT NOT NULL,
	FOREIGN KEY (Codigo_Editorial) REFERENCES Editoriales (Codigo)
);

-- 3. Insertar editoriales y libros, de acuerdo con: 
INSERT INTO Editoriales (Codigo, Nombre)
VALUES (11, 'Anaya'),
	   (22, 'Andina'),
	   (33, 'S.M.');
	   
INSERT INTO Libros (Codigo, Titulo, Codigo_Editorial)
VALUES (101, 'Don Quijote de La Mancha I', 11),
	   (103, 'El principito', 22),
	   (104, 'El príncipe', 33),
	   (105, 'Diplomacia ', 33),
	   (102, 'Don Quijote de La Mancha II', 11);

-- 4. Modificar la tabla “libros”, agregando la columna autor y precio:
ALTER TABLE Libros
ADD Autor VARCHAR(100),
ADD Precio INT;

-- 5. Agregar autor y precio a los libros ya ingresados.
UPDATE Libros
SET Autor = CASE Codigo
	WHEN 101 THEN 'Miguel de Cervantes'
    WHEN 103 THEN 'Antoine Saint-Exupery'
    WHEN 104 THEN 'Maquiavelo'
    WHEN 105 THEN 'Henry Kissinger'
    WHEN 102 THEN 'Miguel de Cervantes'
END,
	Precio = CASE Codigo
    WHEN 101 THEN 150
    WHEN 103 THEN 120
    WHEN 104 THEN 180
    WHEN 105 THEN 170
    WHEN 102 THEN 140
END;

-- 6. Insertar 2 nuevos libros.
INSERT INTO Editoriales (Codigo, Nombre)
VALUES (44, 'Minotauro');

INSERT INTO Libros (Codigo, Titulo, Codigo_Editorial, Autor, Precio)
VALUES (106, 'La llamada de Cthulhu', 44, 'H.P. Lovecraft', 190),
	   (107, 'El Silmarillion', 44, 'J.R.R. Tolkien', 200);

-- 7. Eliminar los libros de la editorial Anaya, solo en memoria (ROLLBACK).
BEGIN; 
DELETE FROM Libros
WHERE Codigo_Editorial = (
    SELECT Codigo
    FROM Editoriales
    WHERE Nombre = 'Anaya'
);
ROLLBACK;

-- 8. Actualizar el nombre de la editorial Andina a Iberlibro en memoria, y actualizar el nombre de la editorial S.M. a Mountain en disco duro (SAVEPOINT / ROLLBACK TO).
BEGIN;
UPDATE Editoriales 
SET Nombre = 'Iberlibro'
WHERE Nombre = 'Andina';

SAVEPOINT Actualizar;
UPDATE Editoriales 
SET Nombre = 'Mountain'
WHERE Nombre = 'S.M.';
ROLLBACK TO Actualizar;

