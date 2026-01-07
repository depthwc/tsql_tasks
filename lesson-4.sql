
-- Task 1
CREATE TABLE [dbo].[TestMultipleZero]
(
    [A] [int] NULL,
    [B] [int] NULL,
    [C] [int] NULL,
    [D] [int] NULL
);
GO

INSERT INTO [dbo].[TestMultipleZero](A,B,C,D)
VALUES 
    (0,0,0,1),
    (0,0,1,0),
    (0,1,0,0),
    (1,0,0,0),
    (0,0,0,0),
    (1,1,1,0);

SELECT *
FROM TestMultipleZero
WHERE COALESCE(A,0) + COALESCE(B,0) + COALESCE(C,0) + COALESCE(D,0) <> 0;




-- Task 2

CREATE TABLE TestMax
(
    Year1 INT,
    Max1 INT,
    Max2 INT,
    Max3 INT
);
GO

INSERT INTO TestMax 
VALUES
    (2001,10,101,87),
    (2002,103,19,88),
    (2003,21,23,89),
    (2004,27,28,91);

SELECT Year1,
       (SELECT MAX(v) 
        FROM (VALUES (Max1), (Max2), (Max3)) AS value_list(v)) AS MaxValue
FROM TestMax;




-- Task 3

CREATE TABLE EmpBirth
(
    EmpId INT IDENTITY(1,1),
    EmpName VARCHAR(50),
    BirthDate DATETIME
);

INSERT INTO EmpBirth(EmpName,BirthDate)
SELECT 'Pawan' , '1983-12-04'
UNION ALL SELECT 'Zuzu' , '1986-11-28'
UNION ALL SELECT 'Parveen', '1977-05-07'
UNION ALL SELECT 'Mahesh', '1983-01-13'
UNION ALL SELECT 'Ramesh', '1983-05-09';

SELECT EmpName, BirthDate
FROM EmpBirth
WHERE MONTH(BirthDate) = 5
  AND DAY(BirthDate) BETWEEN 7 AND 15;




-- Task 4

CREATE TABLE letters (letter CHAR(1));

INSERT INTO letters VALUES ('a'),('a'),('a'),('b'),('c'),('d'),('e'),('f');

-- a)
SELECT letter
FROM letters
ORDER BY CASE WHEN letter = 'b' THEN 0 ELSE 1 END, letter;

-- b) 
SELECT letter
FROM letters
ORDER BY CASE WHEN letter = 'b' THEN 1 ELSE 0 END, letter;

-- c) 
WITH ordered AS (
    SELECT letter,
           ROW_NUMBER() OVER (ORDER BY letter) AS rn
    FROM letters
    WHERE letter <> 'b'
)
SELECT letter FROM ordered WHERE rn < 2
UNION ALL
SELECT 'b'
UNION ALL
SELECT letter FROM ordered WHERE rn >= 2;
