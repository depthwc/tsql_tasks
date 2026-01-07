
--1

use lesson;
drop table if exists student;
create table student(
	id int,
	name VARCHAR(50),
	age int
);

ALTER TABLE student
ALTER COLUMN id INT NOT NULL;

--2

drop table if exists product;
create table product(
	product_id int unique,
	product_name varchar(50) not null,
	price varchar(50)
);

alter table product
drop constraint UQ__product__47027DF4DD5A70C0;

alter table product
add constraint UQ_idk unique(product_id);
alter table product
ADD CONSTRAINT UQ_product_namse UNIQUE(product_name);


--3



create table orders(
	order_id int ,
	customer_name nvarchar(50),
	order_data nvarchar(50)
	constraint pk_student PRIMARY KEY(order_id)
);

alter table orders
drop constraint pk_student;

alter table orders
add constraint pk_student PRIMARY KEY(order_id)

--4 

create table category(
	category_id int,
	category_name nvarchar(50),
	constraint pk_category PRIMARY KEY(category_id)
);

create table item(
	item_id int,
	item_name nvarchar(50),
	category_id int,
	constraint pk_item PRIMARY KEY(item_id),
	constraint fk_item_category FOREIGN KEY (category_id) REFERENCES category(category_id)
);

alter table item
drop constraint fk_item_category;

alter table item
add constraint fk_item_category FOREIGN KEY (category_id) REFERENCES category(category_id);


--5


create table account(
	account_id int,
	balance DECIMAL(10,2),
	account_type varchar(50),
	constraint chk_account check(balance>-1)
);

alter table account
drop constraint chk_account;

alter table account
add constraint chk_account check(balance>-1);



--6

CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100) CONSTRAINT df_customer_city DEFAULT 'Unknown'
);

ALTER TABLE customer
DROP CONSTRAINT df_customer_city;

ALTER TABLE customer
ADD CONSTRAINT df_customer_city DEFAULT 'Unknown' FOR city;



--7

CREATE TABLE invoice (
    invoice_id INT IDENTITY(1,1) PRIMARY KEY,
    amount DECIMAL(10,2)
);
INSERT INTO invoice (amount) VALUES (150.50);
INSERT INTO invoice (amount) VALUES (200.00);
INSERT INTO invoice (amount) VALUES (99.99);
INSERT INTO invoice (amount) VALUES (300.75);
INSERT INTO invoice (amount) VALUES (450.25);

SET IDENTITY_INSERT invoice ON;

INSERT INTO invoice (invoice_id, amount)
VALUES (100, 999.99);

SET IDENTITY_INSERT invoice OFF;

SELECT * FROM invoice;

--8

IF OBJECT_ID('books', 'U') IS NOT NULL
    DROP TABLE books;

CREATE TABLE books (
    book_id INT IDENTITY(1,1) PRIMARY KEY,
    title VARCHAR(200) NOT NULL 
        CONSTRAINT chk_title CHECK (LEN(title) > 0),
    price DECIMAL(10,2) 
        CONSTRAINT chk_price CHECK (price > 0),
    genre VARCHAR(100) 
        CONSTRAINT df_genre DEFAULT 'Unknown'
);

INSERT INTO books (title, price, genre) VALUES ('The Alchemist', 15.50, 'Fiction');
INSERT INTO books (title, price) VALUES ('Clean Code', 30.00);   
INSERT INTO books (title, price, genre) VALUES ('Deep Work', 20.00, 'Productivity');
INSERT INTO books (title, price) VALUES ('Atomic Habits', 25.99); 
SELECT * FROM books;

--9



CREATE TABLE Book (
    book_id INT IDENTITY(1,1) PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100) NOT NULL,
    published_year INT
);


CREATE TABLE Member (
    member_id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(20)
);

CREATE TABLE Loan (
    loan_id INT IDENTITY(1,1) PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    loan_date DATE NOT NULL,
    return_date DATE NULL,
    CONSTRAINT fk_loan_book FOREIGN KEY (book_id) REFERENCES Book(book_id),
    CONSTRAINT fk_loan_member FOREIGN KEY (member_id) REFERENCES Member(member_id)
);





INSERT INTO Book (title, author, published_year) VALUES
('The Hobbit', 'J.R.R. Tolkien', 1937),
('1984', 'George Orwell', 1949),
('Clean Code', 'Robert C. Martin', 2008);


INSERT INTO Member (name, email, phone_number) VALUES
('Alice Johnson', 'alice@example.com', '123-456-7890'),
('Bob Smith', 'bob@example.com', '987-654-3210');


INSERT INTO Loan (book_id, member_id, loan_date, return_date) VALUES
(1, 1, '2025-08-01', '2025-08-15'),
(2, 1, '2025-08-10', NULL),      
(3, 2, '2025-08-05', '2025-08-20');
