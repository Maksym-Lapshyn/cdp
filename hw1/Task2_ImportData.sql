BEGIN TRANSACTION;

USE Shipment_ML;

EXEC dbo.ImportCSV 'dbo.Truck', 'E:\Projects\CDP\hw1\ImportData\Trucks.csv';

GO

EXEC dbo.ImportCSV 'dbo.Driver', 'E:\Projects\CDP\hw1\ImportData\Drivers.csv';

GO

EXEC dbo.ImportCSV 'dbo.Warehouse', 'E:\Projects\CDP\hw1\ImportData\Warehouses.csv';

GO

EXEC dbo.ImportCSV 'dbo.DriverTruck', 'E:\Projects\CDP\hw1\ImportData\Drivers-Trucks.csv';

COMMIT TRANSACTION;