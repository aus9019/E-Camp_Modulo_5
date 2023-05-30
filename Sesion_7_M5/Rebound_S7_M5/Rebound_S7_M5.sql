---------------------------- TABLAS ----------------------------

CREATE TABLE Empresa (
    RUT VARCHAR(10) PRIMARY KEY,
    Nombre VARCHAR(120),
    Direccion VARCHAR(120),
    Telefono VARCHAR(15),
    Correo VARCHAR(80),
    Web VARCHAR(50)
);

CREATE TABLE Cliente (
    RUT VARCHAR(10) PRIMARY KEY,
    Nombre VARCHAR(120),
    Correo VARCHAR(80),
    Direccion VARCHAR(120),
    Celular VARCHAR(15),
	Alta CHAR(1)
);

CREATE TABLE TipoVehiculo (
	IDTipoVehiculo INT PRIMARY KEY,
	Nombre VARCHAR(120)
);

CREATE TABLE Marca (
	IDMarca INT PRIMARY KEY,
	Nombre VARCHAR(120)
);

CREATE TABLE Vehiculo (
	IDVehiculo INT PRIMARY KEY,
	Patente VARCHAR(10),
	Marca VARCHAR(20),
	Modelo VARCHAR(20),
	Color VARCHAR(15),
	Precio INT,
	FrecuenciaMantencion INT,
	Marca_IDMarca INT,
	TipoVehiculo_IDTipoVehiculo INT,
	FOREIGN KEY (TipoVehiculo_IDTipoVehiculo) REFERENCES TipoVehiculo (IDTipoVehiculo),
    FOREIGN KEY (Marca_IDMarca) REFERENCES Marca (IDMarca)
);

CREATE TABLE Venta (
	Folio INT PRIMARY KEY,
	Fecha DATE,
	Monto INT,
	Vehiculo_IDVehiculo INT UNIQUE,
	Cliente_RUT VARCHAR (10),
	FOREIGN KEY (Vehiculo_IDVehiculo) REFERENCES Vehiculo (IDVehiculo),
    FOREIGN KEY (Cliente_RUT) REFERENCES Cliente (RUT)
);

CREATE TABLE Mantencion (
	IDMantencion INT PRIMARY KEY,
	Fecha DATE,
	TrabajosRealizados VARCHAR(1000),
	Venta_Folio INT,
	FOREIGN KEY (Venta_Folio) REFERENCES Venta (Folio)
);

---------------------------- DATOS ----------------------------

INSERT INTO Empresa (RUT, Nombre, Direccion, Telefono, Correo, Web)
VALUES ('40.031.123', 'ReparaTodo LTDA', 'Las Acacias 432', '912304312', 'reparatodo@correo.com', 'www.reparatodo.com');

INSERT INTO TipoVehiculo (IDTipoVehiculo, Nombre)
VALUES (1100, 'SUV'),
	   (2200, 'SEDAN');

INSERT INTO Cliente (RUT, Nombre, Correo, Direccion, Celular, Alta)
VALUES ('13435342-4', 'Pedro Fuentes', 'pedro.f@correo.com', 'El Nogal 121', '954123154', 'S'),
	   ('16876435-1', 'Ana Pizarro', 'ana.p@correo.com', 'Los Olivos 43', '965254234', 'S'),
	   ('11743824-7', 'Ricardo Molina', 'ricardo.m@correo.com', 'Las Higueras 156', '957332784', 'N'),
	   ('15432123-5', 'Juan Soto', 'juan.s@correo.com', 'El Vergel 54', '653612345', 'S');

INSERT INTO Marca (IDMarca, Nombre)
VALUES (100, 'Toyota'),
	   (200, 'Chevrolet');

INSERT INTO Vehiculo (IDVehiculo, Patente, Marca, Modelo, Color, Precio, FrecuenciaMantencion, Marca_IDMarca, TipoVehiculo_IDTipoVehiculo)
VALUES (01, 'HDYR-12', 'Toyota', 'Yaris', 'Azul', 4550000, 60, 100, 2200),
	   (02, 'TRYW-54', 'Toyota', 'RAV4', 'Rojo', 8650000, 60, 100, 1100),
	   (03, 'FFER-21', 'Chevrolet', 'Onix', 'Rojo', 15550000, 40, 200, 2200),
	   (04, 'BRQW-98', 'Chevrolet ', 'Equinox', 'Blanco', 10350000, 60, 200, 1100),
	   (05, 'REAF-15', 'Toyota', 'Corolla', 'Gris', 6550000, 60, 100, 2200),
	   (06, 'BHGT-21', 'Toyota', 'Avalon', 'Negro', 8500000, 50, 100, 2200);

INSERT INTO Venta (Folio, Fecha, Monto, Vehiculo_IDVehiculo, Cliente_RUT)
VALUES (101, '2023-01-15', 8650000, 02, '16876435-1'),
	   (102, '2023-03-21', 6550000, 05, '13435342-4'),
	   (103, '2020-01-10', 10350000, 04, '15432123-5'),
	   (104, '2020-11-05', 8500000, 06, '13435342-4');
	   
---------------------------- REBOUND S7_M5 ----------------------------

-- 1. Listar los clientes sin ventas por medio de una subconsulta. 
SELECT * FROM Cliente
WHERE RUT NOT IN (SELECT Cliente_RUT FROM Venta);

-- 2. Listar  todas  ventas  con  las  siguientes  columnas:  Folio,  Fecha,  Monto,  NombreCliente, RutCliente.  
SELECT Folio, Fecha, Monto, Cliente.Nombre AS NombreCliente, Cliente.RUT AS RutCliente
FROM Venta
JOIN Cliente ON Venta.Cliente_RUT = Cliente.RUT;

-- 3. Clasificar los clientes según la siguiente tabla: Total de Ventas Anuales entre (0 y 1.000.000) = Standar, entre (1.000.001 y 3.000.000) = Gold, entre (3.000.001 o mas) = Premium.
SELECT Cliente.Nombre AS NombreCliente, COUNT(*) AS TotalVentasAnuales,
CASE
    WHEN SUM(Venta.Monto) BETWEEN 0 AND 1000000 THEN 'Standar'
    WHEN SUM(Venta.Monto) BETWEEN 1000001 AND 3000000 THEN 'Gold'
	WHEN SUM(Venta.Monto) >= 3000001 THEN 'Premium'
END AS Clasificacion FROM Cliente 
JOIN Venta ON Cliente.RUT = Venta.Cliente_RUT
GROUP BY Cliente.Nombre

-- 4. Por medio de una subconsulta, listar las ventas con la marca del vehículo más vendido. 
SELECT Venta.Folio, Venta.Fecha, Venta.Monto, Vehiculo.Marca
FROM Venta
INNER JOIN Vehiculo ON Venta.Vehiculo_IDVehiculo = Vehiculo.IDVehiculo
WHERE Vehiculo.Marca = (
    SELECT Marca.Nombre
    FROM Vehiculo
    INNER JOIN Marca ON Vehiculo.Marca_IDMarca = Marca.IDMarca
    GROUP BY Marca.Nombre
    ORDER BY COUNT(*) DESC
    LIMIT 1
);


