USE Shipment_ML;

/*FIRST QUERY*/

DELETE rowsToDelete FROM (
	SELECT *, ROW_NUMBER() OVER (PARTITION BY RegistrationNumber ORDER BY Id ASC) AS rowNumber
	FROM dbo.Truck 
) AS rowsToDelete
WHERE rowNumber > 1;

/*SECOND QUERY*/

DELETE rowsToDelete FROM (
	SELECT *, COUNT(*) OVER (PARTITION BY RegistrationNumber) AS rowsCount, MIN(Id) OVER (PARTITION BY RegistrationNumber) AS minId
	FROM dbo.Truck
) AS rowsToDelete
WHERE rowsCount > 1
AND Id != minId;