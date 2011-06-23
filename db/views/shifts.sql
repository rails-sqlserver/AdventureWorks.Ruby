
CREATE VIEW [HumanResources].[shifts] 
AS 
SELECT 
s.[ShiftID] AS [id],
s.[Name] AS [name],
s.[StartTime] AS [start_at],
s.[EndTime] AS [end_at],
s.[ModifiedDate] AS [updated_at]
FROM [HumanResources].[Shift] s;
