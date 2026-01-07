use year2025

DECLARE @Year INT = 2025;  
DECLARE @Month INT = 9;    
DECLARE @StartDate DATE = DATEFROMPARTS(@Year, @Month, 1);
DECLARE @EndDate DATE = EOMONTH(@StartDate);

WITH Calendar AS (
    SELECT 
        DATEADD(DAY, v.number, @StartDate) AS CalendarDate
    FROM master.dbo.spt_values v
    WHERE v.type = 'P'
        AND DATEADD(DAY, v.number, @StartDate) <= @EndDate
)
, WeekDays AS (
    SELECT 
        CalendarDate,
        DATENAME(WEEKDAY, CalendarDate) AS WeekdayName,
        DATEPART(WEEKDAY, CalendarDate) AS WeekdayNumber,
        ROW_NUMBER() OVER (ORDER BY CalendarDate) AS DayNumber
    FROM Calendar
)
, WeekStart AS (
    SELECT 
        WeekDays.CalendarDate,
        WeekDays.DayNumber,
        WeekDays.WeekdayName,
        WeekDays.WeekdayNumber,
 
        (DATEPART(WEEKDAY, WeekDays.CalendarDate) + 6) % 7 AS AdjustedWeekdayNumber
    FROM WeekDays
)
SELECT 
    MAX(CASE WHEN AdjustedWeekdayNumber = 0 THEN CalendarDate ELSE NULL END) AS Sunday,
    MAX(CASE WHEN AdjustedWeekdayNumber = 1 THEN CalendarDate ELSE NULL END) AS Monday,
    MAX(CASE WHEN AdjustedWeekdayNumber = 2 THEN CalendarDate ELSE NULL END) AS Tuesday,
    MAX(CASE WHEN AdjustedWeekdayNumber = 3 THEN CalendarDate ELSE NULL END) AS Wednesday,
    MAX(CASE WHEN AdjustedWeekdayNumber = 4 THEN CalendarDate ELSE NULL END) AS Thursday,
    MAX(CASE WHEN AdjustedWeekdayNumber = 5 THEN CalendarDate ELSE NULL END) AS Friday,
    MAX(CASE WHEN AdjustedWeekdayNumber = 6 THEN CalendarDate ELSE NULL END) AS Saturday
FROM WeekStart
GROUP BY (DayNumber - 1) / 7
ORDER BY (DayNumber - 1) / 7;
