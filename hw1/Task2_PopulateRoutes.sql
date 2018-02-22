USE Shipment_ML;

DECLARE @maxDistance INT = 3000;
DECLARE @minDistance INT = 100;

INSERT INTO dbo.Route(
	OriginId,
	DestinationId,
	Distance
)
SELECT DISTINCT
    origin.Id,
    destination.Id,
	FLOOR(RAND(CHECKSUM(NEWID()))*(@maxDistance - @minDistance) + @minDistance)
FROM 
    dbo.Warehouse AS origin
CROSS JOIN
    dbo.Warehouse AS destination
WHERE origin.Id != destination.Id;