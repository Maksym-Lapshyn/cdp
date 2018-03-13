CREATE FUNCTION dbo.GenerateRandomDate (@dateFrom DATETIME, @dateTo DATETIME)
RETURNS DATETIME
AS BEGIN
    DECLARE @days_diff AS INT = cast(@dateTo - @dateFrom AS INT);
	DECLARE @departureDate DATETIME;

	SELECT @departureDate = @dateFrom +
		DATEADD(second, ABS(CHECKSUM((SELECT Id FROM dbo.vNewId)) % 60), 0) +
		DATEADD(minute, ABS(CHECKSUM((SELECT Id FROM dbo.vNewId)) % 60), 0) +
		DATEADD(hour, ABS(CHECKSUM((SELECT Id FROM dbo.vNewId)) % 24), 0) +
		DATEADD(day, ABS(CHECKSUM((SELECT Id FROM dbo.vNewId)) % @days_diff), 0);

    RETURN @departureDate
END

