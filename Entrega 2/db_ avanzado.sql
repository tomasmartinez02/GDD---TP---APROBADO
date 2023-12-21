USE GD2C2023

GO

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'GRUPO_1')
BEGIN 
	EXEC ('CREATE SCHEMA GRUPO_1')
END

GO

---------------------------
-- ELIMINACION DE TABLAS --
---------------------------

IF OBJECT_ID('GRUPO_1.Obtener_id_caracteristica', 'FN') IS NOT NULL DROP FUNCTION GRUPO_1.Obtener_id_caracteristica;
IF OBJECT_ID('GRUPO_1.ConvertirMoneda', 'FN') IS NOT NULL DROP FUNCTION GRUPO_1.ConvertirMoneda;
IF OBJECT_ID('GRUPO_1.pagosAlquileres', 'U') IS NOT NULL DROP TABLE GRUPO_1.pagosAlquileres;
IF OBJECT_ID('GRUPO_1.caracteristicas_inmuebles', 'U') IS NOT NULL DROP TABLE GRUPO_1.caracteristicas_inmuebles;
IF OBJECT_ID('GRUPO_1.pagosVentas', 'U') IS NOT NULL DROP TABLE GRUPO_1.pagosVentas;
IF OBJECT_ID('GRUPO_1.ventas', 'U') IS NOT NULL DROP TABLE GRUPO_1.ventas;
IF OBJECT_ID('GRUPO_1.importes', 'U') IS NOT NULL DROP TABLE GRUPO_1.importes;
IF OBJECT_ID('GRUPO_1.alquileres', 'U') IS NOT NULL DROP TABLE GRUPO_1.alquileres;
IF OBJECT_ID('GRUPO_1.anuncios', 'U') IS NOT NULL DROP TABLE GRUPO_1.anuncios;
IF OBJECT_ID('GRUPO_1.inquilinos', 'U') IS NOT NULL DROP TABLE GRUPO_1.inquilinos;
IF OBJECT_ID('GRUPO_1.inmuebles', 'U') IS NOT NULL DROP TABLE GRUPO_1.inmuebles;
IF OBJECT_ID('GRUPO_1.agentes', 'U') IS NOT NULL DROP TABLE GRUPO_1.agentes;
IF OBJECT_ID('GRUPO_1.sucursales', 'U') IS NOT NULL DROP TABLE GRUPO_1.sucursales;
IF OBJECT_ID('GRUPO_1.direcciones', 'U') IS NOT NULL DROP TABLE GRUPO_1.direcciones;
IF OBJECT_ID('GRUPO_1.periodos', 'U') IS NOT NULL DROP TABLE GRUPO_1.periodos;
IF OBJECT_ID('GRUPO_1.compradores', 'U') IS NOT NULL DROP TABLE GRUPO_1.compradores;
IF OBJECT_ID('GRUPO_1.propietarios', 'U') IS NOT NULL DROP TABLE GRUPO_1.propietarios;
IF OBJECT_ID('GRUPO_1.monedas', 'U') IS NOT NULL DROP TABLE GRUPO_1.monedas;
IF OBJECT_ID('GRUPO_1.cantAmbientes', 'U') IS NOT NULL DROP TABLE GRUPO_1.cantAmbientes;
IF OBJECT_ID('GRUPO_1.provincias', 'U') IS NOT NULL DROP TABLE GRUPO_1.provincias;
IF OBJECT_ID('GRUPO_1.localidades', 'U') IS NOT NULL DROP TABLE GRUPO_1.localidades;
IF OBJECT_ID('GRUPO_1.barrios', 'U') IS NOT NULL DROP TABLE GRUPO_1.barrios;
IF OBJECT_ID('GRUPO_1.tipoOperacion', 'U') IS NOT NULL DROP TABLE GRUPO_1.tipoOperacion;
IF OBJECT_ID('GRUPO_1.tiposInmuebles', 'U') IS NOT NULL DROP TABLE GRUPO_1.tiposInmuebles;
IF OBJECT_ID('GRUPO_1.mediosDePagos', 'U') IS NOT NULL DROP TABLE GRUPO_1.mediosDePagos;
IF OBJECT_ID('GRUPO_1.estadosAlquileres', 'U') IS NOT NULL DROP TABLE GRUPO_1.estadosAlquileres;
IF OBJECT_ID('GRUPO_1.tiposPeriodos', 'U') IS NOT NULL DROP TABLE GRUPO_1.tiposPeriodos;
IF OBJECT_ID('GRUPO_1.caracteristicas', 'U') IS NOT NULL DROP TABLE GRUPO_1.caracteristicas;
IF OBJECT_ID('GRUPO_1.orientaciones', 'U') IS NOT NULL DROP TABLE GRUPO_1.orientaciones;
IF OBJECT_ID('GRUPO_1.estados', 'U') IS NOT NULL DROP TABLE GRUPO_1.estados;
IF OBJECT_ID('GRUPO_1.disposiciones', 'U') IS NOT NULL DROP TABLE GRUPO_1.disposiciones;

----------------------------
---- CREACION DE TABLAS ----
----------------------------

CREATE TABLE GRUPO_1.disposiciones (
    disposicion_id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    disposicion VARCHAR(100) NOT NULL
);

CREATE TABLE GRUPO_1.estados (
    estado_id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    estado VARCHAR(100) NOT NULL
);

CREATE TABLE GRUPO_1.orientaciones (
    orientacion_id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    orientacion VARCHAR(100) NOT NULL
);

CREATE TABLE GRUPO_1.caracteristicas (
    idCaracteristica INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE GRUPO_1.tiposPeriodos (
    periodo_id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    periodo VARCHAR(100) NOT NULL
);

CREATE TABLE GRUPO_1.estadosAlquileres (
    estado_id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    estado VARCHAR(100) NOT NULL
);

CREATE TABLE GRUPO_1.mediosDePagos (
    medioDePago_id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    medio VARCHAR(100) NOT NULL
);

CREATE TABLE GRUPO_1.tiposInmuebles (
    tipoInmueble INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE GRUPO_1.tipoOperacion (
    tipoOperacion_id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    tipo VARCHAR(100) NOT NULL
);

CREATE TABLE GRUPO_1.barrios (
    barrio_id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE GRUPO_1.localidades (
    localidad_id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    nombre VARCHAR(100) NOT NULL 
);

CREATE TABLE GRUPO_1.provincias (
    provincia_id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    nombre VARCHAR(100) NOT NULL 
);

CREATE TABLE GRUPO_1.cantAmbientes (
    id_ambientes INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    descripcion VARCHAR(100)
);

CREATE TABLE GRUPO_1.monedas (
    moneda_id VARCHAR(3) NOT NULL PRIMARY KEY
);

CREATE TABLE GRUPO_1.propietarios (
    idPropietario INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    dni NUMERIC(8,0),
    fechaRegistro DATE,
    telefono NUMERIC(20,0),
    mail VARCHAR(255),
    fechaNacimiento DATE 
);

CREATE TABLE GRUPO_1.compradores (
    idComprador INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    dni NUMERIC(8,0),
    fechaRegistro DATETIME,
    telefono NUMERIC(20,0),
    mail VARCHAR(100),
    fechaNacimiento DATE
);

CREATE TABLE GRUPO_1.periodos (
    periodo_id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    nroPeriodo INT,
    fechaInicioPeriodo DATE,
    fechaFinPeriodo DATE
);

CREATE TABLE GRUPO_1.direcciones (
    codigoDireccion INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    direccion VARCHAR(100),
    localidad_id INT,
    provincia_id INT,
    barrio_id INT,
    FOREIGN KEY (localidad_id) REFERENCES GRUPO_1.localidades (localidad_id),
    FOREIGN KEY (provincia_id) REFERENCES GRUPO_1.provincias (provincia_id),
    FOREIGN KEY (barrio_id) REFERENCES GRUPO_1.barrios (barrio_id)
);

CREATE TABLE GRUPO_1.sucursales (
	sucursal_id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    codigoSucursal INT,
    nombre VARCHAR(100),
    direccion_id INT,
    telefono NUMERIC(20,0),
    FOREIGN KEY (direccion_id) REFERENCES GRUPO_1.direcciones (codigoDireccion)
);

CREATE TABLE GRUPO_1.agentes (
    idAgente INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    dni NUMERIC(8,0),
    fechaRegistro DATETIME,
    telefono NUMERIC(20,0),
    mail VARCHAR(100),
    fechaNacimiento DATE,
    sucursal_id INT,
    FOREIGN KEY (sucursal_id) REFERENCES GRUPO_1.sucursales (sucursal_id)
);

CREATE TABLE GRUPO_1.inmuebles (
    id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    nroInmueble INT,
	nombre VARCHAR(100),
    descripcion VARCHAR(100),
    superficieTotal NUMERIC(10,2),
    antiguedad NUMERIC(10,2),
    expensas NUMERIC(10,2),
	tipoInmueble INT NOT NULL,
	propietario_id INT NOT NULL,
	direccion_id INT NOT NULL,
	ambientes_id INT NOT NULL,
	disposicion_id INT NOT NULL,
	orientacion_id INT NOT NULL,
	estado_id INT NOT NULL,
    FOREIGN KEY (tipoInmueble) REFERENCES GRUPO_1.tiposInmuebles(tipoInmueble),
    FOREIGN KEY(propietario_id) REFERENCES GRUPO_1.propietarios (idPropietario),
    FOREIGN KEY(direccion_id) REFERENCES GRUPO_1.direcciones (codigoDireccion),
    FOREIGN KEY (ambientes_id) REFERENCES GRUPO_1.cantAmbientes (id_ambientes),
    FOREIGN KEY(disposicion_id) REFERENCES GRUPO_1.disposiciones (disposicion_id),
    FOREIGN KEY(orientacion_id) REFERENCES GRUPO_1.orientaciones (orientacion_id),
    FOREIGN KEY(estado_id) REFERENCES GRUPO_1.estados (estado_id)
);

CREATE TABLE GRUPO_1.inquilinos (
    idInquilino INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    dni NUMERIC(8,0),
    fechaRegistro DATETIME,
    telefono NUMERIC(20,0),
    mail VARCHAR(100),
    fechaNacimiento DATE
);

CREATE TABLE GRUPO_1.anuncios (
    idAnuncio INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    nroAnuncio INT NOT NULL,
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
    FOREIGN KEY (agente_id) REFERENCES GRUPO_1.agentes (idAgente),
    FOREIGN KEY (tipoOperacion_id) REFERENCES GRUPO_1.tipoOperacion (tipoOperacion_id),
    FOREIGN KEY (moneda_id) REFERENCES GRUPO_1.monedas (moneda_id),
    FOREIGN KEY (periodo_id) REFERENCES GRUPO_1.tiposPeriodos (periodo_id),
    FOREIGN KEY (inmueble_id) REFERENCES GRUPO_1.inmuebles (id)
);

CREATE TABLE GRUPO_1.alquileres (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    codigoAlquiler INT,
    anuncio_id INT NOT NULL,
    inquilino_id INT,
    fechaInicio DATETIME,
    fechaFin DATETIME,
    duracion INT,
    deposito NUMERIC(20,2),
    comision NUMERIC(20,2),
    gastosAveriguaciones NUMERIC(10,2),
    estado INT NOT NULL,
    FOREIGN KEY (anuncio_id) REFERENCES GRUPO_1.anuncios (idAnuncio),
    FOREIGN KEY (inquilino_id) REFERENCES GRUPO_1.inquilinos (idInquilino),
    FOREIGN KEY (estado) REFERENCES GRUPO_1.estadosAlquileres (estado_id)
);

CREATE TABLE GRUPO_1.importes (
    idImporte INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    alquiler_id INT NOT NULL,
    nroPeriodoInicio NUMERIC(2,0),
    nroPeriodoFin NUMERIC(2,0),
    precio NUMERIC (20,2),
    FOREIGN KEY (alquiler_id) REFERENCES GRUPO_1.alquileres(id)
);

CREATE TABLE GRUPO_1.ventas (
    idVenta INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    codigoVenta INT,
    anuncio_id INT NOT NULL,
    comprador_id INT NOT NULL,
    fechaVenta DATETIME,
    precioFinal NUMERIC(20,2),
    moneda_id VARCHAR(3) NOT NULL,
    comisionInmobiliaria NUMERIC(20,2),
    FOREIGN KEY (anuncio_id) REFERENCES GRUPO_1.anuncios (idAnuncio),
    FOREIGN KEY (comprador_id) REFERENCES GRUPO_1.compradores (idComprador),
    FOREIGN KEY (moneda_id )REFERENCES GRUPO_1.monedas (moneda_id)
);

CREATE TABLE GRUPO_1.pagosVentas (
    codigoPagoVenta INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    venta_id INT,
    importe NUMERIC(8,2),
    moneda VARCHAR(3),
    cotizacion NUMERIC(8,2),
    medioDePago INT, 
    FOREIGN KEY (venta_id) REFERENCES GRUPO_1.ventas (idVenta),
    FOREIGN KEY (moneda) REFERENCES GRUPO_1.monedas (moneda_id),
    FOREIGN KEY (medioDePago) REFERENCES GRUPO_1.mediosDePagos (medioDePago_id)    
);

CREATE TABLE GRUPO_1.caracteristicas_inmuebles (
    nroInmueble INT NOT NULL,
    idCaracteristica INT NOT NULL,
    PRIMARY KEY (nroInmueble, idCaracteristica),
    FOREIGN KEY (nroInmueble) REFERENCES GRUPO_1.inmuebles (id),
    FOREIGN KEY (idCaracteristica) REFERENCES GRUPO_1.caracteristicas (idCaracteristica)
);

CREATE TABLE GRUPO_1.pagosAlquileres (
    codigoPago INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    pagoAlquilerCodigo INT,
    alquiler_id INT NOT NULL,
    fechaPago DATETIME,
    fechaVencimiento DATETIME,
    descripcion VARCHAR(100),
    importe NUMERIC(20,2),
    medioDePago INT NOT NULL,
    periodo_id INT NOT NULL,
    FOREIGN KEY (alquiler_id) REFERENCES GRUPO_1.alquileres (id),
    FOREIGN KEY (medioDePago) REFERENCES GRUPO_1.mediosDePagos (medioDePago_id),
    FOREIGN KEY (periodo_id) REFERENCES GRUPO_1.periodos(periodo_id),
);

-----------------------------
--------- FUNCIONES ---------
-----------------------------

CREATE FUNCTION GRUPO_1.ConvertirMoneda(@moneda VARCHAR(100))
RETURNS VARCHAR(3)
AS
BEGIN
    DECLARE @resultado VARCHAR(3);

    IF @moneda = 'Moneda Pesos'
    BEGIN
        SET @resultado = 'ARG';
    END
    ELSE IF @moneda = 'Moneda Dolares'
    BEGIN
        SET @resultado = 'USD';
    END
    ELSE
    BEGIN
        SET @resultado = NULL; -- Manejar otro caso si es necesario
    END

    RETURN @resultado;
END;

CREATE FUNCTION GRUPO_1.obtener_id_caracteristica(@caracteristica VARCHAR(100))
RETURNS INT
AS
BEGIN 
    DECLARE @caracteristicaId INT;

    SELECT @caracteristicaId = idCaracteristica FROM GRUPO_1.caracteristicas
    WHERE nombre = @caracteristica;

    RETURN @caracteristicaId;
END;

-------------------------------------
-------- MIGRACION DE DATOS ---------
-------------------------------------

CREATE PROCEDURE GRUPO_1.migrar_Disposiciones AS
BEGIN
    INSERT INTO GRUPO_1.disposiciones (disposicion)
    SELECT DISTINCT INMUEBLE_DISPOSICION
    FROM gd_esquema.Maestra
    WHERE INMUEBLE_DISPOSICION IS NOT NULL;
END
GO

CREATE PROCEDURE GRUPO_1.migrar_Estados AS
BEGIN
    INSERT INTO GRUPO_1.estados (estado)
    SELECT DISTINCT INMUEBLE_ESTADO
    FROM gd_esquema.Maestra
    WHERE INMUEBLE_ESTADO IS NOT NULL;
END
GO

CREATE PROCEDURE GRUPO_1.migrar_Orientaciones AS
BEGIN
    INSERT INTO GRUPO_1.orientaciones (orientacion)
    SELECT DISTINCT INMUEBLE_ORIENTACION
    FROM gd_esquema.Maestra
    WHERE INMUEBLE_ORIENTACION IS NOT NULL;
END
GO

CREATE PROCEDURE GRUPO_1.migrar_Caracteristicas AS
BEGIN
INSERT INTO GRUPO_1.caracteristicas (nombre)
VALUES
    ('Wifi'),
    ('Cable'),
    ('Calefacción'),
    ('Gas');
END
GO

CREATE PROCEDURE GRUPO_1.migrar_TiposPeriodos AS
BEGIN
    INSERT INTO GRUPO_1.tiposPeriodos (periodo)
    SELECT DISTINCT ANUNCIO_TIPO_PERIODO
    FROM gd_esquema.Maestra
    WHERE ANUNCIO_TIPO_PERIODO IS NOT NULL;
END
GO
 
CREATE PROCEDURE GRUPO_1.migrar_EstadosAlquileres AS
BEGIN
    INSERT INTO GRUPO_1.estadosAlquileres (estado)
    SELECT DISTINCT ALQUILER_ESTADO
    FROM gd_esquema.Maestra
    WHERE ALQUILER_ESTADO IS NOT NULL;
END
GO

CREATE PROCEDURE GRUPO_1.migrar_MediosDePago AS
BEGIN
    INSERT INTO GRUPO_1.mediosDePagos (medio)
    SELECT DISTINCT PAGO_ALQUILER_MEDIO_PAGO
    FROM gd_esquema.Maestra
    WHERE PAGO_ALQUILER_CODIGO IS NOT NULL;
END
GO

CREATE PROCEDURE GRUPO_1.migrar_TiposInmuebles AS
BEGIN
    INSERT INTO GRUPO_1.tiposInmuebles (nombre)
    SELECT DISTINCT INMUEBLE_TIPO_INMUEBLE
    FROM gd_esquema.Maestra
    WHERE INMUEBLE_TIPO_INMUEBLE IS NOT NULL;
END
GO

CREATE PROCEDURE GRUPO_1.migrar_TipoOperaciones AS
BEGIN
    INSERT INTO GRUPO_1.tipoOperacion (tipo)
    SELECT DISTINCT ANUNCIO_TIPO_OPERACION
    FROM gd_esquema.Maestra
    WHERE ANUNCIO_TIPO_OPERACION IS NOT NULL;
END
GO

CREATE PROCEDURE GRUPO_1.migrar_Compradores AS
BEGIN
    INSERT INTO GRUPO_1.compradores (nombre, apellido, dni, fechaRegistro, telefono, mail, fechaNacimiento)
    SELECT DISTINCT COMPRADOR_NOMBRE, COMPRADOR_APELLIDO, COMPRADOR_DNI, COMPRADOR_FECHA_REGISTRO, COMPRADOR_TELEFONO, COMPRADOR_MAIL, COMPRADOR_FECHA_NAC
    FROM gd_esquema.Maestra
    WHERE COMPRADOR_NOMBRE IS NOT NULL;
END
GO

CREATE PROCEDURE GRUPO_1.migrar_Periodos AS
BEGIN
    INSERT INTO GRUPO_1.periodos (nroPeriodo, fechaInicioPeriodo, fechaFinPeriodo)
    SELECT DISTINCT PAGO_ALQUILER_NRO_PERIODO, ALQUILER_FECHA_INICIO, ALQUILER_FECHA_FIN
    FROM gd_esquema.Maestra
    WHERE PAGO_ALQUILER_CODIGO IS NOT NULL;
END
GO

CREATE PROCEDURE GRUPO_1.migrar_Monedas AS
BEGIN
    INSERT INTO GRUPO_1.monedas
    SELECT DISTINCT GRUPO_1.ConvertirMoneda(ANUNCIO_MONEDA)
    FROM gd_esquema.Maestra
    WHERE ANUNCIO_MONEDA IS NOT NULL;
END
GO

CREATE PROCEDURE GRUPO_1.migrar_CantAmbientes AS
BEGIN
    INSERT INTO GRUPO_1.cantAmbientes (descripcion)
    SELECT DISTINCT INMUEBLE_CANT_AMBIENTES
    FROM gd_esquema.Maestra
    WHERE INMUEBLE_CANT_AMBIENTES IS NOT NULL;
END
GO

CREATE PROCEDURE GRUPO_1.migrar_Inquilinos AS
BEGIN
    INSERT INTO GRUPO_1.inquilinos (nombre, apellido, dni, fechaRegistro, telefono, mail, fechaNacimiento)
    SELECT DISTINCT INQUILINO_NOMBRE, INQUILINO_APELLIDO, INQUILINO_DNI, INQUILINO_FECHA_REGISTRO, INQUILINO_TELEFONO, INQUILINO_MAIL, INQUILINO_FECHA_NAC
    FROM gd_esquema.Maestra
    WHERE INQUILINO_NOMBRE IS NOT NULL;
END
GO

CREATE PROCEDURE GRUPO_1.migrar_Localidades AS
BEGIN
    INSERT INTO GRUPO_1.localidades (nombre)
    SELECT DISTINCT localidad
    FROM (
        SELECT INMUEBLE_LOCALIDAD AS localidad
        FROM gd_esquema.Maestra
        WHERE INMUEBLE_LOCALIDAD IS NOT NULL
        UNION
        SELECT SUCURSAL_LOCALIDAD AS localidad
        FROM gd_esquema.Maestra
        WHERE SUCURSAL_LOCALIDAD IS NOT NULL
    ) AS localidades;
END
GO

CREATE PROCEDURE GRUPO_1.migrar_Provincias AS
BEGIN
INSERT INTO GRUPO_1.provincias (nombre)
    SELECT DISTINCT provincia
    FROM (
        SELECT INMUEBLE_PROVINCIA AS provincia
        FROM gd_esquema.Maestra
        WHERE INMUEBLE_PROVINCIA IS NOT NULL
        UNION
        SELECT SUCURSAL_PROVINCIA AS provincia
        FROM gd_esquema.Maestra
        WHERE SUCURSAL_PROVINCIA IS NOT NULL
    ) AS provincias;
END
GO

CREATE PROCEDURE GRUPO_1.migrar_Barrios AS
BEGIN
    INSERT INTO GRUPO_1.barrios (nombre)
    SELECT DISTINCT INMUEBLE_BARRIO
    FROM gd_esquema.Maestra
    WHERE INMUEBLE_BARRIO IS NOT NULL;
END
GO

CREATE PROCEDURE GRUPO_1.migrar_Propietarios AS
BEGIN
    INSERT INTO GRUPO_1.propietarios (nombre, apellido, dni, fechaRegistro, telefono, mail, fechaNacimiento)
    SELECT DISTINCT PROPIETARIO_NOMBRE, PROPIETARIO_APELLIDO, PROPIETARIO_DNI, PROPIETARIO_FECHA_REGISTRO, PROPIETARIO_TELEFONO, PROPIETARIO_MAIL,PROPIETARIO_FECHA_NAC
    FROM gd_esquema.Maestra
    WHERE PROPIETARIO_NOMBRE IS NOT NULL;
END 
GO

CREATE PROCEDURE GRUPO_1.migrar_Direcciones AS
BEGIN
    INSERT INTO GRUPO_1.direcciones (direccion, localidad_id, provincia_id, barrio_id)
    SELECT DISTINCT M.INMUEBLE_DIRECCION, l.localidad_id, p.provincia_id, b.barrio_id
    FROM gd_esquema.Maestra M 
    JOIN GRUPO_1.localidades l ON M.INMUEBLE_LOCALIDAD = l.nombre
    JOIN GRUPO_1.provincias p ON M.INMUEBLE_PROVINCIA = p.nombre
    JOIN GRUPO_1.barrios b ON M.INMUEBLE_BARRIO = b.nombre
    WHERE INMUEBLE_DIRECCION IS NOT NULL
    UNION
    SELECT DISTINCT M.SUCURSAL_DIRECCION, l.localidad_id, p.provincia_id, NULL
    FROM gd_esquema.Maestra M 
    JOIN GRUPO_1.localidades l ON M.SUCURSAL_LOCALIDAD = l.nombre
    JOIN GRUPO_1.provincias p ON M.SUCURSAL_PROVINCIA = p.nombre
    WHERE SUCURSAL_DIRECCION IS NOT NULL;
END
GO

CREATE PROCEDURE GRUPO_1.migrar_Agentes AS
BEGIN
    INSERT INTO GRUPO_1.agentes (nombre, apellido, dni, fechaRegistro, telefono, mail, fechaNacimiento, sucursal_id)
    SELECT DISTINCT AGENTE_NOMBRE, AGENTE_APELLIDO, AGENTE_DNI, AGENTE_FECHA_REGISTRO, AGENTE_TELEFONO, AGENTE_MAIL, AGENTE_FECHA_NAC, s.sucursal_id
    FROM gd_esquema.Maestra m JOIN sucursales s ON m.SUCURSAL_CODIGO = s.codigoSucursal
    WHERE AGENTE_NOMBRE IS NOT NULL;
END
GO

CREATE PROCEDURE GRUPO_1.migrar_Sucursales AS
BEGIN
    INSERT INTO GRUPO_1.sucursales(codigoSucursal, nombre, direccion_id, telefono)
    SELECT DISTINCT SUCURSAL_CODIGO, SUCURSAL_NOMBRE, d.codigoDireccion, SUCURSAL_TELEFONO
    FROM gd_esquema.Maestra m JOIN direcciones d ON m.SUCURSAL_DIRECCION = d.direccion
    WHERE SUCURSAL_NOMBRE IS NOT NULL;
END
GO

CREATE PROCEDURE GRUPO_1.migrar_Alquileres AS
BEGIN
    INSERT INTO GRUPO_1.alquileres (codigoAlquiler ,anuncio_id, inquilino_id, fechaInicio, fechaFin, duracion,  
    deposito, comision, gastosAveriguaciones, estado)
    SELECT DISTINCT M.ALQUILER_CODIGO, a.idAnuncio, i.idInquilino, M.ALQUILER_FECHA_INICIO, M.ALQUILER_FECHA_FIN, M.ALQUILER_CANT_PERIODOS,
    M.ALQUILER_DEPOSITO, M.ALQUILER_COMISION, M.ALQUILER_GASTOS_AVERIGUA, e.estado_id
    FROM gd_esquema.Maestra M 
    JOIN GRUPO_1.anuncios a ON a.nroAnuncio = M.ANUNCIO_CODIGO
    JOIN GRUPO_1.inquilinos i ON i.dni = M.INQUILINO_DNI
    JOIN GRUPO_1.estadosAlquileres e ON e.estado = M.ALQUILER_ESTADO
    WHERE M.ALQUILER_CODIGO IS NOT NULL;
END 
GO

CREATE PROCEDURE GRUPO_1.migrar_Importes AS
BEGIN 
    INSERT INTO GRUPO_1.importes (alquiler_id, nroPeriodoInicio, nroPeriodoFin, precio)
    SELECT m.ALQUILER_CODIGO, DETALLE_ALQ_NRO_PERIODO_INI, DETALLE_ALQ_NRO_PERIODO_FIN, DETALLE_ALQ_PRECIO
    FROM gd_esquema.Maestra m JOIN alquileres a on m.ALQUILER_CODIGO = a.codigoAlquiler
    WHERE m.ALQUILER_CODIGO IS NOT NULL;
END 
GO

CREATE PROCEDURE GRUPO_1.migrar_Anuncios AS
BEGIN
    INSERT INTO GRUPO_1.anuncios (nroAnuncio, fechaPublicacion, agente_id, tipoOperacion_id, precio, moneda_id, periodo_id, estado, fechaFinalizacion, costoDePublicacion, inmueble_id)
    SELECT DISTINCT M.ANUNCIO_CODIGO, m.ANUNCIO_FECHA_PUBLICACION, a.idAgente, t.tipoOperacion_id, m.ANUNCIO_PRECIO_PUBLICADO, mnd.moneda_id, p.periodo_id, m.ANUNCIO_ESTADO, m.ANUNCIO_FECHA_FINALIZACION, m.ANUNCIO_COSTO_ANUNCIO, i.id
    FROM gd_esquema.Maestra m
    JOIN GRUPO_1.agentes a ON a.dni = m.AGENTE_DNI
    JOIN GRUPO_1.tipoOperacion t ON t.tipo = m.ANUNCIO_TIPO_OPERACION
    JOIN GRUPO_1.monedas mnd ON mnd.moneda_id = GRUPO_1.ConvertirMoneda(m.ANUNCIO_MONEDA)
    JOIN GRUPO_1.tiposPeriodos p ON p.periodo = m.ANUNCIO_TIPO_PERIODO
    JOIN GRUPO_1.inmuebles i ON i.nroInmueble = m.INMUEBLE_CODIGO
    WHERE M.ANUNCIO_CODIGO IS NOT NULL;
END
GO

CREATE PROCEDURE GRUPO_1.migrar_Ventas AS
BEGIN
    INSERT INTO GRUPO_1.ventas (codigoVenta, anuncio_id, comprador_id, fechaVenta, precioFinal, moneda_id, comisionInmobiliaria)
    SELECT DISTINCT M.VENTA_CODIGO, a.idAnuncio, c.idComprador, M.VENTA_FECHA, M.VENTA_PRECIO_VENTA, GRUPO_1.ConvertirMoneda(M.VENTA_MONEDA), M.VENTA_COMISION
    FROM gd_esquema.Maestra M 
    JOIN GRUPO_1.anuncios a ON a.nroAnuncio = M.ANUNCIO_CODIGO
    JOIN GRUPO_1.compradores c ON c.dni = M.COMPRADOR_DNI
    WHERE M.VENTA_CODIGO IS NOT NULL;
END
GO

CREATE PROCEDURE GRUPO_1.migrar_PagosAlquileres AS
BEGIN
    INSERT INTO GRUPO_1.pagosAlquileres (pagoAlquilerCodigo, alquiler_id, fechaPago, fechaVencimiento, descripcion, importe, medioDePago, periodo_id)
    SELECT M.PAGO_ALQUILER_CODIGO, a.id, M.PAGO_ALQUILER_FECHA, M.PAGO_ALQUILER_FECHA_VENCIMIENTO, M.PAGO_ALQUILER_DESC , M.PAGO_ALQUILER_IMPORTE, me.medio, p.periodo_id
    FROM gd_esquema.Maestra M
    JOIN GRUPO_1.alquileres a ON M.ALQUILER_CODIGO = a.codigoAlquiler
    JOIN GRUPO_1.mediosDePagos me ON M.PAGO_ALQUILER_MEDIO_PAGO = me.medioDePago_id
    JOIN GRUPO_1.periodos p ON (M.PAGO_ALQUILER_NRO_PERIODO = p.nroPeriodo AND M.PAGO_ALQUILER_FEC_INI = p.fechaInicioPeriodo AND M.PAGO_ALQUILER_FEC_FIN = p.fechaFinPeriodo)
    WHERE M.PAGO_ALQUILER_CODIGO IS NOT NULL;
END
GO

CREATE PROCEDURE GRUPO_1.migrar_Inmuebles AS
BEGIN
    INSERT INTO GRUPO_1.inmuebles (nroInmueble, nombre, descripcion, superficieTotal, antiguedad, expensas, tipoInmueble, propietario_id, direccion_id, ambientes_id, disposicion_id, orientacion_id, estado_id)
    SELECT DISTINCT M.INMUEBLE_CODIGO, M.INMUEBLE_NOMBRE, M.INMUEBLE_DESCRIPCION, M.INMUEBLE_SUPERFICIETOTAL, M.INMUEBLE_ANTIGUEDAD, M.INMUEBLE_EXPESAS, t.tipoInmueble, p.idPropietario, dd.codigoDireccion, c.id_ambientes, d.disposicion_id, o.orientacion_id, e.estado_id
    FROM gd_esquema.Maestra M
    JOIN GRUPO_1.tiposInmuebles t ON M.INMUEBLE_TIPO_INMUEBLE = t.nombre
    JOIN GRUPO_1.propietarios p ON M.PROPIETARIO_DNI = p.dni
    JOIN GRUPO_1.direcciones dd ON  M.INMUEBLE_DIRECCION = dd.direccion
    JOIN GRUPO_1.cantAmbientes c ON  M.INMUEBLE_CANT_AMBIENTES = c.descripcion
    JOIN GRUPO_1.disposiciones d ON M.INMUEBLE_DISPOSICION = d.disposicion
    JOIN GRUPO_1.orientaciones o ON M.INMUEBLE_ORIENTACION = o.orientacion
    JOIN GRUPO_1.estados e ON M.INMUEBLE_ESTADO = e.estado
    WHERE M.INMUEBLE_CODIGO IS NOT NULL;
END
GO

CREATE PROCEDURE GRUPO_1.migrar_Caracteristicas_Inmuebles AS
BEGIN
    INSERT INTO GRUPO_1.caracteristicas_inmuebles (nroInmueble, idCaracteristica)
    SELECT i.id, GRUPO_1.obtener_id_caracteristica('Wifi')
    FROM gd_esquema.Maestra M 
    JOIN GRUPO_1.inmuebles i ON i.nroInmueble = M.INMUEBLE_CODIGO 
    WHERE M.INMUEBLE_CARACTERISTICA_WIFI = 1;

    INSERT INTO GRUPO_1.caracteristicas_inmuebles (nroInmueble, idCaracteristica)
    SELECT i.id, GRUPO_1.obtener_id_caracteristica('Cable')
    FROM gd_esquema.Maestra M 
    JOIN GRUPO_1.inmuebles i ON i.nroInmueble = M.INMUEBLE_CODIGO 
    WHERE M.INMUEBLE_CARACTERISTICA_CABLE = 1;

    INSERT INTO GRUPO_1.caracteristicas_inmuebles (nroInmueble, idCaracteristica)
    SELECT i.id, GRUPO_1.obtener_id_caracteristica('Calefacción')
    FROM gd_esquema.Maestra M 
    JOIN GRUPO_1.inmuebles i ON i.nroInmueble = M.INMUEBLE_CODIGO 
    WHERE M.INMUEBLE_CARACTERISTICA_CALEFACCION = 1;

    INSERT INTO GRUPO_1.caracteristicas_inmuebles (nroInmueble, idCaracteristica)
    SELECT i.id, GRUPO_1.obtener_id_caracteristica('Gas') 
    FROM gd_esquema.Maestra M 
    JOIN GRUPO_1.inmuebles i ON i.nroInmueble = M.INMUEBLE_CODIGO 
    WHERE M.INMUEBLE_CARACTERISTICA_GAS = 1;
END 
GO

CREATE PROCEDURE GRUPO_1.migrar_PagosVentas AS
BEGIN
    INSERT INTO GRUPO_1.pagosVentas(venta_id,importe,moneda,cotizacion,medioDePago)
    SELECT v.idVenta, PAGO_VENTA_IMPORTE, PAGO_VENTA_MONEDA, PAGO_VENTA_COTIZACION, PAGO_VENTA_MEDIO_PAGO
    FROM gd_esquema.Maestra m 
    JOIN GRUPO_1.ventas v ON  v.codigoVenta = m.VENTA_CODIGO
    JOIN GRUPO_1.mediosDePagos mp ON mp.medio = m.PAGO_VENTA_MEDIO_PAGO
    WHERE m.PAGO_VENTA_IMPORTE IS NOT NULL;
END
GO

-------------------------------------
------ EJECUCION MIGRACIONES --------
-------------------------------------

SELECT * FROM GRUPO_1.disposiciones
SELECT * FROM GRUPO_1.estados
SELECT * FROM GRUPO_1.orientaciones
SELECT * FROM GRUPO_1.caracteristicas
SELECT * FROM GRUPO_1.tiposPeriodos -- REVISAR
SELECT * FROM GRUPO_1.estadosAlquileres
SELECT * FROM GRUPO_1.mediosDePagos
SELECT * FROM GRUPO_1.tiposInmuebles
SELECT * FROM GRUPO_1.tipoOperacion
SELECT * FROM GRUPO_1.barrios ORDER BY nombre
SELECT * FROM GRUPO_1.localidades ORDER BY nombre
SELECT * FROM GRUPO_1.provincias ORDER BY nombre
SELECT * FROM GRUPO_1.cantAmbientes -- REVISAR
SELECT * FROM GRUPO_1.monedas
SELECT * FROM GRUPO_1.propietarios
SELECT * FROM GRUPO_1.compradores
SELECT DISTINCT nroPeriodo, fechaInicioPeriodo, fechaFinPeriodo FROM GRUPO_1.periodos -- REVISAR
SELECT * FROM GRUPO_1.direcciones
SELECT DISTINCT direccion, localidad_id, provincia_id, barrio_id FROM GRUPO_1.direcciones
SELECT * FROM GRUPO_1.sucursales
SELECT * FROM GRUPO_1.inmuebles
SELECT DISTINCT nroInmueble FROM GRUPO_1.inmuebles
SELECT * FROM GRUPO_1.inquilinos
SELECT DISTINCT nombre, apellido, dni, fechaRegistro, telefono, mail, fechaNacimiento FROM GRUPO_1.propietarios
SELECT DISTINCT nombre FROM GRUPO_1.localidades
SELECT DISTINCT nombre, apellido, dni, fechaRegistro, telefono, mail, fechaNacimiento FROM GRUPO_1.compradores 
SELECT * FROM GRUPO_1.barrios
SELECT nombre FROM GRUPO_1.barrios
SELECT * FROM GRUPO_1.localidades
SELECT nombre FROM GRUPO_1.localidades
SELECT * FROM GRUPO_1.direcciones
SELECT DISTINCT direccion, localidad_id, provincia_id, barrio_id FROM GRUPO_1.direcciones
SELECT * FROM GRUPO_1.inmuebles
SELECT DISTINCT nroInmueble, nombre, descripcion, superficieTotal, antiguedad, expensas, tipoInmueble, propietario_id, ambientes_id, disposicion_id, estado_id FROM GRUPO_1.inmuebles

BEGIN TRANSACTION;
	EXECUTE GRUPO_1.migrar_Disposiciones;
	EXECUTE GRUPO_1.migrar_Estados;
	EXECUTE GRUPO_1.migrar_Orientaciones;
	EXECUTE GRUPO_1.migrar_Caracteristicas;
    EXECUTE GRUPO_1.migrar_TiposPeriodos;
	EXECUTE GRUPO_1.migrar_EstadosAlquileres;
    EXECUTE GRUPO_1.migrar_MediosDePago;
    EXECUTE GRUPO_1.migrar_TiposInmuebles;
	EXECUTE GRUPO_1.migrar_TipoOperaciones;
    EXECUTE GRUPO_1.migrar_Barrios;
    EXECUTE GRUPO_1.migrar_Localidades;
    EXECUTE GRUPO_1.migrar_Provincias;
    EXECUTE GRUPO_1.migrar_CantAmbientes;
    EXECUTE GRUPO_1.migrar_Monedas;
    EXECUTE GRUPO_1.migrar_Propietarios;
	EXECUTE GRUPO_1.migrar_Compradores;
	EXECUTE GRUPO_1.migrar_Periodos;
	EXECUTE GRUPO_1.migrar_Direcciones;
	EXECUTE GRUPO_1.migrar_Sucursales;
	EXECUTE GRUPO_1.migrar_Agentes;
	EXECUTE GRUPO_1.migrar_Inmuebles;
	EXECUTE GRUPO_1.migrar_Inquilinos;
	EXECUTE GRUPO_1.migrar_Anuncios;
	EXECUTE GRUPO_1.migrar_Alquileres;
	EXECUTE GRUPO_1.migrar_Importes;
    EXECUTE GRUPO_1.migrar_Ventas;
    EXECUTE GRUPO_1.migrar_PagosVentas;
    EXECUTE GRUPO_1.migrar_Caracteristicas_Inmuebles;
    EXECUTE GRUPO_1.migrar_PagosAlquileres;
COMMIT TRANSACTION;


	DROP PROCEDURE GRUPO_1.migrar_Disposiciones;
	DROP PROCEDURE GRUPO_1.migrar_Estados;
	DROP PROCEDURE GRUPO_1.migrar_Orientaciones;
	DROP PROCEDURE GRUPO_1.migrar_Caracteristicas;
    DROP PROCEDURE GRUPO_1.migrar_TiposPeriodos;
	DROP PROCEDURE GRUPO_1.migrar_EstadosAlquileres;
    DROP PROCEDURE GRUPO_1.migrar_MediosDePago;
    DROP PROCEDURE GRUPO_1.migrar_TiposInmuebles;
	DROP PROCEDURE GRUPO_1.migrar_TipoOperaciones;
    DROP PROCEDURE GRUPO_1.migrar_Barrios;
    DROP PROCEDURE GRUPO_1.migrar_Localidades;
    DROP PROCEDURE GRUPO_1.migrar_Provincias;
    DROP PROCEDURE GRUPO_1.migrar_CantAmbientes;
    DROP PROCEDURE GRUPO_1.migrar_Monedas;
    DROP PROCEDURE GRUPO_1.migrar_Propietarios;
	DROP PROCEDURE GRUPO_1.migrar_Compradores;
	DROP PROCEDURE GRUPO_1.migrar_Periodos;
	DROP PROCEDURE GRUPO_1.migrar_Direcciones;
	DROP PROCEDURE GRUPO_1.migrar_Sucursales;
	DROP PROCEDURE GRUPO_1.migrar_Agentes;
	DROP PROCEDURE GRUPO_1.migrar_Inmuebles;
	DROP PROCEDURE GRUPO_1.migrar_Inquilinos;
	DROP PROCEDURE GRUPO_1.migrar_Anuncios;
	DROP PROCEDURE GRUPO_1.migrar_Alquileres;
	DROP PROCEDURE GRUPO_1.migrar_Importes;
    DROP PROCEDURE GRUPO_1.migrar_Ventas;
    DROP PROCEDURE GRUPO_1.migrar_PagosVentas;
    DROP PROCEDURE GRUPO_1.migrar_Caracteristicas_Inmuebles;
    DROP PROCEDURE GRUPO_1.migrar_PagosAlquileres;

    DROP FUNCTION GRUPO_1.ConvertirMoneda
    DROP FUNCTION GRUPO_1.obtener_id_caracteristica

