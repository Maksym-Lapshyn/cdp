CREATE FUNCTION [dbo].[CalculateUtilizedPercentage]
(
    @firstParam INT,
    @secondParam INT
)
RETURNS DECIMAL
AS BEGIN
    RETURN @firstParam / @secondParam * 100;
END
