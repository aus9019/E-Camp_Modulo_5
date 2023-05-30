
-- En las siguientes tablas aún no se agregan las FOREIGN KEY, ya que en el diagrama Entidad-Relación no se especifican cuáles son
-- en el Drilling de la Sesión 3 ya quedan establecidos dichos FOREIGN KEY.

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
	FrecuenciaMantencion INT
);

CREATE TABLE Venta (
	Folio INT PRIMARY KEY,
	Fecha DATE,
	Monto INT
);

CREATE TABLE Mantencion (
	IDMantencion INT PRIMARY KEY,
	Fecha DATE,
	TrabajosRealizados VARCHAR(1000),
	Venta_Folio INT
);