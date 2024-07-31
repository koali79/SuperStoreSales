SELECT TOP (10000)
	[Segment]
	,[State]
	,[Category]
	,[Sub_Category]
	,[Sales]
	,[Profit]
	
FROM [superstore_sales].[dbo].[superstore_data];

/* This code determines the total Sales
*/


SELECT SUM(Sales) AS Total_Sales
FROM [superstore_sales].[dbo].[superstore_data];


/* This code determines the highest selling Categories based on Sales
*/

WITH Sales_per_Category AS (
	SELECT
		[Category],
		SUM (Sales) AS total_sales
	FROM [superstore_sales].[dbo].[superstore_data]
	GROUP BY Category
)
SELECT 
	[Category],
	[Total_Sales]
FROM Sales_per_Category
ORDER BY Total_Sales DESC;


/* This code determines the highest selling Sub Categories based on Sales
*/

WITH Sales_per_Sub_Category AS (
	SELECT
		[Sub_Category],
		SUM(Sales) AS total_sales
	FROM [superstore_sales].[dbo].[superstore_data]
	GROUP BY Sub_Category
)
SELECT
	[Sub_Category],
	[Total_Sales]
FROM Sales_per_Sub_Category
ORDER BY Total_Sales DESC;


/* This code determines the amount of purchases per segment
*/

SELECT 
	[Segment],
	COUNT(*) AS count
	FROM [superstore_sales].[dbo].[superstore_data]
	GROUP BY Segment;


/* This code determines the top 3 segments based on sales
*/

SELECT TOP 3 Segment,SUM(Sales)
	AS TotalSales
	FROM [superstore_sales].[dbo].[superstore_data]
	GROUP BY Segment
	ORDER BY TotalSales DESC;


/* This code involves determining the top ranked subcategories from each of the 3 segements based on sales
*/

WITH RankedSales AS (
	SELECT 
		[Sub_Category],
		[Segment], 
		SUM(Sales) AS TotalSales,
		ROW_NUMBER() OVER (PARTITION BY Segment
ORDER BY SUM(Sales) DESC) AS Rank 
	FROM 
		[superstore_sales].[dbo].[superstore_data]
	GROUP BY 
		Sub_Category,
		Segment
) 
SELECT 
	[Sub_Category],
	[Segment],
	[TotalSales]
FROM RankedSales 
WHERE Rank <= 3 
ORDER BY Segment, TotalSales DESC;


/*This code involves determining the top 5 States with the most Sales
*/

SELECT TOP 5 [State], SUM(Sales) AS TotalSales
FROM [superstore_sales].[dbo].[superstore_data]
GROUP BY [State]
ORDER BY TotalSales DESC;


/*This code involves determining the yearly Sales
*/

SELECT YEAR (Order_Date)AS Year,
SUM(Sales) AS Revenue
FROM [superstore_sales].[dbo].[superstore_data]
GROUP BY YEAR (Order_Date)
ORDER BY YEAR (Order_Date);