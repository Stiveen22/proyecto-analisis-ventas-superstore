/* ============================
   EXPLORACIÓN Y PREPARACIÓN DE DATOS
   Dataset: Ventas_Separadas_v1
   ============================ */

/* Selecciono la base de datos donde se cargó el dataset limpio */
Use VentasSuperstore;

/*VALIDACIÓN DE LONGITUD DE CAMPOS TIPO TEXTO
Verifico la longitud máxima de cada columna tipo texto. 
Esto me permite definir un tamaño adecuado al modificar 
los tipos de datos con VARCHAR, evitando pérdidas o errores.*/
SELECT MAX(LEN([Order ID])) AS LargoMax_OrderID FROM [dbo].[Ventas_Separadas_v1];
SELECT MAX(LEN([Ship Mode])) AS LargoMax_ShipMode FROM [dbo].[Ventas_Separadas_v1];
SELECT MAX(LEN([Customer ID])) AS LargoMax_CustomerID FROM [dbo].[Ventas_Separadas_v1];
SELECT MAX(LEN([Customer Name])) AS LargoMax_CustomerName FROM [dbo].[Ventas_Separadas_v1];
SELECT MAX(LEN([Segment])) AS LargoMax_Segment FROM [dbo].[Ventas_Separadas_v1];
SELECT MAX(LEN([Country])) AS LargoMax_Country FROM [dbo].[Ventas_Separadas_v1];
SELECT MAX(LEN([City])) AS LargoMax_City FROM [dbo].[Ventas_Separadas_v1];
SELECT MAX(LEN([State])) AS LargoMax_State FROM [dbo].[Ventas_Separadas_v1];
SELECT MAX(LEN([Postal Code])) AS LargoMax_PostalCode FROM [dbo].[Ventas_Separadas_v1];
SELECT MAX(LEN([Region])) AS LargoMax_Region FROM [dbo].[Ventas_Separadas_v1];
SELECT MAX(LEN([Product ID])) AS LargoMax_ProductID FROM [dbo].[Ventas_Separadas_v1];
SELECT MAX(LEN([Category])) AS LargoMax_Category FROM [dbo].[Ventas_Separadas_v1];
SELECT MAX(LEN([Sub-Category])) AS LargoMax_SubCategory FROM [dbo].[Ventas_Separadas_v1];
SELECT MAX(LEN([Product Name])) AS LargoMax_ProductName FROM [dbo].[Ventas_Separadas_v1];

/*AJUSTE DE TIPOS DE DATOS VARCHAR
Modifico la longitud de las columnas tipo texto en base 
a los valores máximos identificados previamente. Esto permite 
optimizar el uso de espacio y asegurar consistencia en el almacenamiento.*/
ALTER TABLE [dbo].[Ventas_Separadas_v1] ALTER COLUMN [Order ID] VARCHAR(15);
ALTER TABLE [dbo].[Ventas_Separadas_v1] ALTER COLUMN [Ship Mode] VARCHAR(15);
ALTER TABLE [dbo].[Ventas_Separadas_v1] ALTER COLUMN [Customer ID] VARCHAR(10);
ALTER TABLE [dbo].[Ventas_Separadas_v1] ALTER COLUMN [Customer Name] VARCHAR(30);
ALTER TABLE [dbo].[Ventas_Separadas_v1] ALTER COLUMN [Segment] VARCHAR(15);
ALTER TABLE [dbo].[Ventas_Separadas_v1] ALTER COLUMN [Country] VARCHAR(15);
ALTER TABLE [dbo].[Ventas_Separadas_v1] ALTER COLUMN [City] VARCHAR(20);
ALTER TABLE [dbo].[Ventas_Separadas_v1] ALTER COLUMN [State] VARCHAR(25);
ALTER TABLE [dbo].[Ventas_Separadas_v1] ALTER COLUMN [Postal Code] VARCHAR(6);
ALTER TABLE [dbo].[Ventas_Separadas_v1] ALTER COLUMN [Region] VARCHAR(10);
ALTER TABLE [dbo].[Ventas_Separadas_v1] ALTER COLUMN [Product ID] VARCHAR(20);
ALTER TABLE [dbo].[Ventas_Separadas_v1] ALTER COLUMN [Category] VARCHAR(20);
ALTER TABLE [dbo].[Ventas_Separadas_v1] ALTER COLUMN [Sub-Category] VARCHAR(15);
ALTER TABLE [dbo].[Ventas_Separadas_v1] ALTER COLUMN [Product Name] VARCHAR(130);

/*VERIFICACIÓN DEL TOTAL DE REGISTROS
Confirmo que la tabla contiene 9986 registros en total, 
lo cual asegura que la carga del dataset fue completa.*/
SELECT COUNT(*) FROM [dbo].[Ventas_Separadas_v1];

/*VERIFICACIÓN DE VALORES NULOS
Valido que no existan registros con valores nulos en ningún campo importante.
El resultado fue 0, lo que indica que la calidad de los datos es adecuada.*/
SELECT COUNT(*) AS Filas_con_null
FROM [dbo].[Ventas_Separadas_v1]
WHERE 
    CASE 
        WHEN [Row ID] IS NULL THEN 1
        WHEN [Order ID] IS NULL THEN 1
        WHEN [Order Date] IS NULL THEN 1
        WHEN [Ship Date] IS NULL THEN 1
        WHEN [Ship Mode] IS NULL THEN 1
        WHEN [Customer ID] IS NULL THEN 1
        WHEN [Customer Name] IS NULL THEN 1
        WHEN [Segment] IS NULL THEN 1
        WHEN [Country] IS NULL THEN 1
        WHEN [City] IS NULL THEN 1
        WHEN [State] IS NULL THEN 1
        WHEN [Postal Code] IS NULL THEN 1
        WHEN [Region] IS NULL THEN 1
        WHEN [Product ID] IS NULL THEN 1
        WHEN [Category] IS NULL THEN 1
        WHEN [Sub-Category] IS NULL THEN 1
        WHEN [Product Name] IS NULL THEN 1
        WHEN [Sales] IS NULL THEN 1
        WHEN [Quantity] IS NULL THEN 1
        WHEN [Discount] IS NULL THEN 1
        WHEN [Profit] IS NULL THEN 1
        ELSE 0
    END = 1;

/*VERIFICACIÓN DE DUPLICADOS
Compruebo si existen combinaciones repetidas de Order ID y Product ID.
No se encontró ninguna, lo cual confirma que los registros son únicos.*/
SELECT [Order ID], [Product ID], COUNT(*) AS Cantidad
FROM [dbo].[Ventas_Separadas_v1]
GROUP BY [Order ID], [Product ID]
HAVING COUNT(*) > 1;

/*VALIDACIÓN DE CONVERSIÓN DE TIPOS
Verifico que los campos numéricos y de fecha puedan convertirse correctamente.
No se detectaron errores de conversión, lo cual indica que los datos tienen el formato correcto.*/
SELECT *
FROM [dbo].[Ventas_Separadas_v1]
WHERE TRY_CAST([Sales] AS FLOAT) IS NULL 
OR TRY_CAST([Discount] AS FLOAT) IS NULL
OR TRY_CAST([Profit] AS FLOAT) IS NULL
OR TRY_CAST([Row ID] AS INT) IS NULL
OR TRY_CAST([Quantity] AS INT) IS NULL
OR TRY_CAST([Order Date] AS DATE) IS NULL
OR TRY_CAST([Ship Date] AS DATE) IS NULL;

/*RANGO DE FECHAS DE PEDIDOS
Identifico la fecha mínima y máxima de los pedidos registrados para conocer el periodo que cubre el dataset.
Resultado: del 02/01/2014 al 30/12/2017*/
SELECT MIN([Order Date]), MAX([Order Date])
FROM [dbo].[Ventas_Separadas_v1];

/*TOTAL DE VENTAS
Calculo el monto total vendido sumando la columna [Sales]. 
Resultado: 2297201.07*/
SELECT SUM([Sales])
FROM [dbo].[Ventas_Separadas_v1];

/*TOTAL DE GANANCIAS
Calculo la ganancia total sumando la columna [Profit]. 
Resultado: 286397.79*/
SELECT SUM([Profit])
FROM [dbo].[Ventas_Separadas_v1];

/*TOP 10 PRODUCTOS MÁS VENDIDOS (por monto total en ventas)
Identifico los 10 productos con mayores ingresos generados, sumando las ventas agrupadas por nombre del producto.
Esto permite conocer cuáles son los productos más rentables.*/
SELECT TOP 10 [Product Name], SUM([Sales]) AS Total_Ventas
FROM [dbo].[Ventas_Separadas_v1]
GROUP BY [Product Name]
ORDER BY Total_Ventas DESC;

/*VENTAS POR CATEGORÍA
Agrupo las ventas según la categoría del producto para analizar cuál genera más ingresos totales.*/
SELECT [Category], SUM([Sales]) AS Total_Ventas
FROM [dbo].[Ventas_Separadas_v1]
GROUP BY [Category];

/*RENTABILIDAD POR REGIÓN
Analizo la rentabilidad total por región sumando las ganancias. 
Esto permite identificar qué regiones generan mayor utilidad para el negocio.*/
SELECT [Region], SUM([Profit]) AS Rentabilidad
FROM [dbo].[Ventas_Separadas_v1]
GROUP BY [Region]
ORDER BY SUM([Profit]) DESC;

/*COMPORTAMIENTO MENSUAL DE LAS VENTAS
Agrupo las ventas por mes para analizar su evolución en el tiempo. 
Esto permite identificar temporadas con mayores o menores ingresos y detectar tendencias de comportamiento.*/
SELECT FORMAT([Order Date], 'yyyy-MM') AS Mes,
SUM([Sales]) AS VentasMensuales
FROM [dbo].[Ventas_Separadas_v1]
GROUP BY FORMAT([Order Date], 'yyyy-MM')
ORDER BY Mes;