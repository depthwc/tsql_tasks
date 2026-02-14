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
