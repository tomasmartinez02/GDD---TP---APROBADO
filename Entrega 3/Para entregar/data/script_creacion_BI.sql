USE GD2C2023

GO

---------------------------
-- ELIMINACION DE TABLAS --
---------------------------

IF OBJECT_ID('GRUPO_1.BI_Anuncios', 'U') IS NOT NULL DROP TABLE GRUPO_1.BI_Anuncios;
IF OBJECT_ID('GRUPO_1.BI_Pagos', 'U') IS NOT NULL DROP TABLE GRUPO_1.BI_Pagos;
IF OBJECT_ID('GRUPO_1.BI_Ventas', 'U') IS NOT NULL DROP TABLE GRUPO_1.BI_Ventas;
IF OBJECT_ID('GRUPO_1.BI_Alquileres', 'U') IS NOT NULL DROP TABLE GRUPO_1.BI_Alquileres;
IF OBJECT_ID('GRUPO_1.BI_Tiempo', 'U') IS NOT NULL DROP TABLE GRUPO_1.BI_Tiempo;
IF OBJECT_ID('GRUPO_1.BI_RangoSuperficie', 'U') IS NOT NULL DROP TABLE GRUPO_1.BI_RangoSuperficie;
IF OBJECT_ID('GRUPO_1.BI_TipoMoneda', 'U') IS NOT NULL DROP TABLE GRUPO_1.BI_TipoMoneda;
IF OBJECT_ID('GRUPO_1.BI_Ambientes', 'U') IS NOT NULL DROP TABLE GRUPO_1.BI_Ambientes;
IF OBJECT_ID('GRUPO_1.BI_RangoEdad', 'U') IS NOT NULL DROP TABLE GRUPO_1.BI_RangoEdad;
IF OBJECT_ID('GRUPO_1.BI_Ubicacion', 'U') IS NOT NULL DROP TABLE GRUPO_1.BI_Ubicacion;
IF OBJECT_ID('GRUPO_1.BI_Sucursal', 'U') IS NOT NULL DROP TABLE GRUPO_1.BI_Sucursal;
IF OBJECT_ID('GRUPO_1.BI_TipoOperacion', 'U') IS NOT NULL DROP TABLE GRUPO_1.BI_TipoOperacion;
IF OBJECT_ID('GRUPO_1.BI_TipoInmueble', 'U') IS NOT NULL DROP TABLE GRUPO_1.BI_TipoInmueble;

----------------------------
---- CREACION DE TABLAS ----
----------------------------

--- TABLAS DE DIMENSIONES ---

CREATE TABLE [GRUPO_1].[BI_Tiempo]
(
    tiempo_id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    anio INTEGER, 
    mes INTEGER,
    cuatrimestre VARCHAR(255)
);

CREATE TABLE [GRUPO_1].[BI_RangoSuperficie]
(
    rango_id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    rango_superficie INTEGER,
	metrosDesde NUMERIC(10,2),
	metrosHasta NUMERIC(10,2),
    descripcion VARCHAR(255)
);

CREATE TABLE [GRUPO_1].[BI_TipoMoneda]
(
    tipo_id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(255)
);

CREATE TABLE [GRUPO_1].[BI_Ambientes]
(
    ambientes_id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    descripcion VARCHAR(255)
);

CREATE TABLE [GRUPO_1].[BI_RangoEdad]
(
    rango_id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    edadDesde NUMERIC(10,2),
    edadHasta NUMERIC(10,2),
    descripcion VARCHAR(255)
);

CREATE TABLE [GRUPO_1].[BI_Ubicacion]
(
    ubicacion_id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    provincia VARCHAR(255),
    localidad VARCHAR(255),
    barrio VARCHAR(255)
);

CREATE TABLE [GRUPO_1].[BI_Sucursal]
(
    sucursal_id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(255), 
    direccion VARCHAR(255),
);

CREATE TABLE [GRUPO_1].[BI_TipoOperacion]
(
    tipo_id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    descripcion VARCHAR(255)
);

CREATE TABLE [GRUPO_1].[BI_TipoInmueble]
(
    tipo_id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR (255)
);

--- TABLAS DE HECHOS ---

CREATE TABLE [GRUPO_1].[BI_Anuncios]
(
    tipoDeOperacion_id INT NOT NULL,
    ubicacion_id INT NOT NULL,
    ambientes_id INT NOT NULL,
    tiempo_id INT NOT NULL,
    tipoDeInmueble_id INT NOT NULL,
    rangoMetros_id INT NOT NULL,
    tipoMoneda_id INT NOT NULL,
    anuncio_id INT NOT NULL,
    duracionDias INT,
    precio NUMERIC(10,2),
    concretado INT NOT NULL,
	rango_edad INT NOT NULL,
	sucursal_id INT NOT NULL,
    PRIMARY KEY (tipoDeOperacion_id, ubicacion_id, ambientes_id, tiempo_id, tipoDeInmueble_id, rangoMetros_id, tipoMoneda_id, anuncio_id),
    FOREIGN KEY (tipoDeOperacion_id) REFERENCES GRUPO_1.BI_TipoOperacion (tipo_id),
    FOREIGN KEY (ubicacion_id) REFERENCES GRUPO_1.BI_Ubicacion (ubicacion_id),
    FOREIGN KEY (ambientes_id) REFERENCES GRUPO_1.BI_Ambientes (ambientes_id),
    FOREIGN KEY (tiempo_id) REFERENCES GRUPO_1.BI_Tiempo (tiempo_id),
    FOREIGN KEY (tipoDeInmueble_id) REFERENCES GRUPO_1.BI_TipoInmueble (tipo_id),
    FOREIGN KEY (rangoMetros_id) REFERENCES GRUPO_1.BI_RangoSuperficie (rango_id),
    FOREIGN KEY (tipoMoneda_id) REFERENCES GRUPO_1.BI_TipoMoneda (tipo_id),
	FOREIGN KEY (rango_edad) REFERENCES GRUPO_1.BI_RangoEdad (rango_id),
	FOREIGN KEY (sucursal_id) REFERENCES GRUPO_1.BI_sucursal (sucursal_id)
);

CREATE TABLE [GRUPO_1].[BI_Alquileres]
(
    ubicacion_id INT NOT NULL,
    tiempo_id INT NOT NULL,
    rango_edad INT NOT NULL,
    sucursal_id INT NOT NULL,
    tipoMoneda_id INT NOT NULL,
	alquiler_id INT NOT NULL,
    comision NUMERIC(10,2),
    montoTotal NUMERIC(10,2),
	PRIMARY KEY (ubicacion_id, tiempo_id, rango_edad, sucursal_id, alquiler_id),
	FOREIGN KEY (ubicacion_id) REFERENCES GRUPO_1.BI_Ubicacion (ubicacion_id),
	FOREIGN KEY (tiempo_id) REFERENCES GRUPO_1.BI_Tiempo (tiempo_id),
	FOREIGN KEY (rango_edad) REFERENCES GRUPO_1.BI_RangoEdad (rango_id),
	FOREIGN KEY (sucursal_id) REFERENCES GRUPO_1.BI_Sucursal (sucursal_id),
    FOREIGN KEY (tipoMoneda_id) REFERENCES GRUPO_1.BI_TipoMoneda (tipo_id),
);

CREATE TABLE [GRUPO_1].[BI_Pagos]
(
    codigoPago INT NOT NULL,
    fechaPago DATETIME,
    tiempo_id INT NOT NULL,
    importe NUMERIC(10,2),
    vencido INT NOT NULL,
    alquiler_id INT NOT NULL,
    alquilerActivo INT,
    PRIMARY KEY (alquiler_id, tiempo_id),
    FOREIGN KEY (tiempo_id) REFERENCES GRUPO_1.BI_Tiempo (tiempo_id)
);

CREATE TABLE [GRUPO_1].[BI_Ventas]
(
    tipoDeInmueble_id INT NOT NULL,
    tiempo_id INT NOT NULL,
    ubicacion_id INT NOT NULL,
    sucursal_id INT NOT NULL,
    tipoMoneda_id INT NOT NULL,
	venta_id INT NOT NULL,
    comision NUMERIC(10,2),
    precioVendido NUMERIC(10,2),
    metros NUMERIC(10,2),
	precioMetroCuadrado NUMERIC(10,2),
    PRIMARY KEY (tipoDeInmueble_id, tiempo_id, ubicacion_id, sucursal_id, tipoMoneda_id, venta_id),
    FOREIGN KEY (tipoDeInmueble_id) REFERENCES GRUPO_1.BI_TipoInmueble (tipo_id),
    FOREIGN KEY (tiempo_id) REFERENCES GRUPO_1.BI_Tiempo (tiempo_id),
    FOREIGN KEY (ubicacion_id) REFERENCES GRUPO_1.BI_Ubicacion (ubicacion_id),
    FOREIGN KEY (sucursal_id) REFERENCES GRUPO_1.BI_Sucursal (sucursal_id),
    FOREIGN KEY (tipoMoneda_id) REFERENCES GRUPO_1.BI_TipoMoneda (tipo_id),
);

-----------------------------
--------- FUNCIONES ---------
-----------------------------

GO
CREATE FUNCTION GRUPO_1.CUATRIMESTRE(@Fecha DATETIME)
RETURNS INT
AS
BEGIN
    DECLARE @Cuatrimestre INT;

    SET @Cuatrimestre = 
        CASE
            WHEN MONTH(@Fecha) BETWEEN 1 AND 4 THEN 1
            WHEN MONTH(@Fecha) BETWEEN 5 AND 8 THEN 2
            WHEN MONTH(@Fecha) BETWEEN 9 AND 12 THEN 3
            ELSE NULL
        END;

    RETURN @Cuatrimestre;
END
GO

GO
CREATE FUNCTION GRUPO_1.RANGO_EDAD(@Edad INT)
RETURNS INT
AS
BEGIN
    DECLARE @Rango INT;

    SET @Rango = 
        CASE
            WHEN @Edad < 25 THEN 1
            WHEN @Edad BETWEEN 25 AND 35 THEN 2
            WHEN @Edad BETWEEN 35 AND 50 THEN 3
            WHEN @Edad > 50 THEN 4
        END;

    RETURN @Rango;
END
GO

GO
CREATE FUNCTION GRUPO_1.RANGO_EDAD_STRING(@Edad INT)
RETURNS VARCHAR(255)
AS
BEGIN
    DECLARE @Rango VARCHAR(255);

    SET @Rango = 
        CASE
            WHEN @Edad < 25 THEN 'Menor a 25'
            WHEN @Edad BETWEEN 25 AND 35 THEN 'Entre 25 y 35'
            WHEN @Edad BETWEEN 35 AND 50 THEN 'Entre 35 y 50'
            WHEN @Edad > 50 THEN 'Mayor a 50'
        END;

    RETURN @Rango;
END
GO

GO
CREATE FUNCTION GRUPO_1.TIPO_OPERACION(@Tipo VARCHAR(255))
RETURNS VARCHAR(255)
AS
BEGIN
	DECLARE @Nuevo_tipo VARCHAR(255);

	SET @Nuevo_tipo =
		CASE
			WHEN @Tipo = 'Tipo Operación Alquiler Contrato' OR @Tipo = 'Tipo Operación Alquiler Temporario' THEN 'Tipo Operación Alquiler'
            ELSE 'Tipo Operación Venta'
		END;

	RETURN @Nuevo_tipo;
END
GO

-------------------------------------
-------- MIGRACION DE DATOS ---------
-------------------------------------

GO
CREATE PROCEDURE GRUPO_1.BI_MigrarTiempo AS
BEGIN

    INSERT INTO GRUPO_1.BI_Tiempo (anio, mes, cuatrimestre)
    SELECT DISTINCT
        YEAR(fechaInicio),
        DATEPART(MONTH, fechaInicio),
        GRUPO_1.CUATRIMESTRE(fechaInicio)
    FROM GRUPO_1.alquileres 
    UNION
    SELECT DISTINCT
        YEAR(fechaFin),
        DATEPART(MONTH, fechaFin),
        GRUPO_1.CUATRIMESTRE(fechaFin)
    FROM GRUPO_1.alquileres
    UNION
    SELECT DISTINCT
        YEAR(fechaVenta),
        DATEPART(MONTH, fechaVenta),
        GRUPO_1.CUATRIMESTRE(fechaVenta)
    FROM GRUPO_1.ventas
    UNION
    SELECT DISTINCT
        YEAR(fechaPublicacion),
        DATEPART(MONTH, fechaPublicacion),
        GRUPO_1.CUATRIMESTRE(fechaPublicacion)
    FROM GRUPO_1.anuncios
    UNION
    SELECT DISTINCT
        YEAR(fechaFinalizacion),
        DATEPART(MONTH, fechaFinalizacion),
        GRUPO_1.CUATRIMESTRE(fechaFinalizacion)
    FROM GRUPO_1.anuncios
    UNION
    SELECT DISTINCT
        YEAR(fechaPago),
        DATEPART(MONTH, fechaPago),
        GRUPO_1.CUATRIMESTRE(fechaPago)
    FROM GRUPO_1.pagosAlquileres
    UNION
    SELECT DISTINCT
        YEAR(fechaVencimiento),
        DATEPART(MONTH, fechaVencimiento),
        GRUPO_1.CUATRIMESTRE(fechaVencimiento)
    FROM GRUPO_1.pagosAlquileres
    UNION
    SELECT DISTINCT
        YEAR(fechaInicioPeriodo),
        DATEPART(MONTH, fechaInicioPeriodo),
        GRUPO_1.CUATRIMESTRE(fechaInicioPeriodo)
    FROM GRUPO_1.periodos
    UNION
    SELECT DISTINCT
        YEAR(fechaFinPeriodo),
        DATEPART(MONTH, fechaFinPeriodo),
        GRUPO_1.CUATRIMESTRE(fechaFinPeriodo)
    FROM GRUPO_1.periodos;

END
GO

GO
CREATE PROCEDURE GRUPO_1.BI_MigrarRangoSuperficie AS
BEGIN

    INSERT INTO GRUPO_1.BI_RangoSuperficie (rango_superficie, metrosDesde, metrosHasta, descripcion)
    SELECT DISTINCT
        CASE 
            WHEN superficieTotal < 35.00 THEN 1
            WHEN superficieTotal BETWEEN 35.00 AND 55.00 THEN 2
            WHEN superficieTotal BETWEEN 55.00 AND 75.00 THEN 3
            WHEN superficieTotal BETWEEN 75.00 AND 100.00 THEN 4
            WHEN superficieTotal > 100.00 THEN 5
        END,
		CASE 
            WHEN superficieTotal < 35.00 THEN 0.00
            WHEN superficieTotal BETWEEN 35.00 AND 55.00 THEN 35.00
            WHEN superficieTotal BETWEEN 55.00 AND 75.00 THEN 55.00
            WHEN superficieTotal BETWEEN 75.00 AND 100.00 THEN 75.00
            WHEN superficieTotal > 100.00 THEN 100.00
        END,
		CASE 
            WHEN superficieTotal < 35.00 THEN 35.00
            WHEN superficieTotal BETWEEN 35.00 AND 55.00 THEN 55.00
            WHEN superficieTotal BETWEEN 55.00 AND 75.00 THEN 75.00
            WHEN superficieTotal BETWEEN 75.00 AND 100.00 THEN 100.00
            WHEN superficieTotal > 100.00 THEN 500.00
        END,
        CASE 
            WHEN superficieTotal < 35.00 THEN 'Menor a 35'
            WHEN superficieTotal BETWEEN 35.00 AND 55.00 THEN 'Entre 35 y 50'
            WHEN superficieTotal BETWEEN 55.00 AND 75.00 THEN 'Entre 55 y 75'
            WHEN superficieTotal BETWEEN 75.00 AND 100.00 THEN 'Entre 75 y 100'
            WHEN superficieTotal > 100.00 THEN 'Mayor a 100'
        END
    FROM GRUPO_1.inmuebles

END
GO

GO
CREATE PROCEDURE GRUPO_1.BI_MigrarTipoMoneda AS
BEGIN

    INSERT INTO GRUPO_1.BI_TipoMoneda (nombre)
    SELECT DISTINCT
        moneda_id
    FROM GRUPO_1.monedas

END
GO

GO
CREATE PROCEDURE GRUPO_1.BI_MigrarAmbientes AS
BEGIN

    INSERT INTO GRUPO_1.BI_Ambientes (descripcion)
    SELECT DISTINCT
        descripcion
    FROM GRUPO_1.cantAmbientes

END
GO

GO
CREATE PROCEDURE GRUPO_1.BI_MigrarRangoEdad AS
BEGIN

    INSERT INTO GRUPO_1.BI_RangoEdad (edadDesde, edadHasta, descripcion)
    SELECT DISTINCT
        CASE 
            WHEN DATEDIFF(year, fechaNacimiento, GETDATE()) < 25 THEN 0
            WHEN DATEDIFF(year, fechaNacimiento, GETDATE()) BETWEEN 25 AND 35 THEN 25
            WHEN DATEDIFF(year, fechaNacimiento, GETDATE()) BETWEEN 35 AND 50 THEN 35
            WHEN DATEDIFF(year, fechaNacimiento, GETDATE()) > 50 THEN 50
        END,
        CASE 
            WHEN DATEDIFF(year, fechaNacimiento, GETDATE()) < 25 THEN 25
            WHEN DATEDIFF(year, fechaNacimiento, GETDATE()) BETWEEN 25 AND 35 THEN 35
            WHEN DATEDIFF(year, fechaNacimiento, GETDATE()) BETWEEN 35 AND 50 THEN 50
            WHEN DATEDIFF(year, fechaNacimiento, GETDATE()) > 50 THEN 500
        END,
        CASE 
            WHEN DATEDIFF(year, fechaNacimiento, GETDATE()) < 25 THEN 'Menor a 25'
            WHEN DATEDIFF(year, fechaNacimiento, GETDATE()) BETWEEN 25 AND 35 THEN 'Entre 25 y 35'
            WHEN DATEDIFF(year, fechaNacimiento, GETDATE()) BETWEEN 35 AND 50 THEN 'Entre 35 y 50'
            WHEN DATEDIFF(year, fechaNacimiento, GETDATE()) > 50 THEN 'Mayor a 50'
        END
    FROM GRUPO_1.inquilinos

END
GO

GO
CREATE PROCEDURE GRUPO_1.BI_MigrarUbicaciones AS
BEGIN

    INSERT INTO GRUPO_1.BI_Ubicacion (provincia, localidad, barrio)
    SELECT DISTINCT
        p.nombre,
        l.nombre,
        b.nombre
    FROM GRUPO_1.direcciones d
        JOIN GRUPO_1.barrios b ON d.barrio_id = b.barrio_id
        JOIN GRUPO_1.localidades l ON d.localidad_id = l.localidad_id
        JOIN GRUPO_1.provincias p ON d.provincia_id = p.provincia_id

END
GO

GO
CREATE PROCEDURE GRUPO_1.BI_MigrarSucursales AS
BEGIN

    INSERT INTO GRUPO_1.BI_Sucursal (nombre, direccion)
    SELECT DISTINCT
        s.nombre,
        d.direccion
    FROM GRUPO_1.sucursales s
        JOIN GRUPO_1.direcciones d ON s.direccion_id = d.codigoDireccion

END
GO

GO
CREATE PROCEDURE GRUPO_1.BI_MigrarTiposOperaciones AS
BEGIN

    INSERT INTO GRUPO_1.BI_TipoOperacion (descripcion)
    SELECT DISTINCT
        GRUPO_1.TIPO_OPERACION(tipo)
    FROM GRUPO_1.tipoOperacion
END
GO

GO
CREATE PROCEDURE GRUPO_1.BI_MigrarTipoInmueble AS
BEGIN

    INSERT INTO GRUPO_1.BI_TipoInmueble (nombre)
    SELECT DISTINCT
        nombre
    FROM GRUPO_1.tiposInmuebles

END
GO

GO
CREATE PROCEDURE GRUPO_1.BI_MigrarAnuncios AS 
BEGIN

    INSERT INTO GRUPO_1.BI_Anuncios (tipoDeOperacion_id, ubicacion_id, ambientes_id, tiempo_id, tipoDeInmueble_id, rangoMetros_id, tipoMoneda_id, anuncio_id, duracionDias, precio, concretado, rango_edad, sucursal_id)
    SELECT DISTINCT
        BItipoOp.tipo_id,
		BIu.ubicacion_id,
		BIa.ambientes_id,
		BItemp.tiempo_id,
		BIti.tipo_id,
		BIr.rango_id,
		BItm.tipo_id,
        a.idAnuncio,
        DATEDIFF(DAY, a.fechaPublicacion, a.fechaFinalizacion),
		a.precio,
        CASE
            WHEN v.anuncio_id IS NULL AND al.anuncio_id IS NULL THEN 0
            ELSE 1
        END,
		BIe.rango_id,
		BIsu.sucursal_id
    FROM GRUPO_1.anuncios a
        JOIN GRUPO_1.tipoOperacion tipoOp ON a.tipoOperacion_id = tipoOp.tipoOperacion_id 
        JOIN GRUPO_1.BI_TipoOperacion BItipoOp ON GRUPO_1.TIPO_OPERACION(tipoOp.tipo) = BItipoOp.descripcion
		JOIN GRUPO_1.inmuebles i ON a.inmueble_id = i.id
        JOIN GRUPO_1.direcciones d ON i.direccion_id = d.codigoDireccion
        JOIN GRUPO_1.barrios b ON d.barrio_id = b.barrio_id
		JOIN GRUPO_1.localidades l ON d.localidad_id = l.localidad_id
		JOIN GRUPO_1.provincias p ON d.provincia_id = p.provincia_id
		JOIN GRUPO_1.BI_Ubicacion BIu ON (b.nombre = BIu.barrio AND l.nombre = BIu.localidad AND p.nombre = BIu.provincia)
		JOIN GRUPO_1.cantAmbientes cantA ON i.ambientes_id = cantA.id_ambientes
		JOIN GRUPO_1.BI_Ambientes BIa ON cantA.descripcion = BIa.descripcion
		JOIN GRUPO_1.BI_Tiempo BItemp ON (YEAR(a.fechaPublicacion) = BItemp.anio AND MONTH(a.fechaPublicacion) = BItemp.mes)
		JOIN GRUPO_1.tiposInmuebles ti ON i.tipoInmueble = ti.tipoInmueble
		JOIN GRUPO_1.BI_TipoInmueble BIti ON ti.nombre = BIti.nombre
		JOIN GRUPO_1.BI_RangoSuperficie BIr ON (i.superficieTotal BETWEEN BIr.metrosDesde AND BIr.metrosHasta)
		JOIN GRUPO_1.BI_TipoMoneda BItm ON a.moneda_id = BItm.nombre
        JOIN GRUPO_1.agentes ag ON a.agente_id = ag.idAgente
        JOIN GRUPO_1.BI_RangoEdad BIe ON DATEDIFF(YEAR, ag.fechaNacimiento, GETDATE()) BETWEEN BIe.edadDesde AND BIe.edadHasta
        LEFT JOIN GRUPO_1.ventas v ON a.idAnuncio = v.anuncio_id
        LEFT JOIN GRUPO_1.alquileres al ON a.idAnuncio = al.anuncio_id
        JOIN GRUPO_1.BI_Sucursal BIsu ON BIsu.sucursal_id = ag.sucursal_id
END
GO 

GO
CREATE PROCEDURE GRUPO_1.BI_MigrarAlquileres AS 
BEGIN

	INSERT INTO GRUPO_1.BI_Alquileres (ubicacion_id, tiempo_id, rango_edad, sucursal_id, tipoMoneda_id, alquiler_id, comision, montoTotal)
	SELECT DISTINCT
		BIu.ubicacion_id,
		BItemp.tiempo_id,
		BIedad.rango_id, 
		BIs.sucursal_id,
		BItm.tipo_id,
		al.id,
		al.comision,
        (SELECT SUM(importe) FROM GRUPO_1.pagosAlquileres WHERE alquiler_id = al.id GROUP BY alquiler_id )
	FROM GRUPO_1.alquileres al
		JOIN GRUPO_1.anuncios a ON al.anuncio_id = a.idAnuncio
		JOIN GRUPO_1.inmuebles i ON a.inmueble_id = i.id
        JOIN GRUPO_1.direcciones d ON i.direccion_id = d.codigoDireccion
        JOIN GRUPO_1.barrios b ON d.barrio_id = b.barrio_id
		JOIN GRUPO_1.localidades l ON d.localidad_id = l.localidad_id
		JOIN GRUPO_1.provincias p ON d.provincia_id = p.provincia_id
        JOIN GRUPO_1.BI_Ubicacion BIu ON (b.nombre = BIu.barrio AND l.nombre = BIu.localidad AND p.nombre = BIu.provincia)
		JOIN GRUPO_1.BI_Tiempo BItemp ON (YEAR(al.fechaInicio) = BItemp.anio AND MONTH(al.fechaInicio) = BItemp.mes)
		JOIN GRUPO_1.inquilinos inq ON al.inquilino_id = inq.idInquilino
		JOIN GRUPO_1.BI_RangoEdad BIedad ON DATEDIFF(YEAR, inq.fechaNacimiento, GETDATE()) BETWEEN BIedad.edadDesde AND BIedad.edadHasta
		JOIN GRUPO_1.agentes ag ON a.agente_id = ag.idAgente
		JOIN GRUPO_1.sucursales s ON ag.sucursal_id = s.sucursal_id
		JOIN GRUPO_1.BI_Sucursal BIs ON s.nombre = BIs.nombre
		JOIN GRUPO_1.BI_TipoMoneda BItm ON a.moneda_id = BItm.nombre
        JOIN GRUPO_1.anuncios an ON al.anuncio_id = an.idAnuncio
END
GO

GO
CREATE PROCEDURE GRUPO_1.BI_MigrarPagos AS 
BEGIN

    INSERT INTO GRUPO_1.BI_Pagos (codigoPago, fechaPago, tiempo_id, importe, vencido, alquiler_id, alquilerActivo)
    SELECT DISTINCT
    p.codigoPago,
    p.fechaPago,
    t.tiempo_id,
    p.importe,
    CASE
        WHEN p.fechaPago > p.fechaVencimiento THEN 1
        ELSE 0
    END,
    p.alquiler_id,
	CASE
		WHEN a.fechaFin < GETDATE() THEN 0
		ELSE 1
	END
    FROM GRUPO_1.pagosAlquileres p
        JOIN GRUPO_1.BI_Tiempo t on YEAR(p.fechaPago) = t.anio and MONTH(p.fechaPago) = t.mes
		JOIN GRUPO_1.alquileres a ON p.alquiler_id = a.id

END
GO

GO
CREATE PROCEDURE GRUPO_1.BI_MigrarVentas AS 
BEGIN

    INSERT INTO GRUPO_1.BI_Ventas (tipoDeInmueble_id, tiempo_id, ubicacion_id, sucursal_id, tipoMoneda_id, venta_id, comision, precioVendido, metros, precioMetroCuadrado)
    SELECT DISTINCT
        BIti.tipo_id,  
        BItemp.tiempo_id,
        BIu.ubicacion_id,
        BIs.sucursal_id,
        BItm.tipo_id,
		v.idVenta,
        v.comisionInmobiliaria,
		v.precioFinal,
		i.superficieTotal,
        v.precioFinal / i.superficieTotal
    FROM GRUPO_1.ventas v
		JOIN GRUPO_1.anuncios a ON v.anuncio_id = a.idAnuncio
		JOIN GRUPO_1.inmuebles i ON a.inmueble_id = i.id
        JOIN GRUPO_1.direcciones d ON i.direccion_id = d.codigoDireccion
        JOIN GRUPO_1.barrios b ON d.barrio_id = b.barrio_id
		JOIN GRUPO_1.localidades l ON d.localidad_id = l.localidad_id
		JOIN GRUPO_1.provincias p ON d.provincia_id = p.provincia_id
        JOIN GRUPO_1.BI_Ubicacion BIu ON (b.nombre = BIu.barrio AND l.nombre = BIu.localidad AND p.nombre = BIu.provincia)
		JOIN GRUPO_1.BI_Tiempo BItemp ON (YEAR(v.fechaVenta) = BItemp.anio AND MONTH(v.fechaVenta) = BItemp.mes)
		JOIN GRUPO_1.tiposInmuebles ti ON i.tipoInmueble = ti.tipoInmueble
		JOIN GRUPO_1.BI_TipoInmueble BIti ON ti.nombre = BIti.nombre
		JOIN GRUPO_1.BI_TipoMoneda BItm ON v.moneda_id = BItm.nombre
		JOIN GRUPO_1.agentes ag ON a.agente_id = ag.idAgente
		JOIN GRUPO_1.sucursales s ON ag.sucursal_id = s.sucursal_id
		JOIN GRUPO_1.BI_Sucursal BIs ON s.nombre = BIs.nombre

END
GO

-------------------------------------
------- CREACION DE VISTAS ----------
-------------------------------------

GO
CREATE VIEW Punto1_DuracionPromedioAnunciosPublicados AS
SELECT
	BItipoOp.descripcion AS tipoOperacion,
	BIubi.barrio,
	BIamb.descripcion AS cantidadAmbientes,
	BItemp.cuatrimestre,
	BItemp.anio,
	AVG(a.duracionDias) AS promedioDuracionDias
FROM GRUPO_1.BI_Anuncios a
	JOIN GRUPO_1.BI_TipoOperacion BItipoOp ON a.tipoDeOperacion_id = BItipoOp.tipo_id
	JOIN GRUPO_1.BI_Ubicacion BIubi ON a.ubicacion_id = BIubi.ubicacion_id
	JOIN GRUPO_1.BI_Ambientes BIamb ON a.ambientes_id = BIamb.ambientes_id
	JOIN GRUPO_1.BI_Tiempo BItemp ON a.tiempo_id = BItemp.tiempo_id
GROUP BY BItipoOp.descripcion, BIubi.barrio, BIamb.descripcion, BItemp.cuatrimestre, BItemp.anio;
GO

GO
CREATE VIEW Punto2_PrecioPromedioAnunciosInmuebles AS 
SELECT
	BItipoOp.descripcion AS tipoOperacion,
	BItipoInm.nombre AS tipoInmueble,
	BIsup.descripcion AS rangom2,
	BItemp.cuatrimestre,
	BItemp.anio,
	BIm.nombre AS moneda,
	AVG(a.precio) AS precioPromedio
FROM GRUPO_1.BI_Anuncios a
	JOIN GRUPO_1.BI_TipoOperacion BItipoOp ON a.tipoDeOperacion_id = BItipoOp.tipo_id
	JOIN GRUPO_1.BI_TipoInmueble BItipoInm ON a.tipoDeInmueble_id = BItipoInm.tipo_id
	JOIN GRUPO_1.BI_RangoSuperficie BIsup ON a.rangoMetros_id = BIsup.rango_id
	JOIN GRUPO_1.BI_Tiempo BItemp ON a.tiempo_id = BItemp.tiempo_id
	JOIN GRUPO_1.BI_TipoMoneda BIm ON a.tipoMoneda_id = BIm.tipo_id
GROUP BY BItipoOp.descripcion, BItipoInm.nombre, BIsup.descripcion, BItemp.cuatrimestre, BItemp.anio, BIm.nombre
GO

GO
CREATE VIEW Punto3_BarriosMasElegidosParaAlquilar AS 
WITH TopBarriosPorRangoEtario AS (
    SELECT
        BItemp.mes AS mes,
        BItemp.anio AS anio,
        BIedad.descripcion AS rangoEtario,
        BIu.barrio AS barrio,
        COUNT(a.alquiler_id) AS CantidadAlquileres,
        ROW_NUMBER() OVER (PARTITION BY BItemp.mes, BItemp.anio, BIedad.descripcion ORDER BY COUNT(a.alquiler_id) DESC) AS Ranking
    FROM
        GRUPO_1.BI_Alquileres a
        JOIN GRUPO_1.BI_Tiempo BItemp ON a.tiempo_id = BItemp.tiempo_id
        JOIN GRUPO_1.BI_RangoEdad BIedad ON a.rango_edad = BIedad.rango_id
        JOIN GRUPO_1.BI_Ubicacion BIu ON a.ubicacion_id = BIu.ubicacion_id
    GROUP BY
        BItemp.mes,
        BItemp.anio,
        BIedad.descripcion,
        BIu.barrio
)
SELECT
    mes,
    anio,
    RangoEtario,
    barrio,
    CantidadAlquileres
FROM
    TopBarriosPorRangoEtario
WHERE
    Ranking <= 5
GO

GO
CREATE VIEW Punto4_PorcentajeIncumplimientoPagosAlquileres AS
SELECT
	BItemp.mes,
	BItemp.anio,
	(COUNT(CASE WHEN p.vencido = 1 THEN 1 END) * 100 / COUNT(*)) AS porcentajeIncumplimiento
FROM GRUPO_1.BI_Pagos p
	JOIN GRUPO_1.BI_Tiempo BItemp ON p.tiempo_id = BItemp.tiempo_id
GROUP BY BItemp.mes, BItemp.anio;
GO

GO
CREATE VIEW Punto5_PorcentajePromedioIncrementoValorAlquileres AS
SELECT
	BItemp.anio,
	BItemp.mes,
	AVG(p2.importe*100/p1.importe-100) as PorcentajeAumento
FROM GRUPO_1.BI_Pagos p1
	JOIN GRUPO_1.BI_Pagos p2 ON (p1.alquiler_id = p2.alquiler_id AND p1.importe != p2.importe AND p1.fechaPago < p2.fechaPago)
	JOIN GRUPO_1.BI_Tiempo BItemp ON (YEAR(p2.fechaPago) = BItemp.anio AND MONTH(p2.fechaPago) = BItemp.mes)
WHERE p2.alquilerActivo = 1
GROUP BY BItemp.anio, BItemp.mes
GO

GO
CREATE VIEW Punto6_PrecioPromedioM2Ventas AS
SELECT
	BIti.nombre AS tipoInmueble,
	BIu.localidad,
	BItemp.cuatrimestre,
	BItemp.anio,
	BItm.nombre,
	AVG(precioMetroCuadrado) AS precioPromedioM2
FROM GRUPO_1.BI_Ventas BIv
	JOIN GRUPO_1.BI_TipoInmueble BIti ON BIv.tipoDeInmueble_id = BIti.tipo_id
	JOIN GRUPO_1.BI_Ubicacion BIu ON BIv.ubicacion_id = BIu.ubicacion_id
	JOIN GRUPO_1.BI_Tiempo BItemp ON BIv.tiempo_id = BItemp.tiempo_id
	JOIN GRUPO_1.BI_TipoMoneda BItm ON BIv.tipoMoneda_id = BItm.tipo_id
GROUP BY BIti.nombre, BIu.localidad, BItemp.cuatrimestre, BItemp.anio, BItm.nombre
GO

GO
CREATE VIEW Punto7_ValorPromedioComision AS
SELECT
	BItop.descripcion AS tipoOperacion,
	BIs.nombre AS sucursal, 
	BItemp.cuatrimestre AS cuatrimestre,
	BItemp.anio AS año,
	AVG(comision) AS promedioComision
FROM GRUPO_1.BI_alquileres BIa 
        JOIN GRUPO_1.BI_Tiempo BItemp ON BIa.tiempo_id = BItemp.tiempo_id
        JOIN GRUPO_1.BI_Ubicacion BIu ON BIa.ubicacion_id = BIu.ubicacion_id
        JOIN GRUPO_1.BI_Sucursal BIs ON BIa.sucursal_id = BIs.sucursal_id 
		JOIN GRUPO_1.BI_TipoOperacion BItop ON BItop.descripcion = 'Tipo Operación Alquiler'
GROUP BY BItop.descripcion, BIs.nombre, BItemp.cuatrimestre, BItemp.anio
UNION ALL
SELECT
	BItop.descripcion AS tipoOperacion,
	BIs.nombre AS sucursal, 
	BItemp.cuatrimestre AS cuatrimestre,
	BItemp.anio AS año,
	AVG(comision) AS promedioComision
FROM GRUPO_1.BI_Ventas BIv 
        JOIN GRUPO_1.BI_Tiempo BItemp ON BIv.tiempo_id = BItemp.tiempo_id
        JOIN GRUPO_1.BI_Ubicacion BIu ON BIv.ubicacion_id = BIu.ubicacion_id
        JOIN GRUPO_1.BI_Sucursal BIs ON BIv.sucursal_id = BIs.sucursal_id 
		JOIN GRUPO_1.BI_TipoOperacion BItop ON BItop.descripcion = 'Tipo Operación Venta'
GROUP BY BItop.descripcion, BIs.nombre, BItemp.cuatrimestre, BItemp.anio
GO

GO
CREATE VIEW Punto8_PorcentajeCierreAnuncios AS
SELECT
	sub.sucursal AS sucursal,
	sub.rangoEdad AS rangoEdad, 
	sub.año AS año,
	sub.cierres,
	sub2.total,
	CAST(sub.cierres AS DECIMAL(10, 2)) / NULLIF(CAST(sub2.total AS DECIMAL(10, 2)), 0)*100 AS porcentajeCierre
FROM ((SELECT
    BIs.nombre AS sucursal,
        BIr.descripcion AS rangoEdad, 
        BItemp.anio AS año,
        COUNT(*) AS total
    FROM GRUPO_1.BI_Anuncios BIan 
    JOIN GRUPO_1.BI_Tiempo BItemp ON BIan.tiempo_id = BItemp.tiempo_id 
	JOIN GRUPO_1.BI_Sucursal BIs ON BIan.sucursal_id = BIs.sucursal_id 
	JOIN GRUPO_1.BI_RangoEdad BIr ON BIan.rango_edad = BIr.rango_id
        GROUP BY BIs.nombre, BIr.descripcion, BItemp.anio) AS sub2 
    LEFT JOIN (SELECT
        BIs.nombre AS sucursal,
        BIr.descripcion AS rangoEdad, 
        BItemp.anio AS año,
        COUNT(BIan.concretado) AS cierres
    FROM GRUPO_1.BI_Anuncios BIan 
    JOIN GRUPO_1.BI_Tiempo BItemp ON BIan.tiempo_id = BItemp.tiempo_id 
	JOIN GRUPO_1.BI_Sucursal BIs ON BIan.sucursal_id = BIs.sucursal_id 
	JOIN GRUPO_1.BI_RangoEdad BIr ON BIan.rango_edad = BIr.rango_id
        WHERE BIan.concretado = 1
        GROUP BY BIs.nombre, BIr.descripcion, BItemp.anio) AS sub ON 
    sub2.sucursal = sub.sucursal 
    AND sub2.rangoEdad = sub.rangoEdad 
    AND sub2.año = sub.año)
GROUP BY sub.sucursal, sub.rangoEdad, sub.año, sub.cierres, sub2.total
GO

GO
CREATE VIEW Punto9_MontoTotal AS
WITH AlquileresVentas AS (
	SELECT 
	*
	FROM 
		(SELECT 'Alquiler' AS tipoOperacion, tiempo_id, sucursal_id, tipoMoneda_id, montoTotal FROM GRUPO_1.BI_alquileres
		 UNION ALL
		 SELECT 'Ventas' AS tipoOperacion, tiempo_id, sucursal_id, tipoMoneda_id, precioVendido FROM GRUPO_1.BI_Ventas) AS alquileresVentas
)
SELECT 
	tipoOperacion,
	Bitemp.cuatrimestre,
	BItemp.anio,
	BIs.nombre AS sucursal,
	BItm.nombre AS moneda,
	SUM(montoTotal) as montoTotal
FROM AlquileresVentas av
	JOIN GRUPO_1.BI_Tiempo Bitemp ON av.tiempo_id = BItemp.tiempo_id
	JOIN GRUPO_1.BI_Sucursal BIs ON av.sucursal_id = BIs.sucursal_id
	JOIN GRUPO_1.BI_TipoMoneda BItm ON av.tipoMoneda_id = BItm.tipo_id
GROUP BY tipoOperacion, Bitemp.cuatrimestre, Bitemp.anio, BIs.nombre, BItm.nombre
GO

-------------------------------------
------ EJECUCION MIGRACIONES --------
-------------------------------------

BEGIN TRANSACTION;
	EXECUTE GRUPO_1.BI_MigrarTiempo;
	EXECUTE GRUPO_1.BI_MigrarRangoSuperficie;
	EXECUTE GRUPO_1.BI_MigrarTipoMoneda;
	EXECUTE GRUPO_1.BI_MigrarAmbientes;
    EXECUTE GRUPO_1.BI_MigrarRangoEdad;
	EXECUTE GRUPO_1.BI_MigrarUbicaciones;
    EXECUTE GRUPO_1.BI_MigrarSucursales;
    EXECUTE GRUPO_1.BI_MigrarTiposOperaciones;
	EXECUTE GRUPO_1.BI_MigrarTipoInmueble;
    EXECUTE GRUPO_1.BI_MigrarAnuncios;
    EXECUTE GRUPO_1.BI_MigrarPagos;
	EXECUTE GRUPO_1.BI_MigrarAlquileres
	EXECUTE GRUPO_1.BI_MigrarVentas;
COMMIT TRANSACTION;

	DROP PROCEDURE GRUPO_1.BI_MigrarTiempo;
	DROP PROCEDURE GRUPO_1.BI_MigrarRangoSuperficie;
	DROP PROCEDURE GRUPO_1.BI_MigrarTipoMoneda;
	DROP PROCEDURE GRUPO_1.BI_MigrarAmbientes;
    DROP PROCEDURE GRUPO_1.BI_MigrarRangoEdad;
	DROP PROCEDURE GRUPO_1.BI_MigrarUbicaciones;
    DROP PROCEDURE GRUPO_1.BI_MigrarSucursales;
    DROP PROCEDURE GRUPO_1.BI_MigrarTiposOperaciones;
	DROP PROCEDURE GRUPO_1.BI_MigrarTipoInmueble;
    DROP PROCEDURE GRUPO_1.BI_MigrarAnuncios;
    DROP PROCEDURE GRUPO_1.BI_MigrarPagos;
	DROP PROCEDURE GRUPO_1.BI_MigrarAlquileres;
	DROP PROCEDURE GRUPO_1.BI_MigrarVentas;

	DROP FUNCTION GRUPO_1.CUATRIMESTRE	
	DROP FUNCTION GRUPO_1.RANGO_EDAD
	DROP FUNCTION GRUPO_1.RANGO_EDAD_STRING	
	DROP FUNCTION GRUPO_1.TIPO_OPERACION


/*

-------------------------------------
--------------- TESTS ---------------
-------------------------------------

SELECT * FROM Punto1_DuracionPromedioAnunciosPublicados
SELECT * FROM Punto2_PrecioPromedioAnunciosInmuebles
SELECT * FROM Punto3_BarriosMasElegidosParaAlquilar
SELECT * FROM Punto4_PorcentajeIncumplimientoPagosAlquileres
SELECT * FROM Punto5_PorcentajePromedioIncrementoValorAlquileres
SELECT * FROM Punto6_PrecioPromedioM2Ventas
SELECT * FROM Punto7_ValorPromedioComision
SELECT * FROM Punto8_PorcentajeCierreAnuncios
SELECT * FROM Punto9_MontoTotal
	
*/
