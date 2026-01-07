-- 1.
CREATE TABLE #EmployeeTransfers (
    EmployeeID INT,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary INT
);

INSERT INTO #EmployeeTransfers (EmployeeID, Name, Department, Salary)
SELECT 
    EmployeeID,
    Name,
    CASE Department
        WHEN 'HR' THEN 'IT'
        WHEN 'IT' THEN 'Sales'
        WHEN 'Sales' THEN 'HR'      
    END AS Department,
    Salary
FROM Employees;

SELECT * FROM #EmployeeTransfers;


-- 2
DECLARE @MissingOrders TABLE (
    OrderID INT,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);


INSERT INTO @MissingOrders (OrderID, CustomerName, Product, Quantity)
SELECT o1.OrderID, o1.CustomerName, o1.Product, o1.Quantity
FROM Orders_DB1 o1
LEFT JOIN Orders_DB2 o2 ON o1.OrderID = o2.OrderID
WHERE o2.OrderID IS NULL;

SELECT * FROM @MissingOrders;


-- 3
CREATE VIEW vw_MonthlyWorkSummary AS
SELECT 
    EmployeeID,
    EmployeeName,
    Department,
    SUM(HoursWorked) AS TotalHoursWorked
FROM WorkLog
GROUP BY EmployeeID, EmployeeName, Department;


CREATE VIEW vw_MonthlyWorkSummaryDept AS
SELECT 
    Department,
    SUM(HoursWorked) AS TotalHoursDepartment
FROM WorkLog
GROUP BY Department;


CREATE VIEW vw_AvgHoursPerDept AS
SELECT 
    Department,
    AVG(HoursWorked) AS AvgHoursDepartment
FROM WorkLog
GROUP BY Department;


SELECT * FROM vw_MonthlyWorkSummary;
SELECT * FROM vw_MonthlyWorkSummaryDept;
SELECT * FROM vw_AvgHoursPerDept;
