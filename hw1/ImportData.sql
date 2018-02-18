BEGIN TRANSACTION;

USE XYZ;

BULK INSERT dbo.Truck
FROM 'E:\Projects\CDP\hw1\ImportData\Trucks.csv' 
WITH(
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2
);

BULK INSERT dbo.Driver
FROM 'E:\Projects\CDP\hw1\ImportData\Drivers.csv' 
WITH(
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2
);

BULK INSERT dbo.Warehouse
FROM 'E:\Projects\CDP\hw1\ImportData\Warehouses.csv' 
WITH(
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2
);

BULK INSERT dbo.Driver_Truck
FROM 'E:\Projects\CDP\hw1\ImportData\Drivers-Trucks.csv' 
WITH(
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2
);

COMMIT TRANSACTION;