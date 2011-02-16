
CREATE VIEW [HumanResources].[employee_department_histories] 
AS 
SELECT 
edh.[EmployeeID] AS [employee_id],
edh.[DepartmentID] AS [department_id],
edh.[ShiftID] AS [shift_id],
CONVERT(date, edh.[StartDate]) AS [started_on],
CONVERT(date, edh.[EndDate]) AS [updated_on],
edh.[ModifiedDate] AS [updated_at]
FROM [HumanResources].[EmployeeDepartmentHistory] edh;
