
CREATE PROCEDURE dbo.GetDriversExec (@fieldName NVARCHAR(100), @fieldValue NVARCHAR(100))
AS BEGIN
	DECLARE @sqlCommand NVARCHAR(500);

	SET @sqlCommand = 'SELECT Firstname, Lastname, Birthdate FROM dbo.Driver WHERE ' + @fieldName + ' = ''' + @fieldValue  + ''';';

	EXEC(@sqlCommand);
END

