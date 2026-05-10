-- Creacion de la base de datos --
CREATE DATABASE Entregable4;
GO

USE Entregable4;
GO

-- Creacion de las tablas --
CREATE TABLE DIM_CATEGORY (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100)
);

CREATE TABLE DIM_SEGMENT (
    CategoryID INT,
    Attr1 VARCHAR(100),
    Attr2 VARCHAR(100),
    Attr3 VARCHAR(100),
    Format VARCHAR(100),
    Segment VARCHAR(100)
);

CREATE TABLE DIM_CALENDAR (
    Date DATE PRIMARY KEY,
    Week VARCHAR(20),
    Year INT,
    Month INT,
    Week_Number INT
);

CREATE TABLE DIM_PRODUCT (
    Item VARCHAR(100),
    Manufacturer VARCHAR(100),
    Brand VARCHAR(100),
    Item_description VARCHAR(100),
    CategoryID INT,
    Format VARCHAR(100),
    Attr1 VARCHAR(100),
    Attr2 VARCHAR(100),
    Attr3 VARCHAR(100)
);

CREATE TABLE FACT_SALES (
    Week VARCHAR(20),
    ItemCode VARCHAR(100),
    TotalUnitSales DECIMAL(10,4),
    TotalValueSales DECIMAL(10,4),
    TotalUnitAVGWeeklySales DECIMAL(10,4),
    Region VARCHAR(100)
);

-- Importacion de datos -- 

BULK INSERT DIM_CATEGORY
FROM 'C:\Users\emanu\Documents\EBAC\DIM_CATEGORY (2).csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

EXECUTE sp_configure 'Ad Hoc Distributed Queries', 1;
GO
RECONFIGURE;
GO

INSERT INTO DIM_SEGMENT(CategoryID, Attr1, Attr2, Attr3, Format, Segment)
SELECT *
FROM OPENROWSET(
    'Microsoft.ACE.OLEDB.12.0',
    'Excel 12.0;Database=C:\Users\emanu\Documents\EBAC\DIM_SEGMENT (1).xlsx;HDR=YES;',
    'SELECT * FROM [SEGMENT$]'
);

INSERT INTO DIM_CALENDAR(Week, Year, Month, Week_Number, Date)
SELECT WEEK, YEAR, MONTH, WEEK_NUMBER, DATE
FROM OPENROWSET(
    'Microsoft.ACE.OLEDB.12.0',
    'Excel 12.0;Database=C:\Users\emanu\Documents\EBAC\DIM_CALENDAR (2).xlsx;HDR=YES;',
    'SELECT WEEK, YEAR, MONTH, WEEK_NUMBER, DATE FROM [Sheet1$]'
);

INSERT INTO DIM_PRODUCT(Manufacturer, Brand, Item, Item_description, CategoryID, Format, Attr1, Attr2, Attr3)
SELECT MANUFACTURER, BRAND, ITEM, ITEM_DESCRIPTION, CATEGORY, FORMAT, ATTR1, ATTR2, ATTR3
FROM OPENROWSET(
    'Microsoft.ACE.OLEDB.12.0',
    'Excel 12.0;Database=C:\Users\emanu\Documents\EBAC\DIM_PRODUCT (1).xlsx;HDR=YES;',
    'SELECT MANUFACTURER, BRAND, ITEM, ITEM_DESCRIPTION, CATEGORY, FORMAT, ATTR1, ATTR2, ATTR3 FROM [Sheet1$]'
);

BULK INSERT FACT_SALES
FROM 'C:\Users\emanu\Documents\EBAC\FACT_SALES (1).csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

-- Consultas Basicas --

SELECT TOP 10 * FROM DIM_CATEGORY;

SELECT TOP 10 * FROM DIM_SEGMENT;

SELECT TOP 10 * FROM DIM_CALENDAR;

SELECT TOP 10 * FROM DIM_PRODUCT;

SELECT TOP 10 * FROM FACT_SALES;

SELECT
    MIN(TotalValueSales) AS MinVenta,
    MAX(TotalValueSales) AS MaxVenta,
    AVG(TotalValueSales) AS Promedio
FROM FACT_SALES;

SELECT
    Week,
    SUM(TotalValueSales) AS VentasTotales
FROM FACT_SALES
GROUP BY Week
ORDER BY Week;

SELECT
    Region,
    SUM(TotalValueSales) AS VentasTotales
FROM FACT_SALES 
GROUP BY Region
ORDER BY VentasTotales DESC;

-- Uniones entre tablas --

-- Ventas totales por categoría --
SELECT
    c.CategoryName,
    SUM(f.TotalValueSales) AS TotalVentas
FROM FACT_SALES f
JOIN DIM_PRODUCT p
    ON f.ItemCode = p.Item
JOIN DIM_CATEGORY c
    ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryName
ORDER BY TotalVentas DESC;

-- Ventas por categoría y región --
SELECT
    c.CategoryName,
    f.Region,
    SUM(f.TotalValueSales) AS VentasTotales
FROM FACT_SALES f
JOIN DIM_PRODUCT p
    ON f.ItemCode = p.Item
JOIN DIM_CATEGORY c
    ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryName, f.Region
ORDER BY c.CategoryName, VentasTotales DESC;

-- Ventas por periodo de tiempo (año / mes) --
SELECT
    cal.Year,
    cal.Month,
    SUM(f.TotalValueSales) AS VentasTotales
FROM FACT_SALES f
JOIN DIM_CALENDAR cal
    ON f.Week = cal.Week
GROUP BY cal.Year, cal.Month
ORDER BY cal.Year, cal.Month;

-- Top productos por ventas --
SELECT TOP 10
    p.Item,
    p.Brand,
    p.Item_description,
    SUM(f.TotalValueSales) AS VentasTotales
FROM FACT_SALES f
JOIN DIM_PRODUCT p
    ON f.ItemCode = p.Item
GROUP BY p.Item, p.Brand, p.Item_description
ORDER BY VentasTotales DESC;

-- Ventas por segmento --
SELECT
    s.Segment,
    SUM(f.TotalValueSales) AS TotalVentas
FROM FACT_SALES f
JOIN DIM_PRODUCT p 
    ON f.ItemCode = p.Item
JOIN DIM_SEGMENT s
    ON p.CategoryID = s.CategoryID
GROUP BY s.Segment
ORDER BY TotalVentas DESC;

-- Ventas por segmento y periodo --
SELECT
    cal.Year,
    cal.Month,
    s.Segment,
    SUM(f.TotalValueSales) AS TotalVentas
FROM FACT_SALES f
JOIN DIM_PRODUCT p ON f.ItemCode = p.Item
JOIN DIM_SEGMENT s ON p.CategoryID = s.CategoryID
JOIN DIM_CALENDAR cal ON f.Week = cal.Week
GROUP BY cal.Year, cal.Month, s.Segment
ORDER BY cal.Year, cal.Month, TotalVentas DESC;