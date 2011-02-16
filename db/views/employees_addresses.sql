
CREATE VIEW [HumanResources].[employees_addresses] 
AS 
SELECT 
ea.[EmployeeID] AS [employee_id],
ea.[AddressID] AS [address_id],
ea.[rowguid],
ea.[ModifiedDate] AS [updated_at]
FROM [HumanResources].[EmployeeAddress] ea;
