USE Shipment_ML;

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DeleteWarehouse')
DROP PROCEDURE dbo.DeleteWarehouse

GO

CREATE PROCEDURE dbo.DeleteWarehouse (@warehouseId INT)
AS BEGIN
	
	DECLARE @routesToDelete TABLE (Id INT);
	DECLARE @shipmentsToDelete TABLE (Id INT);
	DECLARE @cargosToDelete TABLE (Id INT);

	INSERT INTO @routesToDelete
	SELECT Id
	FROM dbo.[Route]
	WHERE OriginId = @warehouseId
	OR DestinationId = @warehouseId;

	INSERT INTO @shipmentsToDelete
	SELECT s.Id
	FROM dbo.Shipment AS s
	INNER JOIN @routesToDelete AS r
	ON r.Id = s.RouteId;

	INSERT INTO @cargosToDelete
	SELECT c.Id FROM dbo.Cargo AS c
	INNER JOIN @shipmentsToDelete AS s
	ON s.Id = c.ShipmentId;

	DELETE FROM dbo.Cargo
	WHERE Id IN (SELECT * FROM @cargosToDelete);

	DELETE
	FROM dbo.Shipment
	WHERE Id IN (SELECT * FROM @shipmentsToDelete);

	DELETE
	FROM dbo.[Route]
	WHERE Id IN (SELECT * FROM @routesToDelete);

	DELETE
	FROM dbo.Warehouse
	WHERE Id = @warehouseId;

END

/*First variant*/

--GO

--BEGIN TRANSACTION

--EXEC DeleteWarehouse 8;
--EXEC DeleteWarehouse 16;
--EXEC DeleteWarehouse 24;

--COMMIT TRANSACTION

/*Second variant*/

GO

BEGIN TRANSACTION

EXEC DeleteWarehouse 8;
EXEC DeleteWarehouse 16;
EXEC DeleteWarehouse 24;

COMMIT TRANSACTION