
--BULK INSERTING

EXEC bronze.load_bronze


CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME;
	DECLARE @start_batch DATETIME, @end_batch DATETIME;

	SET @start_batch = GETDATE();
	BEGIN TRY

	PRINT 'Loading Bronze Layer';

	PRINT '---------------------------------------------';
	PRINT 'Loading CRM Tables';
	PRINT '---------------------------------------------';

	SET @start_time = GETDATE();
	TRUNCATE TABLE bronze.crm_cust_info;

	BULK INSERT bronze.crm_cust_info
	FROM 'D:\Dummies Books\DOWNLOADS\sql-data-warehouse-project.zip\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
	PRINT '>> ----------------';

	SET @start_time = GETDATE();
	TRUNCATE TABLE bronze.crm_prd_info;

	BULK INSERT bronze.crm_prd_info
	FROM 'D:\Dummies Books\DOWNLOADS\sql-data-warehouse-project.zip\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
	PRINT '>> ----------------';

	SET @start_time = GETDATE();
	TRUNCATE TABLE bronze.crm_sales_details;

	BULK INSERT bronze.crm_sales_details
	FROM 'D:\Dummies Books\DOWNLOADS\sql-data-warehouse-project.zip\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
	PRINT '>> ----------------';


	PRINT '---------------------------------------------';
	PRINT 'Loading ERP Tables';
	PRINT '---------------------------------------------';

	SET @start_time = GETDATE();
	TRUNCATE TABLE bronze.erp_cust_az12;

	BULK INSERT bronze.erp_cust_az12
	FROM 'D:\Dummies Books\DOWNLOADS\sql-data-warehouse-project.zip\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
	PRINT '>> ----------------';

	SET @start_time = GETDATE();
	TRUNCATE TABLE bronze.erp_loc_a101;

	BULK INSERT bronze.erp_loc_a101
	FROM 'D:\Dummies Books\DOWNLOADS\sql-data-warehouse-project.zip\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
	PRINT '>> ----------------';
	
	SET @start_time = GETDATE();
	TRUNCATE TABLE bronze.erp_px_cat_g1v2;

	BULK INSERT bronze.erp_px_cat_g1v2
	FROM 'D:\Dummies Books\DOWNLOADS\sql-data-warehouse-project.zip\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
	PRINT '>> ----------------';

	SET @end_batch = GETDATE();
	PRINT '>> Batch Duration:' + CAST(DATEDIFF(second, @start_batch, @end_batch) AS NVARCHAR) + ' seconds';

	END TRY
	BEGIN CATCH
		PRINT '========================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONE LAYER';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '========================================';
	END CATCH
END

