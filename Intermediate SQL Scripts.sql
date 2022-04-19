-- Inner joins, Outer joins (Left, Right, Full)

SELECT *
FROM SQL_simple..EmployeeDemographics

SELECT *
FROM SQL_simple..EmployeeSalary

SELECT *
FROM SQL_simple..EmployeeDemographics
INNER JOIN SQL_simple..EmployeeSalary  -- Defaults to an Inner Join
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT *
FROM SQL_simple..EmployeeDemographics
FULL OUTER JOIN SQL_simple..EmployeeSalary 
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT *
FROM SQL_simple..EmployeeDemographics
LEFT OUTER JOIN SQL_simple..EmployeeSalary 
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT *
FROM SQL_simple..EmployeeDemographics
RIGHT OUTER JOIN SQL_simple..EmployeeSalary 
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT EmployeeDemographics.EmployeeID, FirstName, LastName, Salary
FROM SQL_simple..EmployeeDemographics
INNER JOIN SQL_simple..EmployeeSalary 
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE FirstName <> 'Michael'
ORDER BY Salary DESC

SELECT JobTitle, AVG(Salary) AS SalesAVGSalary
FROM SQL_simple..EmployeeDemographics
INNER JOIN SQL_simple..EmployeeSalary 
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE JobTitle = 'Salesman'
GROUP BY JobTitle

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Union, Union All
SELECT *
FROM SQL_simple..EmployeeDemographics
UNION
SELECT *
FROM SQL_simple..WarehouseEmployeeDemographics

SELECT *
FROM SQL_simple..EmployeeDemographics
UNION ALL -- UNION ALL allows for duplicate entries to be in the union
SELECT *
FROM SQL_simple..WarehouseEmployeeDemographics
ORDER BY EmployeeID

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Case Statements

SELECT FirstName, LastName, Age,
CASE
	WHEN Age > 30 THEN 'Old'
	WHEN Age BETWEEN 27 AND 30 THEN 'Young'
	ELSE 'Baby'
END
FROM SQL_simple..EmployeeDemographics
WHERE Age is NOT NULL
ORDER BY Age

-- Use Case Calculating Raises
SELECT FirstName, LastName, JobTitle, Salary,
CASE
	WHEN JobTitle = 'Salesman' THEN Salary + (Salary * .10)
	WHEN JobTitle = 'Accountant' THEN Salary + (Salary * .05)
	WHEN JobTitle = 'HR' THEN Salary + (Salary * .000001)
	ELSE Salary + (Salary * .03)
END AS SalaryPostRaise
FROM SQL_simple..EmployeeDemographics
JOIN SQL_simple..EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Having Clause (Best used with Aggregate Functions / WHERE can't math)

SELECT JobTitle, COUNT(JobTitle) 
FROM SQL_simple.dbo.EmployeeDemographics
JOIN SQL_simple.dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle
HAVING COUNT(JobTitle) > 1  -- Having clause can only be used after the aggregated column has been grouped

SELECT JobTitle, AVG(Salary)
FROM SQL_simple.dbo.EmployeeDemographics
JOIN SQL_simple.dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle
HAVING AVG(Salary) > 45000
ORDER BY AVG(Salary)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Updating / Deleting (*TIP*  When writing Delete Statements first write them as a select to ensure you are deleting the correct data)

SELECT *
FROM SQL_simple..EmployeeDemographics

UPDATE SQL_simple..EmployeeDemographics
SET EmployeeID = 1012
WHERE FirstName = 'Holly' AND LastName = 'Flax'

UPDATE SQL_simple..EmployeeDemographics
SET Age = 31, Gender = 'Female'
WHERE FirstName = 'Holly' AND LastName = 'Flax'

DELETE FROM SQL_simple..EmployeeDemographics
WHERE EmployeeID = 1013 -- Duplicated 'Darryl Philbin' dbo.WarehouseEmployeeDemographics

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Aliasing 

SELECT FirstName + ' ' + LastName AS FullName
FROM SQL_simple..EmployeeDemographics

SELECT AVG(Age) AS AvgAge
FROM SQL_simple..EmployeeDemographics

SELECT Demo.EmployeeID
FROM SQL_simple..EmployeeDemographics AS Demo
JOIN SQL_simple..EmployeeSalary AS Sal
	ON Demo.EmployeeID = Sal.EmployeeID

SELECT Demo.EmployeeID, Demo.FirstName, Demo.LastName, Sal.JobTitle, WHDemo.Age
FROM SQL_simple..EmployeeDemographics AS Demo
LEFT JOIN SQL_simple..EmployeeSalary AS Sal
	ON Demo.EmployeeID = Sal.EmployeeID
LEFT JOIN SQL_simple..WarehouseEmployeeDemographics AS WHDemo
	ON Demo.EmployeeID = WHDemo.EmployeeID

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Partition By ( Similar to the GROUP BY statement but can condense functions when aggregates are needed)

SELECT FirstName, LastName, Gender, Salary
, COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender
FROM SQL_simple..EmployeeDemographics AS Demo
JOIN SQL_simple..EmployeeSalary AS Sal
	ON Demo.EmployeeID = Sal.EmployeeID

SELECT FirstName, LastName, Gender, Salary, COUNT(Gender)
FROM SQL_simple..EmployeeDemographics AS Demo
JOIN SQL_simple..EmployeeSalary AS Sal
	ON Demo.EmployeeID = Sal.EmployeeID
GROUP BY FirstName, LastName, Gender, Salary
