USE [002_Superstores];

SELECT * from ss_master_table;

/* 
	Query for Analysis Phase
	- Created by David Herianto 
*/

--  Overall Business Performance
	-- a. Performa Superstore untuk periode 2014-2017
			SELECT
				SUM(SALES) AS 'Total Revenue',
				SUM(PROFIT) AS 'Total Profit',
				COUNT(DISTINCT Order_ID) AS 'Total Order',
				CASE 
				WHEN SUM(Sales) = 0 THEN NULL 
				ELSE 
				(SUM(Profit)/SUM(Sales))*100 END AS 'Profit Margin'
			FROM ss_master_table;

	-- b. Performa Superstore dari waktu ke waktu	
			SELECT
				YEAR(Order_Date) AS 'Year',
				CONCAT('Q', DATEPART(QUARTER, Order_Date)) AS Quarter,
				SUM(Sales) AS 'Total Revenue',
				SUM(Profit) AS 'Total Profit',
				COUNT(DISTINCT Order_ID) AS 'Total Order',
			CASE WHEN SUM(Sales) = 0 THEN NULL 
				ELSE 
				(SUM(Profit)/SUM(Sales))*100 END AS 'Profit Margin'
				
			FROM ss_master_table
			GROUP BY
				YEAR(Order_Date),
				DATEPART(QUARTER, Order_Date)
			ORDER BY 'Year' DESC;

	-- c. Performa region yang paling kuat
			SELECT Region,
				SUM(SALES) AS 'Total Revenue',
				SUM(PROFIT) AS 'Total Profit',
				COUNT(DISTINCT Order_ID) AS 'Total Order',
				CASE WHEN SUM(Sales) = 0 THEN NULL ELSE (SUM(Profit)/SUM(Sales))*100 END AS 'Profit Margin'
			FROM ss_master_table
			GROUP BY Region;

	-- d. Performa kategori produk yang paling kuat
			SELECT Category,
				SUM(SALES) AS 'Total Revenue',
				SUM(PROFIT) AS 'Total Profit',
				COUNT(DISTINCT Order_ID) AS 'Total Order',
				CASE WHEN SUM(Sales) = 0 THEN NULL ELSE (SUM(Profit)/SUM(Sales))*100 END AS 'Profit Margin'
			FROM ss_master_table
			GROUP BY Category;

	-- e. Performa segmen konsumen yang paling kuat
			SELECT Segment,
				SUM(SALES) AS 'Total Revenue',
				SUM(PROFIT) AS 'Total Profit',
				COUNT(DISTINCT Order_ID) AS 'Total Order',
				CASE WHEN SUM(Sales) = 0 THEN NULL ELSE (SUM(Profit)/SUM(Sales))*100 END AS 'Profit Margin'
			FROM ss_master_table
			GROUP BY Segment;
