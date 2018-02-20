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

	DECLARE @departureDateFrom AS DATETIME = '1990-01-01';
	DECLARE @departureDateTo AS DATETIME = '2004-01-01';
	DECLARE @days_diff AS INT = cast(@departureDateTo - @departureDateFrom AS INT);
	DECLARE @departureDate DATETIME;

	SELECT @departureDate = @departureDateFrom +
		DATEADD(second, ABS(CHECKSUM(newid()) % 60), 0) +
		DATEADD(minute, ABS(CHECKSUM(newid()) % 60), 0) +
		DATEADD(hour, ABS(CHECKSUM(newid()) % 24), 0) +
		DATEADD(day, ABS(CHECKSUM(newid()) % @days_diff), 0);

	DECLARE @deliveryDateFrom AS DATETIME = '2004-01-01';
	DECLARE @deliveryDateTo AS DATETIME = '2018-01-01';
	SET @days_diff = cast(@deliveryDateTo - @deliveryDateFrom AS INT);
	DECLARE @deliveryDate DATETIME;

	SELECT @deliveryDate = @deliveryDateFrom +
		DATEADD(second, ABS(CHECKSUM(newid()) % 60), 0) +
		DATEADD(minute, ABS(CHECKSUM(newid()) % 60), 0) +
		DATEADD(hour, ABS(CHECKSUM(newid()) % 24), 0) +
		DATEADD(day, ABS(CHECKSUM(newid()) % @days_diff), 0);

	SELECT TOP 1 @driverId = DriverId
	FROM dbo.DriverTruck
	WHERE TruckId = @truckId
	ORDER BY NEWID();

	INSERT INTO dbo.Shipment(
		[RouteId],
		[DriverId],
		[TruckId],
		[DepartureDate],
		[DeliveryDate]
	)
	VALUES(
		ROUND(((@routeCount - 1) * RAND() + 1), 0),
		@driverId,
		@truckId,
		@departureDate,
		@deliveryDate
	)

	SET @currentRow = @currentRow + 1;
END

SET @currentRow = 1;

WHILE @currentRow <= @cargosToInsert
BEGIN
	UPDATE dbo.Cargo
	SET ShipmentId = ROUND(((@shipmentsToInsert - 1) * RAND() + 1), 0)
	WHERE Id = @currentRow

	SET @currentRow = @currentRow + 1;
END

COMMIT TRANSACTION;