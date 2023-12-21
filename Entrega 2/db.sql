USE [GD2C2023]
GO

/****** Object:  Schema [GRUPO_1]    Script Date: 12/10/2023 15:24:13 ******/
CREATE SCHEMA [GRUPO_1]
GO

CREATE TABLE disposiciones (
    disposicion_id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    disposicion VARCHAR(100) NOT NULL
);

CREATE TABLE estados (
    estado_id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    estado VARCHAR(100) NOT NULL
);

CREATE TABLE orientaciones (
    orientacion_id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    orientacion VARCHAR(100) NOT NULL
);

CREATE TABLE caracteristicas (
    idCaracteristica INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE tiposPeriodos (
    periodo_id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    periodo VARCHAR(100) NOT NULL
);

CREATE TABLE estadosAlquileres (
    estado_id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    estado VARCHAR(100) NOT NULL
);

CREATE TABLE mediosDePagos (
    medioDePago_id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    medio VARCHAR(100) NOT NULL
);

CREATE TABLE tiposInmuebles (
    tipoInmueble INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE tipoOperacion (
    tipoOperacion_id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    tipo VARCHAR(100) NOT NULL
);

CREATE TABLE barrios(
    barrio_id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE localidades(
    localidad_id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    nombre VARCHAR(100) NOT NULL 
);

CREATE TABLE provincias(
    provincia_id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    nombre VARCHAR(100) NOT NULL 
);

CREATE TABLE caracteristicass(
    idCaracteristica INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE cantAmbientes(
    cantidad NUMERIC(2,0) NOT NULL PRIMARY KEY
);

CREATE TABLE monedas (
    moneda_id VARCHAR(3) NOT NULL PRIMARY KEY
);

CREATE TABLE propietarios(
    idPropietario INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    dni NUMERIC(8,0),
    fechaRegistro DATE,
    telefono NUMERIC(20,0),
    mail VARCHAR(255),
    fechaNacimiento DATE 
);

CREATE TABLE compradores(
    idComprador INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    dni NUMERIC(8,0),
    fechaRegistro DATETIME,
    telefono NUMERIC(20,0),
    mail VARCHAR(100),
    fechaNacimiento DATE
)

CREATE TABLE periodos (
    periodo_id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    nroPeriodo INT,
    fechaInicioPeriodo DATE,
    fechaFinPeriodo DATE
);

CREATE TABLE direcciones (
    codigoDireccion INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    direccion VARCHAR(100),
    localidad_id INT,
    provincia_id INT,
    barrio_id INT,
    FOREIGN KEY (localidad_id) REFERENCES localidades (localidad_id),
    FOREIGN KEY (provincia_id) REFERENCES provincias (provincia_id),
    FOREIGN KEY (barrio_id) REFERENCES barrios (barrio_id)
);

CREATE TABLE sucursales (
    codigoSucursal INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    nombre VARCHAR(100),
    direccion_id INT,
    telefono NUMERIC(20,0),
    FOREIGN KEY (direccion_id) REFERENCES direcciones (codigoDireccion)
);

CREATE TABLE agentes (
    idAgente INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    dni NUMERIC(8,0),
    fechaRegistro DATETIME,
    telefono NUMERIC(20,0),
    mail VARCHAR(100),
    fechaNacimiento DATE,
    sucursal_id INT,
    FOREIGN KEY (sucursal_id) REFERENCES sucursales (codigoSucursal)
);

CREATE TABLE inmuebles(
    nroInmueble INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    descripcion VARCHAR(100),
    superficieTotal NUMERIC(10,2),
    antiguedad NUMERIC(10,2),
    expensas NUMERIC(10,2),
	tipoInmueble INT NOT NULL,
	propietario_id INT NOT NULL,
	direccion_id INT NOT NULL,
	ambientes_id NUMERIC(2,0) NOT NULL,
	disposicion_id INT NOT NULL,
	orientacion_id INT NOT NULL,
	estado_id INT NOT NULL,
    FOREIGN KEY (tipoInmueble) REFERENCES tiposInmuebles(tipoInmueble),
    FOREIGN KEY(propietario_id) REFERENCES propietarios (idPropietario),
    FOREIGN KEY(direccion_id) REFERENCES direcciones (codigoDireccion),
    FOREIGN KEY (ambientes_id) REFERENCES cantAmbientes (cantidad),
    FOREIGN KEY(disposicion_id) REFERENCES disposiciones (disposicion_id),
    FOREIGN KEY(orientacion_id) REFERENCES orientaciones (orientacion_id),
    FOREIGN KEY(estado_id) REFERENCES estados (estado_id)
);

CREATE TABLE inquilinos (
    idInquilino INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    dni NUMERIC(8,0),
    fechaRegistro DATETIME,
    telefono NUMERIC(20,0),
    mail VARCHAR(100),
    fechaNacimiento DATE
);

CREATE TABLE anuncios (
    nroAnuncio INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    fechaPublicacion DATE,
    agente_id INT NOT NULL,
    tipoOperacion_id INT NOT NULL,
    precio NUMERIC(10,2),
    moneda_id VARCHAR(3),
    periodo_id INT NOT NULL,
    estado VARCHAR(100),
    fechaFinalizacion DATE, 
    costoDePublicacion NUMERIC(10,2),
    inmueble_id INT NOT NULL,
    FOREIGN KEY (agente_id) REFERENCES agentes (idAgente),
    FOREIGN KEY (tipoOperacion_id) REFERENCES tipoOperacion (tipoOperacion_id),
    FOREIGN KEY (moneda_id) REFERENCES monedas (moneda_id),
    FOREIGN KEY (periodo_id) REFERENCES tiposPeriodos (periodo_id),
    FOREIGN KEY (inmueble_id) REFERENCES inmuebles (nroInmueble)
);

CREATE TABLE alquileres (
    codigoAlquiler INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    anuncio_id INT NOT NULL,
    inquilino_id INT,
    fechaInicio DATETIME,
    fechaFin DATETIME,
    duracion INT,
    importe_id INT,
    deposito NUMERIC(20,2),
    comision NUMERIC(20,2),
    gastosAveriguaciones NUMERIC(10,2),
    estado INT NOT NULL,
    FOREIGN KEY (anuncio_id) REFERENCES anuncios (nroAnuncio),
    FOREIGN KEY (inquilino_id) REFERENCES inquilinos (idInquilino),
    FOREIGN KEY (estado) REFERENCES estadosAlquileres (estado_id)
);

CREATE TABLE importes (
    idImporte INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    alquiler_id INT NOT NULL,
    nroPeriodoInicio NUMERIC(2,0),
    nroPeriodoFin NUMERIC(2,0),
    precio NUMERIC (20,2),
    FOREIGN KEY (alquiler_id) REFERENCES alquileres(codigoAlquiler)
);

CREATE TABLE ventas(
    codigoVenta INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    anuncio_id INT NOT NULL,
    comprador_id INT NOT NULL,
    fechaVenta DATETIME,
    precioFinal NUMERIC(20,2),
    moneda_id VARCHAR(3) NOT NULL,
    comisionInmobiliaria NUMERIC(20,2),
    FOREIGN KEY (anuncio_id) REFERENCES anuncios (nroAnuncio),
    FOREIGN KEY (comprador_id) REFERENCES compradores (idComprador),
    FOREIGN KEY (moneda_id )REFERENCES monedas (moneda_id)
);

CREATE TABLE pagosVentas (
    codigoPagoVenta INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    venta_id INT,
    importe NUMERIC(8,2),
    moneda VARCHAR(3),
    cotizacion NUMERIC(8,2),
    medioDePago INT, 
    FOREIGN KEY (venta_id) REFERENCES ventas (codigoVenta),
    FOREIGN KEY (moneda) REFERENCES monedas (moneda_id),
    FOREIGN KEY (medioDePago) REFERENCES mediosDePagos (medioDePago_id)    
);

CREATE TABLE caracteristicas_inmuebles (
    nroInmueble INT NOT NULL,
    idCaracteristica INT NOT NULL,
    PRIMARY KEY (nroInmueble, idCaracteristica),
    FOREIGN KEY (nroInmueble) REFERENCES inmuebles (nroInmueble),
    FOREIGN KEY (idCaracteristica) REFERENCES caracteristicas (idCaracteristica)
);

CREATE TABLE pagosAlquileres(
    codigoPago INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    alquiler_id INT NOT NULL,
    fechaPago DATETIME,
    importe NUMERIC(20,2),
    medioDePago INT NOT NULL,
    periodo_id INT NOT NULL,
    FOREIGN KEY (alquiler_id) REFERENCES alquileres (codigoAlquiler),
    FOREIGN KEY (medioDePago) REFERENCES mediosDePagos (medioDePago_id),
    FOREIGN KEY (periodo_id) REFERENCES periodos(periodo_id),
);
