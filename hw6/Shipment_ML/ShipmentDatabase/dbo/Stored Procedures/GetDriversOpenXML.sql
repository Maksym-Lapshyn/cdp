
CREATE PROCEDURE dbo.GetDriversOpenXML (@filterList XML)
AS BEGIN
	DECLARE @handle INT;
	DECLARE @prepareXmlStatus INT;
	DECLARE @filterTable TABLE (FieldName NVARCHAR(100), FieldValue NVARCHAR(100));

	EXEC @prepareXmlStatus= sp_xml_preparedocument @handle OUTPUT, @filterList;

	INSERT INTO @filterTable
	SELECT *
	FROM OPENXML(@handle, '/filters/filter', 2)  
	WITH (
		fieldName NVARCHAR(100),
		fieldValue NVARCHAR(100)
	);

	EXEC sp_xml_removedocument @handle;

	DECLARE @whereString NVARCHAR(1000);
	 
	SELECT @whereString = COALESCE(@whereString + ' AND ' , '') + FieldName + ' = ' + '''' + FieldValue + ''''
	FROM @filterTable;

	DECLARE @sqlCommand NVARCHAR(2000);
	SET @sqlCommand = 'SELECT Firstname, Lastname, Birthdate FROM dbo.Driver WHERE ';
	SET @sqlCommand = CONCAT(@sqlCommand, '', @whereString);

	EXEC(@sqlCommand);
END

