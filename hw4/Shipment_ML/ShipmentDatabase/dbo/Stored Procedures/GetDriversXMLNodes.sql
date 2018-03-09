
CREATE PROCEDURE dbo.GetDriversXMLNodes (@filterList XML)
AS BEGIN
	DECLARE @filterTable TABLE (FieldName NVARCHAR(100), FieldValue NVARCHAR(100));

	INSERT INTO @filterTable
	SELECT FieldName = Filter.value('(fieldName)[1]', 'NVARCHAR(100)'), FieldValue = Filter.value('(fieldValue)[1]', 'NVARCHAR(100)')
	FROM @filterList.nodes('/filters/filter') AS Filters(Filter);

	DECLARE @whereString NVARCHAR(1000);
	 
	SELECT @whereString = COALESCE(@whereString + ' AND ' , '') + FieldName + ' = ' + '''' + FieldValue + ''''
	FROM @filterTable;

	DECLARE @sqlCommand NVARCHAR(2000);
	SET @sqlCommand = 'SELECT Firstname, Lastname, Birthdate FROM dbo.Driver WHERE ';
	SET @sqlCommand = CONCAT(@sqlCommand, '', @whereString);

	EXEC(@sqlCommand);
END

/*Test for procedures*/

--GO

--DECLARE @filterList AS XML = 
--'<filters>
--	<filter>
--		<fieldName>LastName</fieldName>
--		<fieldValue>Olson</fieldValue>
--	</filter>
--	<filter>
--		<fieldName>FirstName</fieldName>
--		<fieldValue>Alta</fieldValue>
--	</filter>
--</filters>';

--EXEC dbo.GetDriversXMLNodes @filterList;

