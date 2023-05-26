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
