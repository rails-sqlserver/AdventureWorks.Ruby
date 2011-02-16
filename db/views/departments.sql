
CREATE VIEW [HumanResources].[departments] 
AS 
SELECT 
d.[DepartmentID] AS [id],
d.[name] AS [name],
d.[GroupName] AS [group_name],
d.[ModifiedDate] AS [updated_at]
FROM [HumanResources].[Department] d;

