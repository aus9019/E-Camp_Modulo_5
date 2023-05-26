-- Inserte los datos de una empresa.
INSERT INTO Empresa (RUT, Nombre, Direccion, Telefono, Correo, Web)
VALUES ('24.031.123', 'TodoHerramientas LTDA', 'El Camino 123', '22343123', 'todo.herramientas@correo.com', 'www.TodoHerramientas.com');


-- Inserte 5 herramientas.
INSERT INTO Herramienta (IDHerramienta, Nombre, PrecioDia)
VALUES (010, 'Martillo Neumatico', 10590),
	   (011, 'Cortadora Ceramica', 4990),
	   (012, 'Serrucho Electrico', 8500),
	   (013, 'Maquina Soldadora', 9990),
	   (014, 'Esmeril Angular', 3560);


-- Inserte 3 clientes.
INSERT INTO Cliente (RUT, Nombre, Correo, Direccion, Celular)
VALUES ('12512724-5', 'Marcelo Salas', 'm.salas@correo.com', 'Volcan Osorno 5231', '963466234'),
	   ('13623712-7', 'Ivan Zamorano', 'i.zamorano@correo.com', 'San Sebastian 122', '923516543'),
	   ('11775824-3', 'Pedro Reyes', 'p.reyes@correo.com', 'El Bosque Norte 0091', '915412587');
	   
	   
-- Elimina el último cliente.
DELETE FROM Cliente
WHERE RUT = '11775824-3';


-- Elimina la primera herramienta.
DELETE FROM Herramienta
WHERE IDHerramienta = 010;


-- Inserte 2 arriendos para cada cliente.
INSERT INTO Arriendo (Folio, Fecha, Dias, ValorDia, Garantia, Herramienta_IDHerramienta, Cliente_RUT)
VALUES (1001, '2023-04-28', 4, 9990, 15000, 013, '12512724-5'),
	   (1004, '2023-05-12', 6, 4990, 12000, 011, '13623712-7');


-- Modifique el correo electrónico del primer cliente.
UPDATE Cliente
SET Correo = 'matador@correo.com'
WHERE RUT = '12512724-5';


-- Liste todas las herramientas.
SELECT * 
FROM Herramienta


-- Liste los arriendos del segundo cliente.
SELECT *
FROM Arriendo
WHERE Cliente_RUT = '13623712-7';


-- Liste los clientes cuyo nombre contenga una a.
SELECT *
FROM Cliente
WHERE Nombre LIKE '%a%';


-- Obtenga el nombre de la segunda herramienta insertada.
SELECT Nombre
FROM Herramienta
ORDER BY IDHerramienta
LIMIT 1 OFFSET 1;


-- Modifique los primeros 2 arriendos insertados con fecha 15/01/2020.
UPDATE Arriendo
SET Fecha = '2020-01-15'
WHERE Folio = 1001 OR Folio = 1004


-- Liste Folio, Fecha y ValorDia de los arriendos de enero del 2020.
SELECT Folio, Fecha, ValorDia
FROM Arriendo
WHERE Fecha >= '2020-01-01' AND Fecha <= '2020-01-31';
