select * from [dbo].[employees] where salary > (select avg(salary) from employees)

create table customer1 (id varchar(50) , name varchar(50) ,salary varchar(50))

create table task8(id varchar(50), name varchar(50))

EXEC master.dbo.xp_fileexist 'D:\Projects\SSIS\lesson2\customer1.txt'


CREATE TABLE task13_lookup (
    EmployeeID INT PRIMARY KEY,
    Name NVARCHAR(100),
    Department NVARCHAR(50),
    Salary INT
);


INSERT INTO task13_lookup(EmployeeID, Name, Department, Salary)
VALUES
(101, 'John Doe', 'HR', 50000),
(102, 'Jane Smith', 'IT', 60000),
(105, 'Sarah White', 'Sales', 52000);


exec msdb.dbo.sp_send_dbmail @profile_name = 'db_email', @recipients = 'nurillo2114@gmail.com', @body = 'uwu', @subject = 'important message'
