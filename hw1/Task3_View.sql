USE Shipment_ML;

GO

/*FIRST VIEW*/

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
	LEFT JOIN dbo.Cargo c
		ON c.ShipmentId = s.Id 
	LEFT JOIN dbo.[Route] r
		ON r.Id = s.RouteId
	LEFT JOIN dbo.Warehouse o
		ON o.Id = r.OriginId
	LEFT JOIN dbo.Warehouse d
		ON d.Id = r.DestinationId
	LEFT JOIN dbo.Truck t
		ON t.Id = s.TruckId
GROUP BY s.Id, o.City, d.City, t.BrandName, s.DepartureDate, s.DeliveryDate, r.Distance, t.FuelConsumption;

GO

/*SECOND VIEW*/

CREATE VIEW dbo.vShipmentsCTE
AS
WITH
ShipmentCargo (Id, RouteId, TruckId, DepartureDate, DeliveryDate, TotalWeight, TotalVolume)
AS
(
	SELECT 
		s.Id,
		s.RouteId AS RouteId,
		s.TruckId AS TruckId,
		s.DepartureDate AS DepartureDate,
		s.DeliveryDate AS DeliveryDate,
		SUM(c.Weight) AS TotalWeight,
		SUM(c.Volume) AS TotalVolume
	FROM dbo.Shipment AS s
		LEFT OUTER JOIN dbo.Cargo AS c
		ON s.Id = c.ShipmentId
    GROUP BY s.Id, s.DepartureDate, s.DeliveryDate, s.RouteId, s.TruckId
)
SELECT 
	o.City AS Origin,
	d.City AS Destination,
	t.BrandName,
	DepartureDate,
	DeliveryDate,
	TotalWeight,
	TotalVolume,
	(r.Distance * t.FuelConsumption) / 100 AS FuelSpent
FROM
	ShipmentCargo
	LEFT JOIN dbo.[Route] as r
		ON ShipmentCargo.RouteId = r.Id
	LEFT JOIN dbo.Warehouse o
		ON o.Id = r.OriginId
	LEFT JOIN dbo.Warehouse d
		ON d.Id = r.DestinationId
	LEFT JOIN dbo.Truck t
		ON ShipmentCargo.TruckId = t.Id;

GO

/*THIRD VIEW -- THE OPTIMAL ONE*/

CREATE VIEW dbo.vShipmentsCrossApply
AS
SELECT 
	o.City AS Origin,
	d.City AS Destination,
	t.BrandName,
	s.DepartureDate,
	s.DeliveryDate,
	ca.TotalWeight,
	ca.TotalVolume,
	(r.Distance * t.FuelConsumption) / 100 AS FuelSpent
FROM dbo.Shipment s
	CROSS APPLY
	(
		SELECT SUM(c.Weight) AS TotalWeight, SUM(c.Volume) AS TotalVolume
		FROM dbo.Cargo c
		WHERE s.Id = c.ShipmentId
		GROUP BY c.ShipmentId
	) ca
	LEFT JOIN dbo.[Route] r
		ON r.Id = s.RouteId
	LEFT JOIN dbo.Warehouse o
		ON o.Id = r.OriginId
	LEFT JOIN dbo.Warehouse d
		ON d.Id = r.DestinationId
	LEFT JOIN dbo.Truck t
		ON t.Id = s.TruckId;