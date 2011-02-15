
CREATE VIEW [HumanResources].[employees] 
AS 
SELECT 
e.[EmployeeID] AS [id],
e.[NationalIDNumber] AS [national_id_number],
e.[ContactID] AS [contact_id],
e.[LoginID] AS [login_id],
e.[ManagerID] AS [manager_id],
e.[Title] AS [title],
e.[BirthDate] AS [birth_date],
e.[MaritalStatus] AS [marital_status],
e.[Gender] AS [gender],
e.[HireDate] AS [hire_date],
e.[SalariedFlag] AS [salaried_flag],
e.[VacationHours] AS [vacation_hours],
e.[SickLeaveHours] AS [sick_leave_hours],
e.[CurrentFlag] AS [current_flag],
e.[rowguid],
e.[ModifiedDate] AS [updated_at]
FROM [HumanResources].[Employee] e;
