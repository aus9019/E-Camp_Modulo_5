------------------------- Tablas creadas en Drilling Sesion 3 Modulo 5 -------------------------

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

------------------------- Datos agregados en Drilling Sesion 4 Modulo 5 -------------------------

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

-- Inserte 2 arriendos para cada cliente.
INSERT INTO Arriendo (Folio, Fecha, Dias, ValorDia, Garantia, Herramienta_IDHerramienta, Cliente_RUT)
VALUES (1001, '2023-04-28', 4, 9990, 15000, 013, '12512724-5'),
	   (1004, '2023-05-12', 6, 4990, 12000, 011, '13623712-7');


SELECT * FROM Empresa;
SELECT * FROM Herramienta;
SELECT * FROM Cliente;
SELECT * FROM Arriendo;

------------------------- Drilling Sesion 6 Modulo 5 -------------------------

-- 1. Listar  todos  los  arriendos  con  las  siguientes  columnas:  Folio,  Fecha,  Días,  ValorDia, NombreCliente, RutCliente. 
SELECT Folio, Fecha, Dias, ValorDia, Nombre AS NombreCliente, RUT AS RutCliente
FROM Arriendo
INNER JOIN Cliente ON Arriendo.Cliente_RUT = Cliente.RUT;

-- 2. Listar los clientes sin arriendos. 
SELECT RUT, Nombre
FROM Cliente
LEFT JOIN Arriendo ON Cliente.RUT = Arriendo.Cliente_RUT
WHERE Cliente_RUT IS NULL;

-- 3. Liste RUT y Nombre de las tablas empresa y cliente. 
SELECT RUT, Nombre FROM Empresa
UNION ALL
SELECT RUT, Nombre FROM Cliente;

-- 4. Liste la cantidad de arriendos por mes.
SELECT TO_CHAR(Fecha, 'MM') AS Numero_Mes, COUNT(*) AS Numero_Arriendos
FROM Arriendo
GROUP BY Numero_Mes;







