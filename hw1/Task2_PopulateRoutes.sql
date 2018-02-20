USE Shipment_ML;

INSERT INTO dbo.Route(
	OriginId,
	DestinationId,
	Distance
)
SELECT DISTINCT
    origin.Id,
    destination.Id,
	FLOOR(RAND(CHECKSUM(NEWID()))*(3000 - 100 +1) + 100)
FROM 
    dbo.Warehouse AS origin,
    dbo.Warehouse AS destination
WHERE origin.Id != destination.Id;