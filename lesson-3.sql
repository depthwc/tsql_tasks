--## DDL
--sql
--CREATE TABLE Employees (
--    EmployeeID INT PRIMARY KEY,
--    FirstName VARCHAR(50),
--    LastName VARCHAR(50),
--    Department VARCHAR(50),
--    Salary DECIMAL(10,2),
--    HireDate DATE
--);

--CREATE TABLE Orders (
--    OrderID INT PRIMARY KEY,
--    CustomerName VARCHAR(100),
--    OrderDate DATE,
--    TotalAmount DECIMAL(10,2),
--    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
--);

--CREATE TABLE Products (
--    ProductID INT PRIMARY KEY,
--    ProductName VARCHAR(100),
--    Category VARCHAR(50),
--    Price DECIMAL(10,2),
--    Stock INT
--);


-----

--### **Task 1: Employee Salary Report**
--Write an SQL query that:
--- Selects the **top 10% highest-paid** employees.
--- Groups them by **department** and calculates the **average salary per department**.
--- Displays a new column `SalaryCategory`:
--  - 'High' if Salary > 80,000  
--  - 'Medium' if Salary is **between** 50,000 and 80,000  
--  - 'Low' otherwise.  
--- Orders the result by `AverageSalary` **descending**.
--- Skips the first 2 records and fetches the next 5.

-----

--### **Task 2: Customer Order Insights**
--Write an SQL query that:
--- Selects customers who placed orders **between** '2023-01-01' and '2023-12-31'.  
--- Includes a new column `OrderStatus` that returns:
--  - 'Completed' for **Shipped** or **Delivered** orders.  
--  - 'Pending' for **Pending** orders.  
--  - 'Cancelled' for **Cancelled** orders.  
--- Groups by `OrderStatus` and finds the **total number of orders** and **total revenue**.  
--- Filters only statuses where revenue is greater than 5000.  
--- Orders by `TotalRevenue` **descending**.

-----

--### **Task 3: Product Inventory Check**
--Write an SQL query that:
--- Selects **distinct** product categories.
--- Finds the **most expensive** product in each category.
--- Assigns an inventory status using `IIF`:
--  - 'Out of Stock' if `Stock = 0`.  
--  - 'Low Stock' if `Stock` is **between** 1 and 10.  
--  - 'In Stock' otherwise.  
--- Orders the result by `Price` **descending** and skips the first 5 rows.


CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);


--1
INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary, HireDate)
VALUES
(1, 'John', 'Doe', 'IT', 95000, '2018-03-15'),
(2, 'Jane', 'Smith', 'HR', 60000, '2019-07-10'),
(3, 'Michael', 'Brown', 'Finance', 85000, '2017-01-20'),
(4, 'Emily', 'Davis', 'Marketing', 45000, '2020-11-05'),
(5, 'Daniel', 'Wilson', 'IT', 72000, '2021-02-14'),
(6, 'Sophia', 'Taylor', 'Finance', 50000, '2016-09-30'),
(7, 'David', 'Anderson', 'HR', 82000, '2015-05-21'),
(8, 'Olivia', 'Thomas', 'Sales', 55000, '2019-12-01'),
(9, 'James', 'Martin', 'Sales', 91000, '2014-08-19'),
(10, 'Ava', 'Lee', 'Marketing', 67000, '2022-04-25'),

(11, 'Liam', 'Harris', 'IT', 99000, '2018-06-12'),
(12, 'Emma', 'Clark', 'Finance', 72000, '2017-09-18'),
(13, 'Noah', 'Lewis', 'HR', 53000, '2020-05-04'),
(14, 'Isabella', 'Young', 'Sales', 47000, '2019-11-30'),
(15, 'Mason', 'Walker', 'IT', 87000, '2016-01-10'),
(16, 'Mia', 'Hall', 'Finance', 64000, '2021-07-21'),
(17, 'Ethan', 'Allen', 'Marketing', 78000, '2015-04-02'),
(18, 'Amelia', 'King', 'HR', 51000, '2018-09-25'),
(19, 'Logan', 'Wright', 'Sales', 92000, '2014-03-14'),
(20, 'Harper', 'Scott', 'IT', 56000, '2019-02-11'),

(21, 'Lucas', 'Green', 'Finance', 83000, '2017-08-07'),
(22, 'Charlotte', 'Adams', 'HR', 48000, '2020-10-09'),
(23, 'Jackson', 'Baker', 'IT', 71000, '2021-05-16'),
(24, 'Avery', 'Nelson', 'Marketing', 69000, '2018-12-20'),
(25, 'Oliver', 'Carter', 'Sales', 76000, '2019-01-28'),
(26, 'Ella', 'Mitchell', 'Finance', 52000, '2016-03-12'),
(27, 'Benjamin', 'Perez', 'IT', 88000, '2015-07-03'),
(28, 'Abigail', 'Roberts', 'HR', 54000, '2018-11-15'),
(29, 'Elijah', 'Turner', 'Sales', 96000, '2014-09-27'),
(30, 'Sofia', 'Phillips', 'Marketing', 61000, '2022-06-01'),

(31, 'Alexander', 'Campbell', 'IT', 73000, '2016-08-22'),
(32, 'Emily', 'Parker', 'Finance', 94000, '2017-02-14'),
(33, 'Jacob', 'Evans', 'HR', 50000, '2020-03-30'),
(34, 'Madison', 'Edwards', 'Sales', 58000, '2019-04-18'),
(35, 'William', 'Collins', 'IT', 81000, '2015-05-26'),
(36, 'Aria', 'Stewart', 'Finance', 67000, '2021-11-07'),
(37, 'Matthew', 'Sanchez', 'Marketing', 89000, '2018-07-12'),
(38, 'Scarlett', 'Morris', 'HR', 45000, '2019-10-03'),
(39, 'Joseph', 'Rogers', 'Sales', 99000, '2014-02-25'),
(40, 'Victoria', 'Reed', 'IT', 65000, '2020-01-09'),

(41, 'Samuel', 'Cook', 'Finance', 78000, '2016-06-18'),
(42, 'Grace', 'Morgan', 'HR', 47000, '2021-09-22'),
(43, 'Henry', 'Bell', 'IT', 93000, '2017-04-05'),
(44, 'Chloe', 'Murphy', 'Sales', 54000, '2019-12-13'),
(45, 'Sebastian', 'Bailey', 'Marketing', 87000, '2015-03-19'),
(46, 'Lily', 'Rivera', 'Finance', 59000, '2020-08-27'),
(47, 'Jack', 'Cooper', 'IT', 91000, '2018-05-11'),
(48, 'Zoe', 'Richardson', 'HR', 62000, '2019-06-30'),
(49, 'Owen', 'Cox', 'Sales', 70000, '2014-11-16'),
(50, 'Hannah', 'Howard', 'Marketing', 49000, '2022-03-08'),

-- continuing up to 100
(51, 'Daniel', 'Ward', 'IT', 85000, '2016-12-21'),
(52, 'Layla', 'Torres', 'Finance', 93000, '2017-08-01'),
(53, 'Gabriel', 'Peterson', 'HR', 55000, '2020-02-17'),
(54, 'Riley', 'Gray', 'Sales', 63000, '2019-05-25'),
(55, 'Anthony', 'Ramirez', 'IT', 76000, '2015-01-07'),
(56, 'Nora', 'James', 'Finance', 51000, '2021-10-12'),
(57, 'Dylan', 'Watson', 'Marketing', 92000, '2018-11-23'),
(58, 'Lillian', 'Brooks', 'HR', 49000, '2019-01-14'),
(59, 'Wyatt', 'Kelly', 'Sales', 87000, '2014-06-05'),
(60, 'Addison', 'Sanders', 'IT', 66000, '2020-09-29'),

(61, 'Nathan', 'Price', 'Finance', 97000, '2016-04-03'),
(62, 'Aubrey', 'Bennett', 'HR', 53000, '2021-02-20'),
(63, 'Caleb', 'Wood', 'IT', 89000, '2017-07-15'),
(64, 'Evelyn', 'Barnes', 'Sales', 57000, '2019-03-27'),
(65, 'Christopher', 'Ross', 'Marketing', 99000, '2015-09-09'),
(66, 'Zoey', 'Henderson', 'Finance', 68000, '2020-12-04'),
(67, 'Isaac', 'Coleman', 'IT', 75000, '2018-05-30'),
(68, 'Elizabeth', 'Jenkins', 'HR', 48000, '2019-11-21'),
(69, 'Thomas', 'Perry', 'Sales', 94000, '2014-07-02'),
(70, 'Penelope', 'Powell', 'Marketing', 60000, '2022-05-18'),

(71, 'Charles', 'Long', 'IT', 81000, '2016-10-11'),
(72, 'Victoria', 'Patterson', 'Finance', 92000, '2017-12-08'),
(73, 'Levi', 'Hughes', 'HR', 50000, '2020-06-15'),
(74, 'Samantha', 'Flores', 'Sales', 65000, '2019-09-03'),
(75, 'Eli', 'Washington', 'IT', 70000, '2015-02-28'),
(76, 'Mila', 'Butler', 'Finance', 54000, '2021-08-23'),
(77, 'Hunter', 'Simmons', 'Marketing', 88000, '2018-01-19'),
(78, 'Paisley', 'Foster', 'HR', 49000, '2019-04-09'),
(79, 'Christian', 'Gonzalez', 'Sales', 98000, '2014-10-26'),
(80, 'Aurora', 'Bryant', 'IT', 67000, '2020-12-17'),

(81, 'Jonathan', 'Alexander', 'Finance', 94000, '2016-09-21'),
(82, 'Camila', 'Russell', 'HR', 55000, '2021-01-02'),
(83, 'Aaron', 'Griffin', 'IT', 86000, '2017-05-06'),
(84, 'Hannah', 'Diaz', 'Sales', 60000, '2019-06-22'),
(85, 'Adrian', 'Hayes', 'Marketing', 75000, '2015-11-14'),
(86, 'Stella', 'Myers', 'Finance', 52000, '2020-02-11'),
(87, 'Cameron', 'Ford', 'IT', 93000, '2018-03-27'),
(88, 'Natalie', 'Hamilton', 'HR', 47000, '2019-08-08'),
(89, 'Jeremiah', 'Graham', 'Sales', 91000, '2014-01-31'),
(90, 'Hazel', 'Sullivan', 'Marketing', 68000, '2022-07-06'),

(91, 'Connor', 'Wallace', 'IT', 80000, '2016-06-29'),
(92, 'Ellie', 'Woods', 'Finance', 97000, '2017-10-18'),
(93, 'Jordan', 'Cole', 'HR', 56000, '2020-12-27'),
(94, 'Brooklyn', 'West', 'Sales', 64000, '2019-03-02'),
(95, 'Ian', 'Jordan', 'Marketing', 89000, '2015-08-16'),
(96, 'Leah', 'Stone', 'Finance', 61000, '2020-05-19'),
(97, 'Carson', 'Ramsey', 'IT', 78000, '2018-09-09'),
(98, 'Savannah', 'Hunt', 'HR', 49000, '2019-02-12'),
(99, 'Ezekiel', 'Black', 'Sales', 96000, '2014-12-05'),
(100, 'Claire', 'Warren', 'Marketing', 70000, '2021-04-15');



SELECT 
    Department,
    AVG(Salary) AS AverageSalary,
    CASE 
        WHEN AVG(Salary) > 80000 THEN 'High'
        WHEN AVG(Salary) BETWEEN 50000 AND 80000 THEN 'Medium'
        ELSE 'Low'
    END AS SalaryCategory
FROM (
    SELECT 
        EmployeeID,
        FirstName,
        LastName,
        Department,
        Salary,
        PERCENT_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
    FROM Employees
) AS RankedEmployees
WHERE SalaryRank <= 0.10
GROUP BY Department
ORDER BY AverageSalary DESC
OFFSET 2 ROWS FETCH NEXT 5 ROWS ONLY;

--2


CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
);




SELECT 
    CASE 
        WHEN Status IN ('Shipped', 'Delivered') THEN 'Completed'
        WHEN Status = 'Pending' THEN 'Pending'
        WHEN Status = 'Cancelled' THEN 'Cancelled'
    END AS OrderStatus,
    COUNT(*) AS TotalOrders,
    SUM(TotalAmount) AS TotalRevenue
FROM Orders
WHERE OrderDate BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY 
    CASE 
        WHEN Status IN ('Shipped', 'Delivered') THEN 'Completed'
        WHEN Status = 'Pending' THEN 'Pending'
        WHEN Status = 'Cancelled' THEN 'Cancelled'
    END
HAVING SUM(TotalAmount) > 5000
ORDER BY TotalRevenue DESC;


--3


CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);

SELECT 
    p.Category,
    p.ProductName,
    p.Price,
    IIF(p.Stock = 0, 'Out of Stock',
        IIF(p.Stock BETWEEN 1 AND 10, 'Low Stock', 'In Stock')) AS InventoryStatus
FROM Products p
WHERE p.Price = (
    SELECT MAX(p2.Price)
    FROM Products p2
    WHERE p2.Category = p.Category
)
ORDER BY p.Price DESC
OFFSET 5 ROWS;

select *
from Employees
where Department='IT' and Salary>90000
order by Salary desc

SELECT 
    Department,
    COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY Department;

SELECT 
    Department,
    COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY Department
ORDER BY EmployeeCount DESC;