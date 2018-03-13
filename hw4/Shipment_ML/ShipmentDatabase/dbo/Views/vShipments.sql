CREATE VIEW [dbo].[vShipments]
    AS WITH Weights AS(
        SELECT s2.Id AS ShipmentId,
            SUM(c2.[Weight]) AS TotalWeight
        FROM dbo.Shipment AS s2
        INNER JOIN dbo.Cargo AS c2
            ON s2.Id = c2.Id
        GROUP BY
            s2.Id
    ),
    Volumes AS(
        SELECT s2.Id AS ShipmentId,
            SUM(c2.Volume) AS TotalVolume
        FROM dbo.Shipment AS s2
        INNER JOIN dbo.Cargo AS c2
            ON s2.Id = c2.Id
        GROUP BY
            s2.Id
    )
    SELECT 
        s.DepartureDate,
        s.DeliveryDate,
        s.TruckId,
        t.BrandName AS TruckBrand,
        t.[Name] AS TruckName,
        o.Id AS OriginId,
        o.City AS OriginCity,
        o.[State] AS OriginSate,
        d.Id AS DestinationId,
        d.City AS DestinationCity,
        d.[State] AS DestinationState,
        s.[Status],
        SUM(c.[Weight]) AS TotalWeight,
        SUM(c.Volume) AS TotalVolume,
        COUNT(c.Id) AS CargoCount,
        dbo.CalculateUtilizedPercentage(v.TotalVolume, t.Volume) AS UtilizedCapacity,
        dbo.CalculateUtilizedPercentage(w.TotalWeight, t.Payload) AS UtilizedPayload
    FROM [dbo].[Shipment] AS s
    INNER JOIN [dbo].[Truck] AS t
    ON s.TruckId = t.Id
    INNER JOIN [dbo].[Route] AS r
    ON s.RouteId = r.Id
    INNER JOIN [dbo].[Warehouse] AS o
    ON r.OriginId = o.Id
    INNER JOIN [dbo].[Warehouse] AS d
    ON r.DestinationId = d.Id
    INNER JOIN [dbo].[Cargo] AS c
    ON s.Id = c.ShipmentId
    INNER JOIN Weights AS w
    ON s.Id = w.ShipmentId
    INNER JOIN Volumes AS v
    ON s.Id = v.ShipmentId
    GROUP BY
        s.DepartureDate,
        s.DeliveryDate,
        s.TruckId,
        t.BrandName,
        t.[Name],
        t.Volume,
        t.Payload,
        o.Id,
        o.City,
        o.[State],
        d.Id,
        d.City,
        d.[State],
        s.[Status],
        c.[Weight],
        c.Volume,
        v.TotalVolume,
        w.TotalWeight