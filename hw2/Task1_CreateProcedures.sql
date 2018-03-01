USE Shipment_ML;

GO

/*Procedure using EXEC*/

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetDriversExec')
DROP PROCEDURE dbo.GetDriversExec

GO

CREATE PROCEDURE dbo.GetDriversExec (@fieldName NVARCHAR(100), @fieldValue NVARCHAR(100))
AS BEGIN
	DECLARE @sqlCommand NVARCHAR(500);

	SET @sqlCommand = 'SELECT Firstname, Lastname, Birthdate FROM dbo.Driver WHERE ' + @fieldName + ' = ''' + @fieldValue  + ''';';

	EXEC(@sqlCommand);
END

GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetDriversExecuteSQL')
DROP PROCEDURE dbo.GetDriversExecuteSQL

GO

/*Procedure using EXECUTE sp_executesql*/

CREATE PROCEDURE dbo.GetDriversExecuteSQL (@fieldName NVARCHAR(100), @fieldValue NVARCHAR(100))
AS BEGIN
	DECLARE @sqlCommand NVARCHAR(500);

	SET @sqlCommand = 'SELECT Firstname, Lastname, Birthdate FROM dbo.Driver WHERE ' + @fieldName + '= @fieldValue;';

	EXECUTE sp_executesql @sqlCommand, N'@fieldValue NVARCHAR(100)', @fieldValue;
END

GO

/*Test for procedures*/

--DECLARE @fieldName NVARCHAR(100) = 'FirstName';
--DECLARE @fieldValue NVARCHAR(100) = 'John';

--EXEC dbo.GetDriversExecuteSQL @fieldName, @fieldValue;