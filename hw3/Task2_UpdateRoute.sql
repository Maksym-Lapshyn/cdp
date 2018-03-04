USE Shipment_ML;

BEGIN TRANSACTION Transaction2
	UPDATE dbo.[Route]
	SET DestinationId = 5
	WHERE Id = 2;
COMMIT TRANSACTION Transaction2