	USE [002_Superstores];

	SELECT * FROM ss_master_table ORDER BY Product_Name ASC;

	/* Step 1.1: Cek Jumlah Baris */
	SELECT COUNT(*) AS 'Total Row' from ss_master_table;

	/* Step 1.2: Cek Date */
	SELECT MIN(Order_Date) AS 'Order Start Date',
		   MAX(Order_Date) AS 'Order End Date',
		   MIN(Ship_Date) AS 'Shipping Start Date',
		   MAX(Ship_Date) AS 'Shipping End Date'
	FROM ss_master_table;
	
	/* Step 1.3: Cek jenis dan jumlah kategorinya */
	SELECT DISTINCT Category from ss_master_table;

	/* Step 1.4: Cek country, state, region */
	SELECT DISTINCT country from ss_master_table;
	SELECT DISTINCT city from ss_master_table;
	SELECT DISTINCT State from ss_master_table;
	SELECT DISTINCT region from ss_master_table;

	/* Step 2.1: Cek value null pada data */
	SELECT
	SUM (CASE WHEN Row_ID IS NULL THEN 1 ELSE 0 END) AS 'ID Total Null',
	SUM (CASE WHEN Order_ID IS NULL THEN 1 ELSE 0 END) AS 'Order ID Total Null',
	SUM (CASE WHEN Order_Date IS NULL THEN 1 ELSE 0 END) AS 'Order Date Total Null',
	SUM (CASE WHEN Ship_Date IS NULL THEN 1 ELSE 0 END) AS 'Ship Date Total Null',
	SUM (CASE WHEN Ship_Mode IS NULL THEN 1 ELSE 0 END) AS 'Ship Mode Total Null',
	SUM (CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END) AS 'Customer ID Total Null',
	SUM (CASE WHEN Customer_Name IS NULL THEN 1 ELSE 0 END) AS 'Customer Name Total Null',
	SUM (CASE WHEN Segment IS NULL THEN 1 ELSE 0 END) AS 'Segment Total Null',
	SUM (CASE WHEN Country IS NULL THEN 1 ELSE 0 END) AS 'Country Total Null',
	SUM (CASE WHEN City IS NULL THEN 1 ELSE 0 END) AS 'City Total Null',
	SUM (CASE WHEN State IS NULL THEN 1 ELSE 0 END) AS 'State Total Null',
	SUM (CASE WHEN Postal_Code IS NULL THEN 1 ELSE 0 END) AS 'Postal Code Total Null',
	SUM (CASE WHEN Region IS NULL THEN 1 ELSE 0 END) AS 'Region Total Null',
	SUM (CASE WHEN Product_ID IS NULL THEN 1 ELSE 0 END) AS 'Product ID Total Null',
	SUM (CASE WHEN Category IS NULL THEN 1 ELSE 0 END) AS 'Category Total Null',
	SUM (CASE WHEN Sub_Category IS NULL THEN 1 ELSE 0 END) AS 'Sub Category Total Null',
	SUM (CASE WHEN Product_Name IS NULL THEN 1 ELSE 0 END) AS 'Product Name Total Null',
	SUM (CASE WHEN Sales IS NULL THEN 1 ELSE 0 END) AS 'Sales Total Null',
	SUM (CASE WHEN Quantity IS NULL THEN 1 ELSE 0 END) AS 'Quantity Total Null',
	SUM (CASE WHEN Discount IS NULL THEN 1 ELSE 0 END) AS 'Discount Total Null',
	SUM (CASE WHEN Profit IS NULL THEN 1 ELSE 0 END) AS 'Profit Total Null'
	FROM ss_master_table;

	/* Step 2.2: Cek duplicate value pada column Row_ID */
	SELECT Row_ID, COUNT(Row_ID) AS 'Total Row ID'
	FROM ss_master_table
	GROUP BY Row_ID
	HAVING COUNT(Row_ID) > 1;

	/* Step 2.2: Cek duplicate value pada column selain Row_ID */
	SELECT Order_ID, Order_Date, Ship_Date, Ship_Mode, Customer_ID, Customer_Name,
		Segment, Country, City, State, Postal_Code, Region,
		Product_ID, Category, Sub_Category, Product_Name, Sales, Quantity,
		Discount, Profit, COUNT(*) AS 'Total Duplicate'
	FROM ss_master_table
	GROUP BY Order_ID, Order_Date, Ship_Date, Ship_Mode, Customer_ID, Customer_Name,
		Segment, Country, City, State, Postal_Code, Region,
		Product_ID, Category, Sub_Category, Product_Name, Sales, Quantity,
		Discount, Profit
	HAVING COUNT(*) > 1;

	/* Step 2.2: Delete Row_ID = 3407 karena datanya duplikat */
	DELETE FROM ss_master_table
	WHERE Row_ID = 3407;

		/* Step 2.3: Cek outlier value pada data Sales */
		select Sales from ss_master_table
		where sales <= 0;

		/* Step 2.4: Cek outlier value pada data Discount */
		select Discount from ss_master_table
		where Discount < 0 and Discount > 1;	
