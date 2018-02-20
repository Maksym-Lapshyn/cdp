BEGIN TRANSACTION;

USE Shipment_ML;

INSERT INTO dbo.ContactInformation(
	[FirstName],
    [LastName],
	[CellPhone]
)
VALUES(
	'Maksym',
	'Lapshyn',
	'111222333'
);

DECLARE @currentRow INT = 0;
DECLARE @contactId INT = 1;
DECLARE @cargosToInsert INT = 10000;
DECLARE @maxVolume INT = 50;
DECLARE @maxWeight INT = 5000;

WHILE @currentRow < @cargosToInsert
BEGIN
	INSERT INTO dbo.Cargo(
		[Weight],
		[Volume],
		[SenderId],
		[RecipientId]
	)
	VALUES(
		ROUND(((@maxWeight - 1) * RAND() + 1), 0),
		ROUND(((@maxVolume - 1) * RAND() + 1), 0),
		@contactId,
		@contactId
	)

	SET @currentRow = @currentRow + 1;
END

DECLARE @shipmentsToInsert INT = 1000;
SET @currentRow = 0;
DECLARE @routeCount INT;
DECLARE @truckCount INT;

SELECT @routeCount = COUNT(*)
FROM dbo.[Route];

SELECT @truckCount = COUNT(*)
FROM dbo.Truck;

WHILE @currentRow < @shipmentsToInsert
BEGIN
	DECLARE @truckId INT = ROUND(((@truckCount - 1) * RAND() + 1), 0);
	DECLARE @driverId INT;

	SELECT TOP 1 @driverId = DriverId
	FROM dbo.DriverTruck
	WHERE TruckId = @truckId
	ORDER BY NEWID();

	INSERT INTO dbo.Shipment(
		[RouteId],
		[DriverId],
		[TruckId],
		[CargoId]
	)
	VALUES(
		ROUND(((@routeCount - 1) * RAND() + 1), 0),
		@driverId,
		@truckId,
		ROUND(((@cargosToInsert - 1) * RAND() + 1), 0)
	)

	SET @currentRow = @currentRow + 1;
END

COMMIT TRANSACTION;