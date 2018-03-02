BEGIN TRANSACTION;

USE Shipment_ML;

EXEC dbo.ImportCSV 'dbo.Truck', 'D:\Projects\CDP\hw1\ImportData\Trucks.csv';

GO

EXEC dbo.ImportCSV 'dbo.Driver', 'D:\Projects\CDP\hw1\ImportData\Drivers.csv';

GO

EXEC dbo.ImportCSV 'dbo.Warehouse', 'D:\Projects\CDP\hw1\ImportData\Warehouses.csv';

GO

EXEC dbo.ImportCSV 'dbo.DriverTruck', 'D:\Projects\CDP\hw1\ImportData\Drivers-Trucks.csv';

COMMIT TRANSACTION;