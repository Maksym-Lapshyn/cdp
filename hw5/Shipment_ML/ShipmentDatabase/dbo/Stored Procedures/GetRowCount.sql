CREATE PROCEDURE [dbo].[GetRowCount]
    @tableName NVARCHAR(100)
AS
    DECLARE @SqlStatement nvarchar(500) = N'SELECT COUNT(1) FROM ' + @tableName + ';';
    EXEC (@SqlStatement)
