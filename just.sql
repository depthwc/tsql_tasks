select * from [dbo].[employees] where salary > (select avg(salary) from employees)

create table customer1 (id varchar(50) , name varchar(50) ,salary varchar(50))

create table task8(id varchar(50), name varchar(50))

EXEC master.dbo.xp_fileexist 'D:\Projects\SSIS\lesson2\customer1.txt'