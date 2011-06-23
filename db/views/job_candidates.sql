
CREATE VIEW [HumanResources].[job_candidates] 
AS 
SELECT 
jc.[JobCandidateID] AS [id],
jc.[EmployeeID] AS [employee_id],
jc.[Resume] AS [resume],
jc.[ModifiedDate] AS [updated_at]
FROM [HumanResources].[JobCandidate] jc;
