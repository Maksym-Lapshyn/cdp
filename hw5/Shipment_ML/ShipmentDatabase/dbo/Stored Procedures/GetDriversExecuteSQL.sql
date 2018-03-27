
/*Procedure using EXECUTE sp_executesql*/

CREATE PROCEDURE dbo.GetDriversExecuteSQL (@fieldName NVARCHAR(100), @fieldValue NVARCHAR(100))
AS BEGIN
	DECLARE @sqlCommand NVARCHAR(500);

	SET @sqlCommand = 'SELECT Firstname, Lastname, Birthdate FROM dbo.Driver WHERE ' + @fieldName + '= @fieldValue;';

	EXECUTE sp_executesql @sqlCommand, N'@fieldValue NVARCHAR(100)', @fieldValue;
END

