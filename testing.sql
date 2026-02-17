drop table if exists  goal_details
CREATE TABLE goal_details (
    [goal_id] int,
    [match_no] int,
    [player_id] int,
    [team_id] int,
    [goal_time] int,
    [goal_type] nvarchar(50) COLLATE Latin1_General_100_CI_AS_SC_UTF8,
    [play_stage] nvarchar(50) COLLATE Latin1_General_100_CI_AS_SC_UTF8,
    [goal_schedule] nvarchar(50) COLLATE Latin1_General_100_CI_AS_SC_UTF8,
    [goal_half] int
)

drop table if exists task1_errorlogs

CREATE TABLE     (
    [Flat File Source Error Output Column] nvarchar(max) COLLATE Latin1_General_100_CI_AS_SC_UTF8,
    [ErrorCode] int,
    [ErrorColumn] int,
    Source nvarchar(50)
)


select * from task1_errorlogs
select * from [dbo].[goal_details]
select * from [dbo].[player_details]

truncate table [dbo].task1_errorlogs
truncate table [dbo].[goal_details]
truncate table [dbo].[player_details]

drop table if exists task1_errorlogs

create table task1_errorlogs(erroroutput varchar(255) COLLATE Latin1_General_100_CI_AS_SC_UTF8 , ErrorCode int, ErrorColumn int, Source nvarchar(50) )


---task 2

select * from [dbo].[task3_result]

truncate table [dbo].[task3_result]


select * from [dbo].[checkingtask3]

select * from [dbo].[task3_cache]

truncate table [dbo].[checkingtask3]
truncate table [dbo].[task3_result]
truncate table [dbo].[task3_cache]
truncate table [dbo].[task3_cache0]
truncate table [dbo].[OLE DB Destinationeeee]

select * from [dbo].[task3_cache]
select * from [dbo].[task3_cache0]

select * from [dbo].[OLE DB Destinationeeee]

drop table [dbo].[task3_result]

select * from [dbo].[task4main]

truncate table [dbo].[task4main]


select * from [dbo].[task2_errorlog]




(Org_CentreName != Ref_CentreName) ||
(Org_PostCode != Ref_PostCode) ||
(Org_SquareMetres != Ref_SquareMetres) ||
(Org_NumberUnits != Ref_NumberUnits)\


truncate table [dbo].[exam4_org]
truncate table [dbo].[exam4_ref]
truncate table [dbo].[exam4_result]

select * from [dbo].[exam4_result]
select * from [dbo].[exam4_ref]

ALTER TABLE [dbo].[exam4_org]
ADD ID INT IDENTITY(1,1);

ALTER TABLE [dbo].[exam4_ref]
ADD ID INT IDENTITY(1,1);







--------------------------------------------------------


create database scd_testing
go
use scd_testing
go


CREATE TABLE org (
    [CentreId] float,
    [CentreName] nvarchar(255),
    [PostCode] nvarchar(255),
    [SquareMetres] float,
    [NumberUnits] float,
    [Details] nvarchar(255),
)   


CREATE TABLE ref (
    [CentreId] float,
    [CentreName] nvarchar(255),
    [PostCode] nvarchar(255),
    [SquareMetres] float,
    [NumberUnits] float,
    [Details] nvarchar(255),
)   

drop table if exists databasewb
CREATE TABLE databasewb (
    [CentreId] float,
    [CentreName] nvarchar(255),
    [PostCode] nvarchar(255),
    [SquareMetres] float,
    [NumberUnits] float,
    [Details] nvarchar(255),
    StartDate Datetime,
    EndDate Datetime
)   

select * from databasewb

drop table org
drop table ref

CREATE TABLE bronze_orders (
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    amount VARCHAR(50),
    order_date VARCHAR(50),
    status VARCHAR(50)
);



INSERT INTO source_orders VALUES
('1016','C016','1200.50','2026-02-14 18:00:00','PAID'),
('1017','C017','NULL','2026-02-14','PAID'),
('1018','C018','1300,75','14-02-2026','PAID'),
('1019','','1400','2026-02-14','PAID'),
('1020','C020','-200','INVALID','FAILED');


select * from bronze_orders

CREATE TABLE silver_orders (
    order_id INT,
    customer_id VARCHAR(50),
    amount DECIMAL(18,2),
    order_date DATETIME,
    status VARCHAR(50)
);


select * from silver_orders

truncate table silver_orders





drop table gold_customer_summary
CREATE TABLE gold_customer_summary (
    customer_id VARCHAR(50) PRIMARY KEY,
    total_spent DECIMAL(18,2),
    last_order_date DATETIME
);

drop table gold_status_summary2
CREATE TABLE gold_status_summary2 (
    status VARCHAR(50),
    total_spent DECIMAL(18,2),
);
