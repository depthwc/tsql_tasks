DROP TABLE IF EXISTS #PhoneDirectory;
CREATE TABLE #PhoneDirectory
(
CustomerID INTEGER,
[Type] VARCHAR(100),
PhoneNumber VARCHAR(12) NOT NULL,
PRIMARY KEY (CustomerID, [Type])
);
INSERT INTO #PhoneDirectory (CustomerID, [Type], PhoneNumber) VALUES
(1001,'Cellular','555-897-5421'),
(1001,'Work','555-897-6542'),
(1001,'Home','555-698-9874'),
(2002,'Cellular','555-963-6544'),
(2002,'Work','555-812-9856'),
(3003,'Cellular','555-987-6541');

select * from #PhoneDirectory


select * from((select CustomerID , PhoneNumber from #PhoneDirectory where [type]= 'Cellular')as Cellular, 
(select CustomerID , PhoneNumber from #PhoneDirectory where [type]= 'Work') as Work,
(select CustomerID , PhoneNumber from #PhoneDirectory where [type]= 'Home') as Home) as main

--1
select cus1 as CustomerID,Cellular,Work,Home from(
select * from
(select CustomerID as cus1, PhoneNumber as Cellular from #PhoneDirectory where [type]='Cellular') as main1
left join
(select CustomerID as cus2, PhoneNumber as Work from #PhoneDirectory where [type]='Work') as main2
on main1.cus1=main2.cus2 left join
(select CustomerID as cus3, PhoneNumber as Home from #PhoneDirectory where [type]='Home') as main3
on main2.cus2=main3.cus3) as filter1


--2

DROP TABLE IF EXISTS #WorkflowSteps;
CREATE TABLE #WorkflowSteps
(
Workflow VARCHAR(100),
StepNumber INTEGER,
CompletionDate DATE NULL,
PRIMARY KEY (Workflow, StepNumber)
);
INSERT INTO #WorkflowSteps (Workflow, StepNumber, CompletionDate)
VALUES
('Alpha',1,'7/2/2018'),('Alpha',2,'7/2/2018'),('Alpha',3,'7/1/2018'),
('Bravo',1,'6/25/2018'),('Bravo',2,NULL),('Bravo',3,'6/27/2018'),
('Charlie',1,NULL),('Charlie',2,'7/1/2018');

--2
select * from #WorkflowSteps where CompletionDate is NULL

SELECT Workflow
FROM #WorkflowSteps
GROUP BY Workflow
HAVING 
    COUNT(*) > 0
    AND COUNT(CompletionDate) < COUNT(*);
--3

DROP TABLE IF EXISTS #Groupings;
CREATE TABLE #Groupings
(
StepNumber INTEGER PRIMARY KEY,
TestCase VARCHAR(100) NOT NULL,
[Status] VARCHAR(100) NOT NULL
);
INSERT INTO #Groupings (StepNumber, TestCase, [Status])
VALUES
(1,'Test Case 1','Passed'),
(2,'Test Case 2','Passed'),
(3,'Test Case 3','Passed'),
(4,'Test Case 4','Passed'),
(5,'Test Case 5','Failed'),
(6,'Test Case 6','Failed'),
(7,'Test Case 7','Failed'),
(8,'Test Case 8','Failed'),
(9,'Test Case 9','Failed'),
(10,'Test Case 10','Passed'),
(11,'Test Case 11','Passed'),
(12,'Test Case 12','Passed');

select * from
(select min(StepNumber) as min_step_num, max(StepNumber) as max_step_num, status ,count(sps2) as cnt from

(select *, sum(sps1) over(order by stepnumber) as sps2 from
(select *,
case when [Status]!=lag_S or lag_S is NULL then 1 else 0 end as sps1
from
(select * , lag(Status) over(order by stepnumber) as lag_S from #Groupings) as main) as main2) as main3
group by sps2 ,Status) as main4 order by min_step_num 