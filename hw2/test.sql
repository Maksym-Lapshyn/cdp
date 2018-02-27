USE Shipment_ML;

DECLARE @filterList AS XML = 
'<filters>
	<filter>
		<fieldName>LastName</fieldName>
		<fieldValue>Olson</fieldValue>
	</filter>
	<filter>
		<fieldName>FirstName</fieldName>
		<fieldValue>Alta</fieldValue>
	</filter>
</filters>';

DECLARE @handle INT;
DECLARE @PrepareXmlStatus INT;
DECLARE @filterTable TABLE (id INT IDENTITY(1,1), fieldName NVARCHAR(100), fieldValue NVARCHAR(100));

EXEC @PrepareXmlStatus= sp_xml_preparedocument @handle OUTPUT, @filterList;

INSERT INTO @filterTable
SELECT *
FROM OPENXML(@handle, '/filters/filter', 2)  
WITH (
	fieldName NVARCHAR(100),
	fieldValue NVARCHAR(100)
);

EXEC sp_xml_removedocument @handle;

DECLARE @whereTable TABLE (id INT, filter NVARCHAR(100));

INSERT INTO @whereTable
	SELECT f.id, (f.fieldName + ' = ' + '''' + f.fieldValue + '''')
	FROM @filterTable f;

DECLARE @filterCount INT;
DECLARE @counter INT;
DECLARE @sqlCommand NVARCHAR(1000);
SET @filterCount = (SELECT COUNT(*) FROM @filterTable);
SET @counter = 1;
SET @sqlCommand = 'SELECT Firstname, Lastname, Birthdate FROM dbo.Driver WHERE ';
PRINT @sqlCommand;

WHILE @counter <= @filterCount
BEGIN
	DECLARE @filter NVARCHAR(50);
	SET @filter = (SELECT filter FROM @whereTable w WHERE w.id = @counter);
	PRINT @filter;

	IF (@counter = 1)
	BEGIN
		SET @sqlCommand = CONCAT(@sqlCommand, '', @filter);
	END

	IF (@counter > 1)
	BEGIN
		SET @sqlCommand = CONCAT(@sqlCommand, ' AND ', @filter);
	END

	SET @counter = @counter + 1;
END

PRINT @sqlCommand;

EXEC(@sqlCommand);