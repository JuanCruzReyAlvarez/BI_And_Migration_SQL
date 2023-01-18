USE [GD2C2022]
GO

CREATE TABLE [PANINI_GDD].[BI_DIM_TIEMPO](
    [ID_FECHA] decimal(19,0) IDENTITY(1,1),
    [MES] INT,
    [ANIO] INT,
    PRIMARY KEY  ([ID_FECHA])
);

GO

CREATE TABLE [PANINI_GDD].[BI_DIM_PROVINCIA](
    [CODIGO_PROVINCIA] decimal(19,0),
    [NOMBRE_PROV] nvarchar(255),
    PRIMARY KEY ([CODIGO_PROVINCIA])
);

GO

CREATE TABLE [PANINI_GDD].[BI_DIM_RANGO_ETARIO](
  [ID_RANGO_ETARIO] decimal(19,0) IDENTITY (1,1),
  [RANGO_ETARIO] nvarchar(255),
  PRIMARY KEY ([ID_RANGO_ETARIO]) 
);

GO

CREATE TABLE [PANINI_GDD].[BI_DIM_CANAL_VENTA](
  [ID_CANAL_VENTA] decimal(19,0),
  [CANAL_VENTA] nvarchar(255),
  PRIMARY KEY ([ID_CANAL_VENTA])
);

GO

CREATE TABLE [PANINI_GDD].[BI_DIM_MEDIO_PAGO](
  [ID_MEDIO_PAGO] decimal(19,0),
  [MEDIO_PAGO] nvarchar(255),
  PRIMARY KEY ([ID_MEDIO_PAGO])  
);

GO

CREATE TABLE [PANINI_GDD].[BI_DIM_CATEGORIA_PRODUCTO](
  [ID_CATEGORIA] decimal(19,0),
  [CATEGORIA] nvarchar(255),
  PRIMARY KEY ([ID_CATEGORIA])
);

GO

CREATE TABLE [PANINI_GDD].[BI_DIM_PRODUCTO](
  [COD_PROD] nvarchar(50),
  [NOMBRE_PROD] nvarchar(50),
  [DESCRIPCION_PROD] nvarchar(50),
  PRIMARY KEY ([COD_PROD])
);

GO

CREATE TABLE [PANINI_GDD].[BI_DIM_TIPO_DESCUENTO](
  [ID_TIPO_DESCUENTO] decimal(19,0) IDENTITY(1,1),
  [TIPO_DESCUENTO] char(20),
  PRIMARY KEY ([ID_TIPO_DESCUENTO])
);

GO

CREATE TABLE [PANINI_GDD].[BI_DIM_TIPO_ENVIO](
  [ID_MEDIO_ENVIO] decimal(19,0),
  [MEDIO] nvarchar(255),
  PRIMARY KEY ([ID_MEDIO_ENVIO])
);
GO

CREATE TABLE [PANINI_GDD].[BI_DIM_PROVEEDOR](
  [ID_PROVEEDOR] nvarchar(50), --es el cuit
  [RAZON_SOCIAL_PROV] nvarchar(255)
  PRIMARY KEY ([ID_PROVEEDOR])
)
GO

CREATE TABLE [PANINI_GDD].[BI_HECHOS_COMPRAS](
    [ID_FECHA] decimal(19,0), --fk
    [ID_PROVEEDOR] nvarchar(50), --fk
    [COD_PROD] nvarchar(50), --fk
    [TOTAL_PRODUCTO] decimal(18,2),
    [CANTIDAD_PRODUCTO] decimal(19,0),

	PRIMARY KEY ([ID_FECHA],[ID_PROVEEDOR],[COD_PROD])
);
GO


CREATE TABLE [PANINI_GDD].[BI_HECHOS_ENVIO](
  [ID_FECHA] decimal(19,0), --fk
  [CODIGO_PROVINCIA] decimal(19,0), --fk
  [ID_MEDIO_ENVIO] decimal(19,0),
  [MEDIO_ENVIO_COSTO] decimal(18,2)
  PRIMARY KEY ([ID_FECHA],[CODIGO_PROVINCIA],[ID_MEDIO_ENVIO])
);

CREATE TABLE [PANINI_GDD].[BI_HECHOS_CANAL_VENTA](
 [ID_CANAL_VENTA] decimal(19,0), --fk
 [ID_FECHA] decimal(19,0), --fk
 [CODIGO_PROVINCIA] decimal(19,0), --fk                                                               
 [GANANCIA_CANAL_VENTA_MENSUAL] decimal(18,2),

 PRIMARY KEY ([ID_CANAL_VENTA],[ID_FECHA],[CODIGO_PROVINCIA])
);


CREATE TABLE [PANINI_GDD].[BI_HECHOS_MEDIO_PAGO](
 [ID_MEDIO_PAGO] decimal(19,0), --fk
 [ID_FECHA] decimal(19,0), --fk
 [CODIGO_PROVINCIA] decimal(19,0), --fk
 [MEDIO_PAGO_COSTO] decimal(18,2),
 [TOTAL_GANANCIA_MES] decimal(18,2),
 PRIMARY KEY ([ID_MEDIO_PAGO],[ID_FECHA],[CODIGO_PROVINCIA] )
);



CREATE TABLE [PANINI_GDD].[BI_HECHOS_VENTAS](
    [ID_FECHA] decimal(19,0), --fk
    [CODIGO_PROVINCIA] decimal(19,0), --fk
    [ID_RANGO_ETARIO] decimal(19,0), --fk
    [ID_CANAL_VENTA] decimal(19,0), --fk
    [ID_MEDIO_PAGO] decimal(19,0), --fk
    [ID_CATEGORIA] decimal(19,0), --fk
    [COD_PROD] nvarchar(50), --fk
    [ID_MEDIO_ENVIO] decimal(19,0), --fk
    [CANTIDAD_PRODUCTO] decimal(19,0),
    [TOTAL_PRODUCTO] decimal(18,2), --el precio unitario

    [TOTAL_VENTA] decimal(18,2) --NETO                   

	PRIMARY KEY ([ID_FECHA],[CODIGO_PROVINCIA],[ID_RANGO_ETARIO], [ID_CANAL_VENTA],[ID_MEDIO_PAGO],[ID_CATEGORIA], [COD_PROD],[ID_MEDIO_ENVIO])
);
GO


CREATE TABLE [PANINI_GDD].[BI_HECHOS_DESCUENTOS]( --de ventas
  [ID_TIPO_DESCUENTO] decimal(19,0), --FK
  [ID_FECHA] DECIMAL(19,0), --fk
  [ID_CANAL_VENTA] decimal(19,0), --fk
  [TOTAL_DESCUENTO] DECIMAL(18,2),
	PRIMARY KEY ( [ID_TIPO_DESCUENTO],[ID_FECHA],[ID_CANAL_VENTA])
);
GO


ALTER TABLE [PANINI_GDD].[BI_HECHOS_VENTAS] ADD CONSTRAINT [ID_FECHA] FOREIGN KEY ([ID_FECHA]) REFERENCES [PANINI_GDD].[BI_DIM_TIEMPO]([ID_FECHA])
ALTER TABLE [PANINI_GDD].[BI_HECHOS_VENTAS] ADD CONSTRAINT [CODIGO_PROVINCIA] FOREIGN KEY ([CODIGO_PROVINCIA]) REFERENCES [PANINI_GDD].[BI_DIM_PROVINCIA]([CODIGO_PROVINCIA])
ALTER TABLE [PANINI_GDD].[BI_HECHOS_VENTAS] ADD CONSTRAINT [ID_RANGO_ETARIO] FOREIGN KEY ([ID_RANGO_ETARIO]) REFERENCES [PANINI_GDD].[BI_DIM_RANGO_ETARIO]([ID_RANGO_ETARIO])
ALTER TABLE [PANINI_GDD].[BI_HECHOS_VENTAS] ADD CONSTRAINT [ID_CANAL_VENTA] FOREIGN KEY ([ID_CANAL_VENTA]) REFERENCES [PANINI_GDD].[BI_DIM_CANAL_VENTA]([ID_CANAL_VENTA])
ALTER TABLE [PANINI_GDD].[BI_HECHOS_VENTAS] ADD CONSTRAINT [ID_MEDIO_PAGO] FOREIGN KEY ([ID_MEDIO_PAGO]) REFERENCES [PANINI_GDD].[BI_DIM_MEDIO_PAGO]([ID_MEDIO_PAGO])  
ALTER TABLE [PANINI_GDD].[BI_HECHOS_VENTAS] ADD CONSTRAINT [ID_CATEGORIA] FOREIGN KEY ([ID_CATEGORIA]) REFERENCES [PANINI_GDD].[BI_DIM_CATEGORIA_PRODUCTO]([ID_CATEGORIA])
ALTER TABLE [PANINI_GDD].[BI_HECHOS_VENTAS] ADD CONSTRAINT [COD_PROD] FOREIGN KEY ([COD_PROD]) REFERENCES [PANINI_GDD].[BI_DIM_PRODUCTO]([COD_PROD])
ALTER TABLE [PANINI_GDD].[BI_HECHOS_VENTAS] ADD CONSTRAINT [ID_MEDIO_ENVIO] FOREIGN KEY ([ID_MEDIO_ENVIO]) REFERENCES [PANINI_GDD].[BI_DIM_TIPO_ENVIO]([ID_MEDIO_ENVIO])


ALTER TABLE [PANINI_GDD].[BI_HECHOS_COMPRAS] ADD CONSTRAINT [FK_COMPRA_ID_FECHA] FOREIGN KEY ([ID_FECHA]) REFERENCES [PANINI_GDD].[BI_DIM_TIEMPO]([ID_FECHA])
ALTER TABLE [PANINI_GDD].[BI_HECHOS_COMPRAS] ADD CONSTRAINT [FK_ID_PROVEEDOR] FOREIGN KEY ([ID_PROVEEDOR]) REFERENCES [PANINI_GDD].[BI_DIM_PROVEEDOR]([ID_PROVEEDOR])
ALTER TABLE [PANINI_GDD].[BI_HECHOS_COMPRAS] ADD CONSTRAINT [FK_COD_PROD] FOREIGN KEY ([COD_PROD]) REFERENCES [PANINI_GDD].[BI_DIM_PRODUCTO]([COD_PROD])


ALTER TABLE [PANINI_GDD].[BI_HECHOS_DESCUENTOS] ADD CONSTRAINT [FK_DESCUENTO.ID_FECHA] FOREIGN KEY ([ID_FECHA]) REFERENCES [PANINI_GDD].[BI_DIM_TIEMPO]([ID_FECHA])
ALTER TABLE [PANINI_GDD].[BI_HECHOS_DESCUENTOS] ADD CONSTRAINT [ID_TIPO_DESCUENTO] FOREIGN KEY ([ID_TIPO_DESCUENTO]) REFERENCES [PANINI_GDD].[BI_DIM_TIPO_DESCUENTO]([ID_TIPO_DESCUENTO])

ALTER TABLE [PANINI_GDD].[BI_HECHOS_CANAL_VENTA] ADD CONSTRAINT [FK_ID_CANAL_VENTA] FOREIGN KEY ([ID_CANAL_VENTA]) REFERENCES [PANINI_GDD].[BI_DIM_CANAL_VENTA]([ID_CANAL_VENTA])
ALTER TABLE [PANINI_GDD].[BI_HECHOS_CANAL_VENTA] ADD CONSTRAINT [FK_ID_FECHA] FOREIGN KEY ([ID_FECHA]) REFERENCES [PANINI_GDD].[BI_DIM_TIEMPO]([ID_FECHA])
ALTER TABLE [PANINI_GDD].[BI_HECHOS_CANAL_VENTA] ADD CONSTRAINT [FK_CODIGO_PROVINCIA]  FOREIGN KEY ([CODIGO_PROVINCIA]) REFERENCES [PANINI_GDD].[BI_DIM_PROVINCIA]([CODIGO_PROVINCIA])

ALTER TABLE [PANINI_GDD].[BI_HECHOS_MEDIO_PAGO] ADD CONSTRAINT [FK_MP_ID_MEDIO_PAGO] FOREIGN KEY ([ID_MEDIO_PAGO]) REFERENCES [PANINI_GDD].[BI_DIM_MEDIO_PAGO]([ID_MEDIO_PAGO])
ALTER TABLE [PANINI_GDD].[BI_HECHOS_MEDIO_PAGO] ADD CONSTRAINT [FK_MP_ID_FECHA] FOREIGN KEY ([ID_FECHA]) REFERENCES [PANINI_GDD].[BI_DIM_TIEMPO]([ID_FECHA])
ALTER TABLE [PANINI_GDD].[BI_HECHOS_MEDIO_PAGO] ADD CONSTRAINT [FK_MP_CODIGO_PROVINCIA] FOREIGN KEY ([CODIGO_PROVINCIA]) REFERENCES [PANINI_GDD].[BI_DIM_PROVINCIA]([CODIGO_PROVINCIA])

ALTER TABLE [PANINI_GDD].[BI_HECHOS_ENVIO] ADD CONSTRAINT [FK_E_ID_FECHA] FOREIGN KEY ([ID_FECHA]) REFERENCES [PANINI_GDD].[BI_DIM_TIEMPO]([ID_FECHA])
ALTER TABLE [PANINI_GDD].[BI_HECHOS_ENVIO] ADD CONSTRAINT [FK_E_CODIGO_PROVINCIA] FOREIGN KEY ([CODIGO_PROVINCIA]) REFERENCES [PANINI_GDD].[BI_DIM_PROVINCIA]([CODIGO_PROVINCIA])
ALTER TABLE [PANINI_GDD].[BI_HECHOS_ENVIO] ADD CONSTRAINT [FK_E_ID_MEDIO_ENVIO] FOREIGN KEY ([ID_MEDIO_ENVIO]) REFERENCES [PANINI_GDD].[BI_DIM_TIPO_ENVIO]([ID_MEDIO_ENVIO])

ALTER TABLE [PANINI_GDD].[BI_HECHOS_DESCUENTOS] ADD CONSTRAINT [FK_E_ID_TIPO_DESCUENTO] FOREIGN KEY ([ID_TIPO_DESCUENTO]) REFERENCES [PANINI_GDD].[BI_DIM_TIPO_DESCUENTO]([ID_TIPO_DESCUENTO])
ALTER TABLE [PANINI_GDD].[BI_HECHOS_DESCUENTOS] ADD CONSTRAINT [FK_D_ID_FECHA] FOREIGN KEY ([ID_FECHA]) REFERENCES [PANINI_GDD].[BI_DIM_TIEMPO]([ID_FECHA])
ALTER TABLE [PANINI_GDD].[BI_HECHOS_DESCUENTOS] ADD CONSTRAINT [FK_E_ID_CANAL_VENTA] FOREIGN KEY ([ID_CANAL_VENTA]) REFERENCES [PANINI_GDD].[BI_DIM_CANAL_VENTA]([ID_CANAL_VENTA])


--MIGRACION
GO

CREATE PROCEDURE [PANINI_GDD].[cargar_tiempo] AS
    BEGIN
        INSERT INTO [PANINI_GDD].[BI_DIM_TIEMPO] (ANIO, MES)
            SELECT DISTINCT YEAR(FECHA_COMPRA), MONTH(FECHA_COMPRA)
                FROM [PANINI_GDD].COMPRA
            UNION
             SELECT DISTINCT YEAR(FECHA_VENTA), MONTH(FECHA_VENTA)
                FROM [PANINI_GDD].VENTA
    END
GO

CREATE PROCEDURE [PANINI_GDD].[cargar_rangos_etarios] AS
    BEGIN
        INSERT INTO [PANINI_GDD].[BI_DIM_RANGO_ETARIO] (RANGO_ETARIO) VALUES ('<25'), ('[25-35)'), ('[35-55]'), ('>55')
    END
GO

CREATE PROCEDURE [PANINI_GDD].[cargar_provincias] AS
    BEGIN
        INSERT INTO [PANINI_GDD].[BI_DIM_PROVINCIA] (CODIGO_PROVINCIA,NOMBRE_PROV) 
        SELECT CODIGO_PROVINCIA,NOMBRE_PROV FROM [PANINI_GDD].[PROVINCIA]
    END
GO

CREATE PROCEDURE [PANINI_GDD].[cargar_canales_venta] AS
    BEGIN
        INSERT INTO [PANINI_GDD].[BI_DIM_CANAL_VENTA] (ID_CANAL_VENTA,CANAL_VENTA) 
        SELECT ID_CANAL_VENTA,CANAL_VENTA FROM [PANINI_GDD].[CANAL_VENTA]
    END
GO



CREATE PROCEDURE [PANINI_GDD].[cargar_medios_pago] AS
    BEGIN
        INSERT INTO [PANINI_GDD].[BI_DIM_MEDIO_PAGO] (ID_MEDIO_PAGO,MEDIO_PAGO) 
		
        SELECT DISTINCT ID_MEDIO_PAGO, MEDIO_PAGO FROM [PANINI_GDD].[MEDIO_DE_PAGO] 
    END
GO


CREATE PROCEDURE [PANINI_GDD].[cargar_categorias_prod] AS
    BEGIN
        INSERT INTO [PANINI_GDD].[BI_DIM_CATEGORIA_PRODUCTO] (ID_CATEGORIA,CATEGORIA) 
        SELECT ID_CATEGORIA,CATEGORIA FROM [PANINI_GDD].[CATEGORIA]
    END
GO

CREATE PROCEDURE [PANINI_GDD].[cargar_productos] AS
    BEGIN
        INSERT INTO [PANINI_GDD].[BI_DIM_PRODUCTO] (COD_PROD,NOMBRE_PROD,DESCRIPCION_PROD) 
        SELECT COD_PROD,NOMBRE_PROD,DESCRIPCION_PROD FROM [PANINI_GDD].[PRODUCTO]
    END
GO


CREATE PROCEDURE [PANINI_GDD].[cargar_tipos_descuento] AS
    BEGIN
        INSERT INTO [PANINI_GDD].[BI_DIM_TIPO_DESCUENTO] (TIPO_DESCUENTO) 
        VALUES ('FIJO'),('CUPON'),('MEDIO_PAGO')
    END
GO

CREATE PROCEDURE [PANINI_GDD].[cargar_tipos_envio] AS
    BEGIN
        INSERT INTO [PANINI_GDD].[BI_DIM_TIPO_ENVIO] (ID_MEDIO_ENVIO,MEDIO) 
        SELECT DISTINCT ID_MEDIO_ENVIO,MEDIO FROM [PANINI_GDD].[MEDIO_ENVIO_X_CODIGO_POSTAL]
    END
GO


CREATE PROCEDURE [PANINI_GDD].[cargar_proveedores] AS
    BEGIN
        INSERT INTO [PANINI_GDD].[BI_DIM_PROVEEDOR] (ID_PROVEEDOR,RAZON_SOCIAL_PROV) 
        SELECT DISTINCT CUIT_PROV,RAZON_SOCIAL_PROV FROM [PANINI_GDD].[PROVEEDOR]
    END
GO


CREATE PROCEDURE [PANINI_GDD].[cargar_compras] AS
    BEGIN
      DECLARE @fechaCompra DATE, @medioPagoId decimal(19,0),@totalCompra decimal(18,2),@cuit nvarchar(50), @codCompra decimal(19,0)
      DECLARE comc CURSOR FOR 
	    SELECT FECHA_COMPRA,ID_MEDIO_PAGO,CUIT_PROV,COD_COMPRA FROM [PANINI_GDD].COMPRA
      OPEN comc
      FETCH NEXT FROM comc INTO @fechaCompra, @medioPagoId,@cuit,@codCompra 
      WHILE(@@FETCH_STATUS = 0)
      BEGIN

        DECLARE @cantidad decimal(19,0),@precioUnit decimal(18,2),@precioTotalProd decimal(18,2),@codigoProductoVar nvarchar(50)
        DECLARE comcp CURSOR FOR SELECT CANTIDAD,PRECIO_UNIT,PRECIO_TOTAL,COD_PRODUCTO_VARIANTE FROM [PANINI_GDD].COMPRA_PRODUCTO WHERE COD_COMPRA=@codCompra
        OPEN comcp
		    FETCH NEXT FROM comcp INTO @cantidad,@precioUnit,@precioTotalProd,@codigoProductoVar
        WHILE(@@FETCH_STATUS = 0)
        BEGIN 
          IF NOT EXISTS (SELECT 1 FROM [PANINI_GDD].[BI_HECHOS_COMPRAS] WHERE ID_FECHA = [PANINI_GDD].[obtener_id_tiempo](@fechaCompra) 
          AND ID_PROVEEDOR = @cuit AND COD_PROD = [PANINI_GDD].[obtener_codigo_producto](@codigoProductoVar))
          BEGIN
            INSERT INTO [PANINI_GDD].[BI_HECHOS_COMPRAS] (ID_FECHA,ID_PROVEEDOR,COD_PROD,TOTAL_PRODUCTO,CANTIDAD_PRODUCTO)
            VALUES ([PANINI_GDD].[obtener_id_tiempo](@fechaCompra),@cuit,[PANINI_GDD].[obtener_codigo_producto](@codigoProductoVar),
            @precioTotalProd,@cantidad)
          END
          ELSE
          BEGIN
            UPDATE [PANINI_GDD].[BI_HECHOS_COMPRAS] 
            SET CANTIDAD_PRODUCTO+=@cantidad,TOTAL_PRODUCTO+=@precioTotalProd
            WHERE ID_FECHA = [PANINI_GDD].[obtener_id_tiempo](@fechaCompra) 
            AND ID_PROVEEDOR = @cuit AND COD_PROD = [PANINI_GDD].[obtener_codigo_producto](@codigoProductoVar)
          END
          FETCH NEXT FROM comcp INTO @cantidad,@precioUnit,@precioTotalProd,@codigoProductoVar
        END
        CLOSE comcp
        DEALLOCATE comcp
        FETCH NEXT FROM comc INTO @fechaCompra, @medioPagoId,@cuit,@codCompra
      END
      CLOSE comc
      DEALLOCATE comc
    END
GO

CREATE PROCEDURE [PANINI_GDD].[cargar_ventas] AS
    BEGIN
      DECLARE @codVenta decimal(19,0),@fecha DATE,@idCliente decimal(19,0),@idCanalVenta decimal(19,0),@idMedioEnvio decimal(19,0),
      @idMedioPago decimal(19,0),@precioEnvio decimal(18,2),@costoTransaccion decimal(18,2),@totalVenta decimal(18,2)
      DECLARE cven CURSOR FOR
      SELECT COD_VENTA,FECHA_VENTA,ID_CLIENTE,ID_CANAL_VENTA,ID_MEDIO_ENVIO,ID_MEDIO_PAGO,PRECIO_ENVIO,COSTO_TRANSACCION,TOTAL_VENTA
      FROM [PANINI_GDD].VENTA
      OPEN cven
      FETCH NEXT FROM cven INTO @codVenta,@fecha,@idCliente,@idCanalVenta,@idMedioEnvio,
      @idMedioPago ,@precioEnvio ,@costoTransaccion,@totalVenta
      WHILE(@@FETCH_STATUS = 0)
      BEGIN
        DECLARE @idDesc decimal(19,0),@idTiempo decimal(19,0),@valor decimal(18,2),@totalDescuento decimal(18,2)
        SET @totalDescuento=0
        DECLARE cccc CURSOR FOR 
        SELECT [PANINI_GDD].[obtener_id_tipo_descuento]('MEDIO_PAGO'),[PANINI_GDD].[obtener_id_tiempo](@fecha),VALOR_DESC FROM MEDIO_DE_PAGO WHERE ID_MEDIO_PAGO=@idMedioPago
        UNION
        SELECT [PANINI_GDD].[obtener_id_tipo_descuento]('CUPON'),[PANINI_GDD].[obtener_id_tiempo](@fecha),IMPORTE FROM VENTA_MEDIANTE_CUPON WHERE COD_VENTA=@codVenta
        UNION
        SELECT [PANINI_GDD].[obtener_id_tipo_descuento]('FIJO'),[PANINI_GDD].[obtener_id_tiempo](@fecha),IMPORTE FROM VENTA_MEDIANTE_DESCUENTO_FIJO WHERE COD_VENTA=@codVenta
        OPEN cccc
        FETCH NEXT FROM cccc INTO @idDesc,@idTiempo,@valor
        WHILE(@@FETCH_STATUS=0)
		BEGIN
          IF NOT EXISTS(SELECT 1 FROM [PANINI_GDD].[BI_HECHOS_DESCUENTOS] WHERE ID_TIPO_DESCUENTO=@idDesc AND ID_FECHA=@idTiempo AND ID_CANAL_VENTA=@idCanalVenta)
          INSERT INTO [PANINI_GDD].[BI_HECHOS_DESCUENTOS] (ID_TIPO_DESCUENTO,ID_FECHA,TOTAL_DESCUENTO,ID_CANAL_VENTA)
          VALUES (@idDesc,@idTiempo,@valor,@idCanalVenta)
          ELSE 
          UPDATE [PANINI_GDD].[BI_HECHOS_DESCUENTOS]
          SET TOTAL_DESCUENTO+=@valor
          WHERE ID_TIPO_DESCUENTO=@idDesc AND ID_FECHA=@idTiempo AND ID_CANAL_VENTA=@idCanalVenta
 
          SET @totalDescuento+=@valor
          FETCH NEXT FROM cccc INTO @idDesc,@idTiempo,@valor
        END
   
        CLOSE cccc
        DEALLOCATE cccc

        DECLARE @cantidad decimal(19,0),@precioUnit decimal(18,2),@precioTotalProd decimal(18,2),@codProdVar nvarchar(50)
        DECLARE cvenp CURSOR FOR
        SELECT CANTIDAD,PRECIO_UNIT,PRECIO_TOTAL,COD_PRODUCTO_VARIANTE FROM [PANINI_GDD].VENTA_PRODUCTO WHERE COD_VENTA=@codVenta
        OPEN cvenp
        FETCH NEXT FROM cvenp INTO @cantidad,@precioUnit,@precioTotalProd,@codProdVar
        WHILE(@@FETCH_STATUS = 0)
        BEGIN
          IF NOT EXISTS (SELECT 1 FROM [PANINI_GDD].[BI_HECHOS_VENTAS] 
          WHERE ID_FECHA= [PANINI_GDD].[obtener_id_tiempo](@fecha) AND CODIGO_PROVINCIA=[PANINI_GDD].[obtener_id_provincia](@idMedioEnvio) 
          AND ID_RANGO_ETARIO=[PANINI_GDD].[obtener_id_rango_etario]((SELECT FECHA_NAC_CLIENTE FROM CLIENTE WHERE ID_CLIENTE=@idCliente))
          AND ID_CANAL_VENTA=@idCanalVenta AND ID_MEDIO_PAGO=@idMedioPago AND ID_CATEGORIA=[PANINI_GDD].[obtener_id_categoria](@codProdVar)
          AND COD_PROD=[PANINI_GDD].[obtener_codigo_producto](@codProdVar)
          AND ID_MEDIO_ENVIO=@idMedioEnvio)
          BEGIN
            INSERT INTO [PANINI_GDD].[BI_HECHOS_VENTAS] 
            (ID_FECHA,CODIGO_PROVINCIA,ID_RANGO_ETARIO,ID_CANAL_VENTA,ID_MEDIO_PAGO,ID_CATEGORIA
            ,COD_PROD,ID_MEDIO_ENVIO,CANTIDAD_PRODUCTO,TOTAL_PRODUCTO,TOTAL_VENTA)
            VALUES ([PANINI_GDD].[obtener_id_tiempo](@fecha),[PANINI_GDD].[obtener_id_provincia](@idMedioEnvio),
            [PANINI_GDD].[obtener_id_rango_etario]((SELECT FECHA_NAC_CLIENTE FROM CLIENTE WHERE ID_CLIENTE=@idCliente)),
            @idCanalVenta,@idMedioPago,[PANINI_GDD].[obtener_id_categoria](@codProdVar),[PANINI_GDD].[obtener_codigo_producto](@codProdVar),
            @idMedioEnvio,@cantidad,@precioTotalProd,@totalVenta)
          END
          ELSE
          BEGIN
            UPDATE [PANINI_GDD].[BI_HECHOS_VENTAS]
            SET CANTIDAD_PRODUCTO+=@cantidad, TOTAL_PRODUCTO+=@precioTotalProd
            WHERE ID_FECHA= [PANINI_GDD].[obtener_id_tiempo](@fecha) AND CODIGO_PROVINCIA=[PANINI_GDD].[obtener_id_provincia](@idMedioEnvio) 
            AND ID_RANGO_ETARIO=[PANINI_GDD].[obtener_id_rango_etario]((SELECT FECHA_NAC_CLIENTE FROM CLIENTE WHERE ID_CLIENTE=@idCliente))
            AND ID_CANAL_VENTA=@idCanalVenta AND ID_MEDIO_PAGO=@idMedioPago AND ID_CATEGORIA=[PANINI_GDD].[obtener_id_categoria](@codProdVar)
            AND COD_PROD=[PANINI_GDD].[obtener_codigo_producto](@codProdVar)
            AND ID_MEDIO_ENVIO=@idMedioEnvio
          END
          FETCH NEXT FROM cvenp INTO @cantidad,@precioUnit,@precioTotalProd,@codProdVar

        END
        CLOSE cvenp
        DEALLOCATE cvenp

        IF NOT EXISTS (SELECT 1 FROM [PANINI_GDD].[BI_HECHOS_ENVIO] 
        WHERE ID_FECHA=[PANINI_GDD].[obtener_id_tiempo](@fecha) 
        AND CODIGO_PROVINCIA=[PANINI_GDD].[obtener_id_provincia](@idMedioEnvio) AND ID_MEDIO_ENVIO=@idMedioEnvio AND MEDIO_ENVIO_COSTO=@precioEnvio)
        INSERT INTO [PANINI_GDD].[BI_HECHOS_ENVIO] (ID_FECHA,CODIGO_PROVINCIA,ID_MEDIO_ENVIO,MEDIO_ENVIO_COSTO)
        VALUES ([PANINI_GDD].[obtener_id_tiempo](@fecha),
        [PANINI_GDD].[obtener_id_provincia](@idMedioEnvio),@idMedioEnvio,@precioEnvio)

        IF NOT EXISTS (SELECT 1 FROM [PANINI_GDD].[BI_HECHOS_CANAL_VENTA] WHERE ID_FECHA=[PANINI_GDD].[obtener_id_tiempo](@fecha) 
        AND CODIGO_PROVINCIA=[PANINI_GDD].[obtener_id_provincia](@idMedioEnvio) AND ID_CANAL_VENTA=@idCanalVenta )
        INSERT INTO [PANINI_GDD].[BI_HECHOS_CANAL_VENTA] (ID_FECHA,CODIGO_PROVINCIA,ID_CANAL_VENTA,GANANCIA_CANAL_VENTA_MENSUAL)
        VALUES ([PANINI_GDD].[obtener_id_tiempo](@fecha),
        [PANINI_GDD].[obtener_id_provincia](@idMedioEnvio),@idCanalVenta,[PANINI_GDD].[obtener_ganancias_canal_venta](DATEPART(MONTH,@fecha),DATEPART(YEAR,@fecha), @idCanalVenta)) 
        
        IF NOT EXISTS (SELECT 1 FROM [PANINI_GDD].[BI_HECHOS_MEDIO_PAGO] WHERE ID_FECHA=[PANINI_GDD].[obtener_id_tiempo](@fecha) 
        AND CODIGO_PROVINCIA=[PANINI_GDD].[obtener_id_provincia](@idMedioEnvio) AND ID_MEDIO_PAGO=@idMedioPago)
        INSERT INTO [PANINI_GDD].[BI_HECHOS_MEDIO_PAGO] (ID_FECHA,CODIGO_PROVINCIA,ID_MEDIO_PAGO,MEDIO_PAGO_COSTO,TOTAL_GANANCIA_MES)
        VALUES ([PANINI_GDD].[obtener_id_tiempo](@fecha),
        [PANINI_GDD].[obtener_id_provincia](@idMedioEnvio),@idMedioPago,@costoTransaccion,[PANINI_GDD].[obtener_ganancias_medio_pago](DATEPART(MONTH,@fecha),DATEPART(YEAR,@fecha),@idMedioPago))


        FETCH NEXT FROM cven INTO @codVenta,@fecha,@idCliente,@idCanalVenta,@idMedioEnvio,
        @idMedioPago ,@precioEnvio ,@costoTransaccion, @totalVenta 
      END 
      CLOSE cven
      DEALLOCATE cven
    END
GO



--FUNCIONES:

CREATE FUNCTION [PANINI_GDD].[obtener_id_rango_etario](@fecha DATE) RETURNS DECIMAL(19,0) AS
	BEGIN
		DECLARE @edad_id DECIMAL(19,0), @edad INT, @fecha_actual DATE
		SELECT @edad = (DATEDIFF(DAY, @fecha, GETDATE()) / 365)

		SELECT @edad_id =
			CASE 
				WHEN @edad BETWEEN 0 AND 24 THEN (SELECT ID_RANGO_ETARIO FROM [PANINI_GDD].[BI_DIM_RANGO_ETARIO] WHERE RANGO_ETARIO = '<25')
				WHEN @edad BETWEEN 25 AND 34 THEN (SELECT ID_RANGO_ETARIO FROM [PANINI_GDD].[BI_DIM_RANGO_ETARIO] WHERE RANGO_ETARIO = '[25-35)')
        WHEN @edad BETWEEN 35 AND 55 THEN (SELECT ID_RANGO_ETARIO FROM [PANINI_GDD].[BI_DIM_RANGO_ETARIO] WHERE RANGO_ETARIO = '[35-55]')
				ELSE (SELECT ID_RANGO_ETARIO FROM [PANINI_GDD].[BI_DIM_RANGO_ETARIO] WHERE RANGO_ETARIO = '>55')
			END

		RETURN @edad_id
	END
GO


CREATE FUNCTION [PANINI_GDD].[obtener_ganancias_medio_pago](@mes INT, @anio INT,@idMedioPago decimal(19,0)) RETURNS DECIMAL(18,2) AS
  BEGIN
    DECLARE @cant DECIMAL(18,2)
    SET @cant= (SELECT SUM(v.TOTAL_VENTA) 
    FROM [PANINI_GDD].[VENTA] v 
    WHERE DATEPART(YEAR,v.FECHA_VENTA)=@anio AND DATEPART(MONTH,v.FECHA_VENTA)=@mes AND v.ID_MEDIO_PAGO=@idMedioPago)   
    RETURN @cant
  END
GO



CREATE FUNCTION [PANINI_GDD].[obtener_id_tiempo](@fecha DATE) RETURNS DECIMAL(19,0) AS
	BEGIN
    DECLARE @anioFecha INT, @mesFecha INT, @idTiempo INT

    SET @anioFecha = DATEPART(YEAR, @fecha)
    SET @mesFecha = DATEPART(MONTH, @fecha)

    SELECT @idTiempo = ID_FECHA
    FROM [PANINI_GDD].[BI_DIM_TIEMPO]
    WHERE ANIO = @anioFecha AND MES = @mesFecha

    RETURN @idTiempo
  END
GO


CREATE FUNCTION [PANINI_GDD].[obtener_rentabilidad_producto](@idProd nvarchar(50),@anio INT) RETURNS DECIMAL(18,4) AS
  BEGIN
    DECLARE @rentabilidadVenta decimal(18,2),@rentabilidadCompra decimal(18,2)
    SET @rentabilidadVenta = (SELECT SUM(v.TOTAL_PRODUCTO) FROM [PANINI_GDD].[BI_HECHOS_VENTAS] v 
    JOIN [PANINI_GDD].[BI_DIM_TIEMPO] t ON v.ID_FECHA=t.ID_FECHA 
    WHERE t.ANIO = @anio AND v.COD_PROD=@idProd)
    SET @rentabilidadCompra = (SELECT SUM(c.TOTAL_PRODUCTO) FROM [PANINI_GDD].[BI_HECHOS_COMPRAS] c 
    JOIN [PANINI_GDD].[BI_DIM_TIEMPO] t ON c.ID_FECHA=t.ID_FECHA
    WHERE t.ANIO = @anio AND c.COD_PROD=@idProd)

    RETURN ((@rentabilidadVenta-@rentabilidadCompra)/@rentabilidadVenta)*100
  END
GO



CREATE FUNCTION [PANINI_GDD].[obtener_id_tipo_descuento](@tipoDesc char(20)) RETURNS DECIMAL(19,0) AS
  BEGIN
    DECLARE @id DECIMAL(19,0)
    SET @id = (SELECT ID_TIPO_DESCUENTO FROM [PANINI_GDD].[BI_DIM_TIPO_DESCUENTO] WHERE TIPO_DESCUENTO=@tipoDesc)
    RETURN @id
  END
GO


CREATE FUNCTION [PANINI_GDD].[obtener_cant_ventas]() RETURNS DECIMAL(19,0) AS
  BEGIN
    DECLARE @cant DECIMAL(19,0)
    SELECT @cant=COUNT(*) FROM (SELECT DISTINCT ID_FECHA,CODIGO_PROVINCIA,ID_RANGO_ETARIO,ID_CANAL_VENTA,ID_MEDIO_PAGO,ID_MEDIO_ENVIO FROM [PANINI_GDD].[BI_HECHOS_VENTAS]) Tabla
    RETURN @cant
  END
GO


CREATE FUNCTION [PANINI_GDD].[obtener_cant_ventas_x_provincia](@codProd decimal(19,0)) RETURNS DECIMAL(19,0) AS
  BEGIN
    DECLARE @cant DECIMAL(19,0)
    SET @cant = (SELECT COUNT(*) FROM (SELECT DISTINCT ID_FECHA,CODIGO_PROVINCIA,ID_RANGO_ETARIO,ID_CANAL_VENTA,ID_MEDIO_PAGO,ID_MEDIO_ENVIO 
	FROM [PANINI_GDD].[BI_HECHOS_VENTAS] ventas 
	WHERE ventas.CODIGO_PROVINCIA = @codProd) AS s)
    RETURN @cant
  END
GO

CREATE FUNCTION [PANINI_GDD].[obtener_cant_ventas_x_mes_y_anio](@mes INT, @anio INT) RETURNS DECIMAL(19,0) AS
  BEGIN
    DECLARE @cant DECIMAL(19,0)
    SET @cant= (SELECT COUNT(*) FROM 
    (
    SELECT DISTINCT venta.ID_FECHA,CODIGO_PROVINCIA,ID_RANGO_ETARIO,ID_CANAL_VENTA,ID_MEDIO_PAGO,ID_MEDIO_ENVIO 
	FROM [PANINI_GDD].[BI_HECHOS_VENTAS] venta 
	JOIN [PANINI_GDD].[BI_DIM_TIEMPO] fecha ON ( venta.ID_FECHA = fecha.ID_FECHA ) 
	WHERE fecha.MES = @mes AND fecha.ANIO = @anio
    ) Tabla )
    RETURN @cant
  END
GO

CREATE FUNCTION [PANINI_GDD].[obtener_ganancias_canal_venta](@mes INT, @anio INT,@idCanalVenta decimal(19,0)) RETURNS DECIMAL(18,2) AS
  BEGIN
    DECLARE @cant DECIMAL(18,2)
    SET @cant= (SELECT SUM(v.TOTAL_VENTA) 
    FROM [PANINI_GDD].[VENTA] v 
    WHERE DATEPART(YEAR,v.FECHA_VENTA)=@anio AND DATEPART(MONTH,v.FECHA_VENTA)=@mes AND v.ID_CANAL_VENTA=@idCanalVenta)   
    RETURN @cant
  END
GO

CREATE FUNCTION [PANINI_GDD].[obtener_id_provincia](@idMedioEnvio decimal(19,0)) RETURNS DECIMAL(19,0) AS
  BEGIN
  DECLARE @codProd DECIMAL(19,0)
  SET @codProd = (SELECT cp.CODIGO_PROVINCIA FROM [PANINI_GDD].[MEDIO_ENVIO_X_CODIGO_POSTAL] m
  JOIN [PANINI_GDD].[CODIGO_POSTAL] cp ON m.CODIGO_POSTAL=cp.CODIGO_POSTAL
  WHERE m.ID_MEDIO_ENVIO=@idMedioEnvio)
  RETURN @codProd
  END
GO

CREATE FUNCTION [PANINI_GDD].[obtener_id_categoria](@codProdVar nvarchar(50))  RETURNS DECIMAL(19,0) AS
  BEGIN
  DECLARE @idCat decimal(19,0)
  SET @idCat = (SELECT ID_CATEGORIA_PROD FROM [PANINI_GDD].[PRODUCTO_VARIANTE] pv
  JOIN [PANINI_GDD].[PRODUCTO] p ON pv.COD_PROD=p.COD_PROD
  WHERE pv.COD_PRODUCTO_VARIANTE=@codProdVar)
  RETURN @idCat
  END
GO

CREATE FUNCTION [PANINI_GDD].[obtener_codigo_producto](@codProdVar nvarchar(50)) RETURNS nvarchar(50) AS
  BEGIN
  DECLARE @codProd nvarchar(50)
  SET @codProd = (SELECT COD_PROD FROM [PANINI_GDD].PRODUCTO_VARIANTE pv
  WHERE pv.COD_PRODUCTO_VARIANTE=@codProdVar)
  RETURN @codProd
  END
GO


CREATE PROCEDURE [PANINI_GDD].[insertar_todo_bi]
AS
BEGIN
	
	BEGIN TRY
		BEGIN TRANSACTION
		exec [PANINI_GDD].[cargar_tiempo]
		exec [PANINI_GDD].[cargar_rangos_etarios]
		exec [PANINI_GDD].[cargar_provincias]
		exec [PANINI_GDD].[cargar_canales_venta]
		exec [PANINI_GDD].[cargar_medios_pago]
		exec [PANINI_GDD].[cargar_categorias_prod]
		exec [PANINI_GDD].[cargar_productos]
		exec [PANINI_GDD].[cargar_tipos_descuento]
		exec [PANINI_GDD].[cargar_tipos_envio]
		exec [PANINI_GDD].[cargar_proveedores]
		exec [PANINI_GDD].[cargar_compras]
		exec [PANINI_GDD].[cargar_ventas]
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH 
        SELECT
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_SEVERITY() AS ErrorSeverity,
            ERROR_STATE() AS ErrorState,
            ERROR_PROCEDURE() AS ErrorProcedure,
            ERROR_LINE() AS ErrorLine,
            ERROR_MESSAGE() AS ErrorMessage

            ROLLBACK TRANSACTION
    END CATCH
	
END

GO

EXEC [PANINI_GDD].[insertar_todo_bi]

GO


--VISTAS

/*
Las ganancias mensuales de cada canal de venta.
Se entiende por ganancias al total de las ventas, menos el total de las
compras, menos los costos de transacción totales aplicados asociados los
medios de pagos utilizados en las mismas.
*/


CREATE VIEW [PANINI_GDD].[ganancias_mensuales_x_canal_venta] (CANAL_VENTA, MES, ANIO, TOTAL_NETO)
AS
    SELECT dcv.CANAL_VENTA, t.MES, t.ANIO, cv.GANANCIA_CANAL_VENTA_MENSUAL TOTAL_NETO 
    FROM [PANINI_GDD].[BI_HECHOS_CANAL_VENTA] cv
    JOIN [PANINI_GDD].[BI_DIM_TIEMPO] t ON t.ID_FECHA = cv.ID_FECHA
	JOIN [PANINI_GDD].[BI_DIM_CANAL_VENTA] dcv ON cv.ID_CANAL_VENTA = dcv.ID_CANAL_VENTA

GO


-- Los 5 productos con mayor rentabilidad anual, con sus respectivos %
-- Se entiende por rentabilidad a los ingresos generados por el producto
-- (ventas) durante el periodo menos la inversión realizada en el producto
-- (compras) durante el periodo, todo esto sobre dichos ingresos.
-- Valor expresado en porcentaje.
-- Para simplificar, no es necesario tener en cuenta los descuentos aplicados.


CREATE VIEW [PANINI_GDD].[top_5_productos_x_rentabilidad] (NOMBRE_PRODUCTO,ANIO,RANKING,PORCENTAJE_RENTABILIDAD)
AS
  
  SELECT NOMBRE_PROD,t.ANIO,
  ROW_NUMBER() OVER (PARTITION BY t.ANIO ORDER BY (SUM(v.TOTAL_PRODUCTO)-SUM(c.TOTAL_PRODUCTO))/SUM(v.TOTAL_PRODUCTO)*100 DESC) AS RANKING,
  (CONVERT (VARCHAR(100),(((SUM(v.TOTAL_PRODUCTO)-SUM(c.TOTAL_PRODUCTO))/SUM(v.TOTAL_PRODUCTO))*100))+'%') AS PORCENTAJE_RENTABILIDAD

  FROM [PANINI_GDD].[BI_HECHOS_VENTAS] v

  JOIN [PANINI_GDD].[BI_DIM_TIEMPO] t ON v.ID_FECHA=t.ID_FECHA
  JOIN [PANINI_GDD].[BI_HECHOS_COMPRAS] c ON v.COD_PROD=c.COD_PROD AND v.ID_FECHA=c.ID_FECHA
  JOIN [PANINI_GDD].[BI_DIM_PRODUCTO] p ON p.COD_PROD=v.COD_PROD
  GROUP BY NOMBRE_PROD,t.ANIO
  
GO


-- Las 5 categorías de productos más vendidos por rango etario de clientes
-- por mes.

CREATE VIEW [PANINI_GDD].[top_5_categorias_x_rango_etario_x_mes] (RANGO_ETARIO,CATEGORIA,MES,ANIO,CANTIDAD_PRODUCTO,RANKING)
AS
  SELECT 
  r.RANGO_ETARIO,
  c.CATEGORIA,
  MES,
  ANIO,
  SUM(CANTIDAD_PRODUCTO),
  ROW_NUMBER() OVER (PARTITION BY MES,ANIO,r.RANGO_ETARIO Order by SUM(CANTIDAD_PRODUCTO) DESC) AS RANKING --TOP 5 EN EL SELECT
  FROM [PANINI_GDD].[BI_HECHOS_VENTAS] v
  JOIN [PANINI_GDD].[BI_DIM_TIEMPO] t ON t.ID_FECHA = v.ID_FECHA
	JOIN [PANINI_GDD].[BI_DIM_RANGO_ETARIO] r ON v.ID_RANGO_ETARIO=r.ID_RANGO_ETARIO
	JOIN [PANINI_GDD].[BI_DIM_CATEGORIA_PRODUCTO] c ON c.ID_CATEGORIA=v.ID_CATEGORIA
	GROUP BY r.RANGO_ETARIO,c.CATEGORIA,MES,ANIO

GO


-- Total de Ingresos por cada medio de pago por mes, descontando los costos
-- por medio de pago (en caso que aplique) y descuentos por medio de pago
-- (en caso que aplique)


CREATE VIEW [PANINI_GDD].[total_ingresos_medio_pago_x_mes] (MEDIO_PAGO,MES,ANIO,TOTAL_INGRESOS)
AS

 SELECT DISTINCT
	p.MEDIO_PAGO,
    MES,
    ANIO,
    SUM(mp.TOTAL_GANANCIA_MES) TOTAL_INGRESOS
    FROM [PANINI_GDD].[BI_HECHOS_MEDIO_PAGO] mp
    JOIN [PANINI_GDD].[BI_DIM_TIEMPO] t ON ( t.ID_FECHA = mp.ID_FECHA)
	JOIN [PANINI_GDD].[BI_DIM_MEDIO_PAGO] p ON ( p.ID_MEDIO_PAGO = mp.ID_MEDIO_PAGO ) 
	GROUP BY p.MEDIO_PAGO,MES,ANIO
	--ORDER BY ANIO,MES
GO

-- Importe total en descuentos aplicados según su tipo de descuento, por
-- canal de venta, por mes. Se entiende por tipo de descuento como los
-- correspondientes a envío, medio de pago, cupones, etc)

CREATE VIEW [PANINI_GDD].[importe_total_segun_descuento] (TIPO_DE_DESCUENTO, CANAL_DE_VENTA, MES, ANIO,IMPORTE_TOTAL)
AS
  
    SELECT tipo.TIPO_DESCUENTO, canal_venta.CANAL_VENTA, fecha.MES, fecha.ANIO,SUM(descuento.TOTAL_DESCUENTO)

    FROM [PANINI_GDD].[BI_HECHOS_DESCUENTOS] descuento
    JOIN [PANINI_GDD].[BI_DIM_TIPO_DESCUENTO] tipo ON (descuento.ID_TIPO_DESCUENTO = tipo.ID_TIPO_DESCUENTO)

    JOIN [PANINI_GDD].[BI_DIM_CANAL_VENTA] canal_venta ON (descuento.ID_CANAL_VENTA = canal_venta.ID_CANAL_VENTA)
    JOIN [PANINI_GDD].[BI_DIM_TIEMPO] fecha ON (fecha.ID_FECHA = descuento.ID_FECHA)

    GROUP BY tipo.TIPO_DESCUENTO, canal_venta.CANAL_VENTA, fecha.MES, fecha.ANIO
GO  



-- Porcentaje de envíos realizados a cada Provincia por mes. El porcentaje
-- debe representar la cantidad de envíos realizados a cada provincia sobre
-- total de envío mensuales.


CREATE VIEW [PANINI_GDD].[porcentaje_envio_realizado_provincia_x_mes](PROVINCIA, PORCENTAJE, MES, ANIO)
AS

    SELECT p.NOMBRE_PROV,

    CONVERT(VARCHAR(100),CONVERT(DECIMAL(18,3),[PANINI_GDD].[obtener_cant_ventas_x_provincia](p.CODIGO_PROVINCIA) / [PANINI_GDD].[obtener_cant_ventas_x_mes_y_anio](f.MES, f.ANIO)))+'%'
    PORCENTAJE,
	f.MES,
	f.ANIO

    FROM [PANINI_GDD].[BI_HECHOS_ENVIO] he
	JOIN [PANINI_GDD].[BI_DIM_PROVINCIA] p ON ( p.CODIGO_PROVINCIA = he.CODIGO_PROVINCIA )
    JOIN [PANINI_GDD].[BI_DIM_TIEMPO] f ON ( he.ID_FECHA = f.ID_FECHA)
	GROUP BY f.MES,f.ANIO,p.CODIGO_PROVINCIA,p.NOMBRE_PROV
GO 


-- Valor promedio de envío por Provincia por Medio De Envío anual.

CREATE VIEW [PANINI_GDD].[valor_promedio_envio_por_medio_por_provincia_anual] (ANIO, MEDIO_DE_ENVIO,PROVINCIA, VALOR_PROMEDIO)
AS

    SELECT t.ANIO, te.MEDIO, p.NOMBRE_PROV, 
    SUM(MEDIO_ENVIO_COSTO)/COUNT(e.ID_MEDIO_ENVIO) VALOR_PROMEDIO
    FROM [PANINI_GDD].[BI_HECHOS_ENVIO] e 
    JOIN [PANINI_GDD].[BI_DIM_TIEMPO] t ON e.ID_FECHA = t.ID_FECHA
    JOIN [PANINI_GDD].[BI_DIM_TIPO_ENVIO] te ON e.ID_MEDIO_ENVIO = te.ID_MEDIO_ENVIO
	JOIN [PANINI_GDD].[BI_DIM_PROVINCIA] p ON p.CODIGO_PROVINCIA=e.CODIGO_PROVINCIA
	JOIN [PANINI_GDD].[BI_HECHOS_VENTAS] v ON v.ID_MEDIO_ENVIO=e.ID_MEDIO_ENVIO
    GROUP BY t.ANIO, te.MEDIO, p.NOMBRE_PROV
GO

-- Aumento promedio de precios de cada proveedor anual. Para calcular este
-- indicador se debe tomar como referencia el máximo precio por año menos
-- el mínimo todo esto divido el mínimo precio del año. Teniendo en cuenta
-- que los precios siempre van en aumento.

CREATE VIEW [PANINI_GDD].[aumento_promedio_precios_x_proveedor_anual] ( RAZON_SOCIAL, AUMENTO_PROMEDIO, ANIO)
AS
    SELECT p.RAZON_SOCIAL_PROV,
    (max(c.TOTAL_PRODUCTO) - min(c.TOTAL_PRODUCTO)) / (min(c.TOTAL_PRODUCTO)),
    f.ANIO
    FROM [PANINI_GDD].[BI_HECHOS_COMPRAS] c
    JOIN [PANINI_GDD].[BI_DIM_TIEMPO] f ON c.ID_FECHA=f.ID_FECHA
    JOIN [PANINI_GDD].[BI_DIM_PROVEEDOR] p ON (p.ID_PROVEEDOR = c.ID_PROVEEDOR)
    GROUP BY p.RAZON_SOCIAL_PROV, f.ANIO
GO  



-- Los 3 productos con mayor cantidad de reposición por mes.

CREATE VIEW [PANINI_GDD].[top_3_prod_mayor_reposicion_x_mes] (PRODUCTO,MES,ANIO,CANTIDAD_COMPRADA,RANKING) 
AS
  
	SELECT NOMBRE_PROD,
	MES,
	ANIO,
	SUM(CANTIDAD_PRODUCTO) CANTIDAD_COMPRADA,
	ROW_NUMBER() OVER (PARTITION BY MES,ANIO Order by SUM(CANTIDAD_PRODUCTO) DESC) AS Ranking --TOP 3 EN EL SELECT
	FROM [PANINI_GDD].[BI_HECHOS_COMPRAS] c
	JOIN [PANINI_GDD].[BI_DIM_PRODUCTO] p ON p.COD_PROD=c.COD_PROD
	JOIN [PANINI_GDD].[BI_DIM_TIEMPO] t ON c.ID_FECHA=t.ID_FECHA
	GROUP BY NOMBRE_PROD,MES,ANIO 
  
GO

-- SELECT DE LAS VISTAS

SELECT * FROM [PANINI_GDD].[ganancias_mensuales_x_canal_venta] 

SELECT * FROM [PANINI_GDD].[top_5_productos_x_rentabilidad] WHERE RANKING <= 5 

SELECT * FROM [PANINI_GDD].[top_5_categorias_x_rango_etario_x_mes] WHERE RANKING <= 5 
--Existen solo Tres CATEGORIAS por eso el ranking da hasta 3.
--no hay personas menores a 25 años, dejamos select abajo de corroboracion
--select DNI_CLIENTE,FECHA_NAC_CLIENTE,(DATEDIFF(DAY,FECHA_NAC_CLIENTE, GETDATE()) / 365) from [PANINI_GDD].CLIENTE WHERE (DATEDIFF(DAY,FECHA_NAC_CLIENTE, GETDATE()) / 365) <30

SELECT * FROM [PANINI_GDD].[total_ingresos_medio_pago_x_mes] order by MES,ANIO


SELECT * FROM [PANINI_GDD].[porcentaje_envio_realizado_provincia_x_mes] order by MES,ANIO


SELECT * FROM [PANINI_GDD].[importe_total_segun_descuento]


SELECT * FROM [PANINI_GDD].[valor_promedio_envio_por_medio_por_provincia_anual]

-- en CABA no hay envios por moto: dejamos select de corroboracion
--select distinct COD_VENTA,m.MEDIO,p.NOMBRE_PROV from [PANINI_GDD].VENTA v join [PANINI_GDD].MEDIO_ENVIO_X_CODIGO_POSTAL m on v.ID_MEDIO_ENVIO=m.ID_MEDIO_ENVIO 
--join [PANINI_GDD].CLIENTE c on c.ID_CLIENTE=v.ID_CLIENTE
--join [PANINI_GDD].PROVINCIA p on p.CODIGO_PROVINCIA=c.CODIGO_PROVINCIA
--where m.MEDIO='Moto' and p.NOMBRE_PROV='Capital Federal'

SELECT * FROM [PANINI_GDD].[aumento_promedio_precios_x_proveedor_anual]

SELECT * FROM [PANINI_GDD].[top_3_prod_mayor_reposicion_x_mes] WHERE RANKING <= 3
