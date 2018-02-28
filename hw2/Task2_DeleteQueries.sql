USE Shipment_ML;

/*FIRST QUERY*/

DELETE x FROM (
	SELECT *, rn = ROW_NUMBER() OVER (PARTITION BY RegistrationNumber ORDER BY Id ASC)
	FROM dbo.Truck 
) x
WHERE rn > 1;

/*SECOND QUERY*/

DELETE x FROM (
	SELECT TOP 1 *, total = COUNT(*) OVER (PARTITION BY RegistrationNumber)
	FROM dbo.Truck
	ORDER BY Id DESC
) x
WHERE total > 1;