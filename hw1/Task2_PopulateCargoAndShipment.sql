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
DECLARE @intMaxValue INT = 2147483647;

WHILE @currentRow < 10000
BEGIN
	INSERT INTO dbo.Cargo(
		[Weight],
		[Volume],
		[SenderId],
		[RecipientId]
	)
	VALUES(
		ROUND(((@intMaxValue - 1) * RAND() + 1), 0),
		ROUND(((@intMaxValue - 1) * RAND() + 1), 0),
		@contactId,
		@contactId
	)
	SET @currentRow = @currentRow + 1;
END

COMMIT TRANSACTION;