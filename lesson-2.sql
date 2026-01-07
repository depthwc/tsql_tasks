--#### **1. DELETE vs TRUNCATE vs DROP (with IDENTITY example)**
--- Create a table `test_identity` with an `IDENTITY(1,1)` column and insert 5 rows.
--- Use `DELETE`, `TRUNCATE`, and `DROP` one by one (in different test cases) and observe how they behave.
--- Answer the following questions:
--	1. What happens to the identity column when you use `DELETE`?
--	2. What happens to the identity column when you use `TRUNCATE`?
--	3. What happens to the table when you use `DROP`?

--#### **2. Common Data Types**
--- Create a table `data_types_demo` with columns covering at least **one example of each data type** covered in class.
--- Insert values into the table.
--- Retrieve and display the values.

--#### **3. Inserting and Retrieving an Image**
--- Create a `photos` table with an `id` column and a `varbinary(max)` column.
--- Insert an image into the table using `OPENROWSET`.
--- Write a Python script to retrieve the image and save it as a file.

--#### **4. Computed Columns**
--- Create a `student` table with a computed column `total_tuition` as `classes * tuition_per_class`.
--- Insert 3 sample rows.
--- Retrieve all data and check if the computed column works correctly.

--#### **5. CSV to SQL Server**
--- Download or create a CSV file with at least 5 rows of worker data (`id, name`).
--- Use `BULK INSERT` to import the CSV file into the `worker` table.
--- Verify the imported data.

--1
create table test_identity(
	id int identity(1,1),
	username nvarchar(100)
);

insert into test_identity(username) values('Jhon'), ('Morsten'), ('Arthur'), ('Dutch'), ('Tom');
delete from test_identity; -- doesnt resets the identity

insert into test_identity(username) values('Jhon'), ('Morsten'), ('Arthur'), ('Dutch'), ('Tom');
truncate table test_identity; -- resets the identity


drop table test_identity; -- deletes whole table

select * from test_identity;


--2

create table data_types_demo(
	data1 tinyint,
	data2 smallint,
	data3 int,
	data4 bigint,
	data5 bit,
	data6 decimal(5,2),
	data7 numeric(10, 5),
	data8 money,
	data9 smallmoney,
	data10 float,
	data11 real,
	data12 date,
	data13 time,
	data14 datetime,
	data15 datetime2,
	data17 smalldatetime,
	data18 char(100),
	data19 varchar(100),
	data20 nchar(100),
	data21 nvarchar(100),

);


insert into data_types_demo(data1,data2,data3,data4,data5,data6,data7,data8,data9,data10,data11,data12,data13,data14,data15,data17,data18,data19,data20,data21)
values(255, 32767, 2147483647, 9223372036854775807, 1, 123.12, 12345.12, 92233720368477.58, 214748.3647, 100.21, 120.21, '2020-01-01', '23:59:59', '2020-01-01 23:59:59',
'2020-01-01 23:59:59', '2024-05-09 23:59:59', 'hello world', 'war', 'こんにちは' , 'こんに ちは東京');

select * from data_types_demo


--3

create table photo(
	id int,
	pic varbinary(MAX)
);

insert into photo
select 1, BulkColumn from openrowset( BULK 'D:\Projects\SQL\img.jpg', SINGLE_blob) as img;

select * from photo


--python code
----import pyodbc

----con_str = "DRIVER={SQL SERVER};SERVER=depthsix;DATABASE=lesson-2;Trusted_Connection=yes;"
----con = pyodbc.connect(con_str)
----cursor = con.cursor()

----cursor.execute(
----    """
----    SELECT * FROM products;
----    """
----)

----row = cursor.fetchone()
----img_id, name, image_data = row

----with open(f'{name}.png', 'wb') as f:
----    f.write(image_data)

--4

-- Create the table with a computed column
----CREATE TABLE student (
----    student_id INT PRIMARY KEY IDENTITY(1,1),
----    student_name VARCHAR(50) NOT NULL,
----    classes INT NOT NULL,
----    tuition_per_class DECIMAL(10,2) NOT NULL,
----    total_tuition AS (classes * tuition_per_class)   -- Computed Column
----);

------ Insert sample rows
----INSERT INTO student (student_name, classes, tuition_per_class)
----VALUES 
----('Alice', 5, 200.00),
----('Bob', 3, 150.00),
----('Charlie', 7, 180.00);

------ Retrieve all data
----SELECT * FROM student;

--5

create table worker(
	id int primary key,
	[name] nvarchar(100)
)

BULK INSERT worker
FROM 'D:\Projects\SQL\sample.csv'
WITH (
	firstrow=2,
	fieldterminator=',',
	rowterminator='\n',
	tablock
);

select * from worker

