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
DECLARE @shipmentsToInsert INT = 1000;
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

	DECLARE @dateFrom AS DATETIME = '1990-01-01';
	DECLARE @dateTo AS DATETIME = '2004-01-01';
	DECLARE @days_diff AS INT = cast(@dateTo - @dateFrom AS INT);
	DECLARE @departureDate DATETIME;

	SELECT @departureDate = @dateFrom +
		DATEADD(second, ABS(CHECKSUM(newid()) % 60), 0) +
		DATEADD(minute, ABS(CHECKSUM(newid()) % 60), 0) +
		DATEADD(hour, ABS(CHECKSUM(newid()) % 24), 0) +
		DATEADD(day, ABS(CHECKSUM(newid()) % @days_diff), 0);

	SET @dateFrom = '2004-01-01';
	SET @dateTo = '2018-01-01';
	SET @days_diff = cast(@dateTo - @dateFrom AS INT);
	DECLARE @deliveryDate DATETIME;

	SELECT @deliveryDate = @dateFrom +
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

SET @currentRow = 0;
DECLARE @contactId INT = 1;
DECLARE @cargosToInsert INT = 10000;
DECLARE @maxVolume INT = 50;
DECLARE @minVolume INT = 1;
DECLARE @maxWeight INT = 5000;
DECLARE @minWeight INT = 1;

WHILE @currentRow < @cargosToInsert
BEGIN
	INSERT INTO dbo.Cargo(
		[Weight],
		[Volume],
		[SenderId],
		[RecipientId],
		[ShipmentId]
	)
	VALUES(
		FLOOR(RAND()*(@maxWeight - @minWeight) + @minWeight),
		FLOOR(RAND()*(@maxVolume - @minVolume) + @minVolume),
		@contactId,
		@contactId,
		FLOOR(RAND()*(@shipmentsToInsert - 1) + 1)
	)

	SET @currentRow = @currentRow + 1;
END