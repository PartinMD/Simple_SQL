USE [SQL_simple]
GO
/****** Object:  StoredProcedure [dbo].[Temp_Employee]    Script Date: 4/19/2022 12:50:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Temp_Employee]
@JobTitle nvarchar(100)
AS
CREATE TABLE #temp_Employee3 (
JobTitle varchar(100),
EmployeesPerJob int,
AvgAge int,
AvgSalary int
)

INSERT INTO #temp_Employee3
SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(Salary)
FROM SQL_simple..EmployeeDemographics AS Demo
JOIN SQL_simple..EmployeeSalary AS Sal
	ON Demo.EmployeeID = Sal.EmployeeID
WHERE JobTitle = @JobTitle
GROUP BY JobTitle

SELECT *
FROM #temp_Employee3