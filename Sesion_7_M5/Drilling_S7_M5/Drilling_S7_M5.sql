--------------------------------- TABLAS ---------------------------------

CREATE TABLE Empresa (
    RUT VARCHAR(10) PRIMARY KEY,
    Nombre VARCHAR(120),
    Direccion VARCHAR(120),
    Telefono VARCHAR(15),
    Correo VARCHAR(80),
    Web VARCHAR(50)
);

CREATE TABLE Herramienta (
    IDHerramienta INT PRIMARY KEY,
    Nombre VARCHAR(120),
    PrecioDia INT
);

CREATE TABLE Cliente (
    RUT VARCHAR(10) PRIMARY KEY,
    Nombre VARCHAR(120),
    Correo VARCHAR(80),
    Direccion VARCHAR(120),
    Celular VARCHAR(15)
);

CREATE TABLE Arriendo (
    Folio INT PRIMARY KEY,
    Fecha DATE,
    Dias INT,
    ValorDia INT,
    Garantia VARCHAR(30),
    Herramienta_IDHerramienta INT,
    Cliente_RUT VARCHAR(10),
    FOREIGN KEY (Herramienta_IDHerramienta) REFERENCES Herramienta (IDHerramienta),
    FOREIGN KEY (Cliente_RUT) REFERENCES Cliente (RUT)
);

--------------------------------- DATOS ---------------------------------

INSERT INTO Empresa (RUT, Nombre, Direccion, Telefono, Correo, Web)
VALUES ('24.031.123', 'TodoHerramientas LTDA', 'El Camino 123', '22343123', 'todo.herramientas@correo.com', 'www.TodoHerramientas.com');

INSERT INTO Herramienta (IDHerramienta, Nombre, PrecioDia)
VALUES (010, 'Martillo Neumatico', 10590),
	   (011, 'Cortadora Ceramica', 4990),
	   (012, 'Serrucho Electrico', 8500),
	   (013, 'Maquina Soldadora', 9990),
	   (014, 'Esmeril Angular', 3560);

INSERT INTO Cliente (RUT, Nombre, Correo, Direccion, Celular)
VALUES ('12512724-5', 'Marcelo Salas', 'm.salas@correo.com', 'Volcan Osorno 5231', '963466234'),
	   ('13623712-7', 'Ivan Zamorano', 'i.zamorano@correo.com', 'San Sebastian 122', '923516543'),
	   ('11775824-3', 'Pedro Reyes', 'p.reyes@correo.com', 'El Bosque Norte 0091', '915412587');
	   
INSERT INTO Arriendo (Folio, Fecha, Dias, ValorDia, Garantia, Herramienta_IDHerramienta, Cliente_RUT)
VALUES (1001, '2020-01-20', 4, 9990, 15000, 013, '12512724-5'),
       (1002, '2020-01-28', 2, 9990, 15000, 011, '12512724-5'),
       (1003, '2022-05-12', 5, 4990, 12000, 014, '13623712-7'),
	   (1004, '2022-05-12', 6, 4990, 12000, 012, '13623712-7');

--------------------------------- DRILLING S7_M5 ---------------------------------

-- 1. Listar los clientes sin arriendos por medio de una subconsulta. 
SELECT * FROM Cliente
WHERE RUT NOT IN (SELECT Cliente_RUT FROM Arriendo);

-- 2. Listar  todos  los  arriendos  con  las  siguientes  columnas:  Folio,  Fecha,  Dias,  ValorDia, NombreCliente, RutCliente.
SELECT Folio, Fecha, Dias, ValorDia, Cliente.Nombre AS NombreCliente, Cliente.RUT AS RutCliente
FROM Arriendo
JOIN Cliente ON Arriendo.Cliente_RUT = Cliente.RUT;

-- 3. Clasificar los clientes según la siguiente tabla: Cantidad de Arriendos mensuales entre (0 y 1) = Bajo, entre (1 y 3) = Medio, entre (3 o mas) = Alto.
SELECT Cliente.Nombre AS NombreCliente, COUNT(*) AS CantidadArriendos,
CASE
    WHEN COUNT(*) BETWEEN 0 AND 1 THEN 'Bajo'
    WHEN COUNT(*) BETWEEN 1 AND 3 THEN 'Medio'
	WHEN COUNT(*) >= 3 THEN 'Alto'
END AS Clasificacion FROM Cliente 
JOIN Arriendo ON Cliente.RUT = Arriendo.Cliente_RUT
GROUP BY Cliente.Nombre

-- 4. Por medio de una subconsulta, listar los clientes con el nombre de la herramienta más arrendada.
SELECT Cliente.Nombre AS NombreCliente, Herramienta.Nombre AS NombreHerramienta 
FROM Cliente 
JOIN Arriendo ON RUT = Cliente_RUT
JOIN Herramienta ON Herramienta_IDHerramienta = IDHerramienta
WHERE Herramienta_IDHerramienta IN (
    SELECT Herramienta_IDHerramienta 
	FROM Arriendo
    GROUP BY Herramienta_IDHerramienta
);

