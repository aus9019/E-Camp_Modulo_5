-- Inserte los datos de una empresa
INSERT INTO Empresa (RUT, Nombre, Direccion, Telefono, Correo, Web)
VALUES ('40.031.123', 'ReparaTodo LTDA', 'Las Acacias 432', '912304312', 'reparatodo@correo.com', 'www.reparatodo.com');

-- Inserte 2 tipos de vehículo
INSERT INTO TipoVehiculo (IDTipoVehiculo, Nombre)
VALUES (1100, 'SUV'),
	   (2200, 'SEDAN');

-- Inserte 3 clientes.
INSERT INTO Cliente (RUT, Nombre, Correo, Direccion, Celular, Alta)
VALUES ('13435342-4', 'Pedro Fuentes', 'pedro.f@correo.com', 'El Nogal 121', '954123154', 'S'),
	   ('16876435-1', 'Ana Pizarro', 'ana.p@correo.com', 'Los Olivos 43', '965254234', 'S'),
	   ('11743824-7', 'Ricardo Molina', 'ricardo.m@correo.com', 'Las Higueras 156', '957332784', 'N');

-- Inserte 2 marcas.
INSERT INTO Marca (IDMarca, Nombre)
VALUES (100, 'Toyota'),
	   (200, 'Chevrolet');

-- Inserte 5 vehículos.
INSERT INTO Vehiculo (IDVehiculo, Patente, Marca, Modelo, Color, Precio, FrecuenciaMantencion, Marca_IDMarca, TipoVehiculo_IDTipoVehiculo)
VALUES (01, 'HDYR-12', 'Toyota', 'Yaris', 'Azul', 4550000, 60, 100, 2200),
	   (02, 'TRYW-54', 'Toyota', 'RAV4', 'Rojo', 8650000, 60, 100, 1100),
	   (03, 'FFER-21', 'Chevrolet', 'Onix', 'Rojo', 15550000, 40, 200, 2200),
	   (04, 'BRQW-98', 'Chevrolet ', 'Equinox', 'Blanco', 10350000, 60, 200, 1100),
	   (05, 'REAF-15', 'Toyota', 'Corolla', 'Gris', 6550000, 60, 100, 2200);

-- Elimina el último cliente.
DELETE FROM Cliente
WHERE RUT = '11743824-7';

-- Inserte 1 venta para cada cliente.
INSERT INTO Venta (Folio, Fecha, Monto, Vehiculo_IDVehiculo, Cliente_RUT)
VALUES (101, '2023-01-15', 8650000, 02, '16876435-1'),
	   (102, '2023-03-21', 6550000, 05, '13435342-4');

-- Modifique el nombre del segundo cliente.
UPDATE Cliente
SET Nombre = 'Angelica Jara'
WHERE RUT = '16876435-1';

-- Liste todas las ventas.
SELECT * 
FROM Venta

-- Liste las ventas del primer cliente.
SELECT *
FROM Venta
WHERE Cliente_RUT = '13435342-4';

-- Obtenga la patente de todos los vehículos.
SELECT Patente FROM Vehiculo;




