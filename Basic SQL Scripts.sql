-- Creating Employee Table Factory
CREATE TABLE EmployeeDemographics
(EmployeeID int,
FirstName varchar(50),
LastName varchar(50),
Age int,
Gender varchar(50)
)

-- Creating Employee Salary Table Factory
CREATE TABLE EmployeeSalary
( EmployeeID int,
JobTitle varchar(50),
Salary int
)
-- Populate Tables
INSERT INTO EmployeeDemographics VALUES
(1001, 'Jim', 'Halpert', 30, 'Male'),
(1002, 'Pam', 'Beasley', 30, 'Female'),
(1003, 'Dwight', 'Schrute', 29, 'Male'),
(1004, 'Angela', 'Martin', 31, 'Female'),
(1005, 'Toby', 'Flenderson', 32, 'Male'),
(1006, 'Michael', 'Scott', 35, 'Male'),
(1007, 'Meredith', 'Palmer', 32, 'Female'),
(1008, 'Stanley', 'Hudson', 38, 'Male'),
(1009, 'Kevin', 'Malone', 31, 'Male')

INSERT INTO EmployeeSalary VALUES
(1001, 'Salesman', 45000),
(1002, 'Receptionist', 36000),
(1003, 'Salesman', 63000),
(1004, 'Accountant', 47000),
(1005, 'HR', 50000),
(1006, 'Regional Manager', 65000),
(1007, 'Supplier Relations', 41000),
(1008, 'Salesman', 48000),
(1009, 'Accountant', 42000)

-- Select Statements (All, Top, Distinct, Count, As, Max, Min, Avg)
SELECT *
FROM EmployeeDemographics

SELECT TOP 5 *
FROM EmployeeDemographics

Select DISTINCT(LastName)
FROM EmployeeDemographics

SELECT COUNT(DISTINCT(JobTitle))
FROM EmployeeSalary

SELECT MAX(Salary)
FROM EmployeeSalary

SELECT MIN(Salary)
FROM EmployeeSalary

SELECT AVG(Salary)
FROM EmployeeSalary

-- Specifying Database
SELECT *
FROM SQL_simple..EmployeeSalary

-- Where Statements (=, <>, <, >, AND, OR, LIKE, NULL, NOT NULL, IN)

SELECT *
FROM SQL_simple..EmployeeDemographics
WHERE FirstName = 'Jim'

SELECT *
FROM EmployeeDemographics
WHERE FirstName <> 'Jim'

SELECT *
FROM EmployeeDemographics
WHERE Age < 30

SELECT *
FROM EmployeeDemographics
WHERE Age > 30


SELECT *
FROM EmployeeDemographics
WHERE Age <= 32 AND Gender = 'Male'

SELECT *
FROM EmployeeDemographics
WHERE Age <= 32 OR Gender = 'Female'

SELECT *
FROM EmployeeDemographics
WHERE LastName LIKE 'S%'

SELECT *
FROM EmployeeDemographics
WHERE FirstName is NULL

SELECT *
FROM EmployeeDemographics
WHERE FirstName is NOT NULL

SELECT *
FROM EmployeeDemographics
WHERE FirstName IN ('Jim', 'Michael', 'Dwight')

-- Group By, Order By Statements

SELECT Gender
FROM EmployeeDemographics
GROUP BY Gender

SELECT Gender, COUNT(Gender) AS GenderCount
FROM EmployeeDemographics
GROUP BY Gender

SELECT Gender, COUNT(Gender) AS EmployeesOver30
FROM EmployeeDemographics
WHERE Age >= 30
GROUP BY Gender

SELECT *
FROM EmployeeSalary
ORDER BY Salary ASC -- Defaults to ASC

SELECT *
FROM EmployeeSalary
ORDER BY Salary DESC

SELECT *
FROM EmployeeDemographics
ORDER BY Age ASC, Gender DESC

SELECT *
FROM EmployeeDemographics
ORDER BY 4 DESC, 5 DESC -- Column numbers can be used in place of Column names