USE Shipment_ML

set transaction isolation level repeatable read

GO

BEGIN TRANSACTION Transaction1
	SELECT *
	FROM dbo.[Route]
	WHERE Id = 2;

	WAITFOR DELAY '00:00:10';
COMMIT TRANSACTION Transaction2