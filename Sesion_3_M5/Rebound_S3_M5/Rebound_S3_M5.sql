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

CREATE TABLE Venta (
	Folio INT PRIMARY KEY,
	Fecha DATE,
	Monto INT,
	Vehiculo_IDVehiculo INT UNIQUE,
	Cliente_RUT VARCHAR (10),
	FOREIGN KEY (Vehiculo_IDVehiculo) REFERENCES Vehiculo (IDVehiculo),
    FOREIGN KEY (Cliente_RUT) REFERENCES Cliente (RUT)
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

CREATE TABLE Mantencion (
	IDMantencion INT PRIMARY KEY,
	Fecha DATE,
	TrabajosRealizados VARCHAR(1000),
	Venta_Folio INT,
	FOREIGN KEY (Venta_Folio) REFERENCES Venta (Folio)
);

CREATE TABLE Marca (
	IDMarca INT PRIMARY KEY,
	Nombre VARCHAR(120)
);
