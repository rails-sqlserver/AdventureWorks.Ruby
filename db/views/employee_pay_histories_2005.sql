
CREATE VIEW [HumanResources].[employee_pay_histories] 
AS 
SELECT 
eph.[EmployeeID] AS [employee_id],
eph.[RateChangeDate] AS [rate_changed_on],
eph.[Rate] AS [rate],
eph.[PayFrequency] AS [pay_frequency],
eph.[ModifiedDate] AS [updated_at]
FROM [HumanResources].[EmployeePayHistory] eph;
