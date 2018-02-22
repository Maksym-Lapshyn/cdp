USE Shipment_ML;
GO
CREATE VIEW dbo.vShipments
AS
SELECT 
	o.City AS Origin,
	d.City AS Destination,
	t.BrandName,
	s.DepartureDate,
	s.DeliveryDate,
	SUM(c.Weight) AS TotalWeight,
	SUM(c.Volume) AS TotalVolume,
	(r.Distance * t.FuelConsumption) / 100 AS FuelSpent
FROM dbo.Shipment s
	LEFT OUTER JOIN dbo.Cargo c
	ON c.ShipmentId = s.Id 
	LEFT OUTER JOIN dbo.[Route] r
	ON r.Id= s.RouteId
	LEFT OUTER JOIN dbo.Warehouse o
	ON o.Id = r.OriginId
	LEFT OUTER JOIN dbo.Warehouse d
	ON d.Id = r.DestinationId
	LEFT OUTER JOIN dbo.Truck t
	ON t.Id = s.TruckId
GROUP BY s.Id, o.City, d.City, t.BrandName, s.DepartureDate, s.DeliveryDate, r.Distance, t.FuelConsumption;
GO
WITH
ShipmentCargo (Id, DepartureDate, DeliveryDate, TotalWeight, TotalVolume)
AS
(
	SELECT s.Id, s.DepartureDate AS DepartureDate, s.DeliveryDate AS DeliveryDate, SUM(c.Weight) AS TotalWeight, SUM(c.Volume) AS TotalVolume
	FROM dbo.Shipment AS s
		LEFT OUTER JOIN dbo.Cargo AS c
		ON s.Id = c.ShipmentId
    GROUP BY s.Id, s.DepartureDate, s.DeliveryDate
),
RouteWarehouse (Id, Origin, Destination)
AS
(
	SELECT
		r.Id AS Id,
		o.City AS Origin,
		d.City AS Destination
	FROM dbo.[Route] AS r
		LEFT OUTER JOIN dbo.Warehouse o
		ON r.OriginId = o.Id
		LEFT OUTER JOIN dbo.Warehouse d
		ON r.DestinationId = d.Id;
),
ShipmentTruckRoute (Id, FuelSpent)
AS
(
	SELECT
		r.Id AS Id,
		(r.Distance * t.FuelConsumption) / 100 AS FuelSpent
	FROM dbo.[Route] AS r
		LEFT OUTER JOIN dbo.Truck t
		ON r. = o.Id
),

CREATE VIEW dbo.ShipmentsCTE
