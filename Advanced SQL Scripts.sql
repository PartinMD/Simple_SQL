-- CTEs (Common Table Expressions) Rarely described as "WITH statements"

WITH CTE_Employee as
(SELECT FirstName, LastName, Gender, Salary
, COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender
, AVG(Salary) OVER (PARTITION BY Gender) AS AvgSalary
FROM SQL_simple..EmployeeDemographics AS Demo
JOIN SQL_simple..EmployeeSalary AS Sal
	ON Demo.EmployeeID = Sal.EmployeeID
WHERE Salary > '45000'
) 
SELECT *
FROM CTE_Employee

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Temp Tables

CREATE TABLE #temp_Employee (
EmployeeID int,
JobTitle varchar(100),
Salary int
)

SELECT *
FROM #temp_Employee

INSERT INTO #temp_Employee VALUES
('1001', 'HR', '45000')

INSERT INTO #temp_Employee
SELECT *
FROM SQL_simple..EmployeeSalary

-- Real use
DROP TABLE IF EXISTS #temp_Employee2  -- Good to use to prevent this in the event of Stored Procedures
CREATE TABLE #temp_Employee2 ( 
JobTitle varchar(50),
EmployeesPerJob int,
AvgAge int,
AvgSalary int
)

INSERT INTO #temp_Employee2
SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(Salary)
FROM SQL_simple..EmployeeDemographics AS Demo
JOIN SQL_simple..EmployeeSalary AS Sal
	ON Demo.EmployeeID = Sal.EmployeeID
GROUP BY JobTitle

SELECT *
FROM #temp_Employee2
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- String Functions - TRIM, LTRIM, RTRIM, REPLACE, SUBSTRING, UPPER, LOWER

--DROP TABLE EmployeeErrors;

CREATE TABLE EmployeeErrors (
EmployeeID varchar(50)
, FirstName varchar(50)
, LastName varchar(50)
)

INSERT INTO EmployeeErrors VALUES
('1001   ', 'Jimbo', 'Halbert')
,('   1002', 'Pamela', 'Beasely')
,('1005', 'TOby', 'Flenderson - Fired')

SELECT *
FROM EmployeeErrors

-- TRIM, LTRIM, RTRIM
SELECT EmployeeID, TRIM(EmployeeID) as IDTrim
FROM EmployeeErrors

SELECT EmployeeID, LTRIM(EmployeeID) as IDTrim
FROM EmployeeErrors

SELECT EmployeeID, RTRIM(EmployeeID) as IDTrim
FROM EmployeeErrors

-- REPLACE
SELECT LastName, REPLACE(LastName, '- Fired', '') AS LastNameFixed
FROM EmployeeErrors

-- SUBSTRING
SELECT Err.FirstName, SUBSTRING(Err.FirstName, 1, 3), Demo.FirstName, SUBSTRING(Demo.FirstName, 1, 3)
FROM EmployeeErrors AS Err
JOIN EmployeeDemographics AS Demo
	ON SUBSTRING(Err.FirstName, 1, 3) = SUBSTRING(Demo.FirstName, 1, 3)

-- UPPER / LOWER

SELECT FirstName, LOWER(FirstName)
FROM EmployeeErrors

SELECT FirstName, UPPER(FirstName)
FROM EmployeeErrors

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Stored Procedures

CREATE PROCEDURE TEST
AS
SELECT *
FROM EmployeeDemographics

EXEC TEST

-- More Complex

CREATE PROCEDURE Temp_Employee
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
GROUP BY JobTitle

SELECT *
FROM #temp_Employee3

EXEC Temp_Employee @JobTitle = 'Salesman'

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Subqueries (in the SELECT, FROM, and WHERE statements)

-- SELECT (Same result as below)
SELECT EmployeeID, Salary, (SELECT AVG(Salary) FROM EmployeeSalary) AS AvgSalary
FROM EmployeeSalary

-- PARTITION BY (Same result as above)
SELECT EmployeeID, Salary, AVG(Salary) OVER () AS AvgSalary
FROM EmployeeSalary

-- FROM (CTE or Temp Table more practical in this event)
SELECT a.EmployeeID, AvgSalary
FROM (SELECT EmployeeID, Salary, AVG(Salary) OVER () AS AvgSalary
	  FROM EmployeeSalary) AS a

-- WHERE
SELECT EmployeeID, JobTitle, Salary
FROM EmployeeSalary
WHERE EmployeeID in (
	SELECT EmployeeID 
	FROM EmployeeDemographics
	WHERE Age > 30)
