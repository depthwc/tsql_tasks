WITH AllDays AS (
  
    SELECT 0 AS Num FROM generate_series(1, 7)
    
    UNION ALL
    
  
    SELECT Num FROM Shipments
),
Ordered AS (
    SELECT 
        Num,
        ROW_NUMBER() OVER (ORDER BY Num) AS rn
    FROM AllDays
),
Median AS (
    SELECT 
        AVG(Num * 1.0) AS Median
    FROM Ordered
    WHERE rn IN (20, 21) 
)
SELECT Median FROM Median;
