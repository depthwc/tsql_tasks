SELECT 
    s.id AS school_id,
    s.name AS school_name,
    s.location,
    ROUND(AVG(g.grade), 2) AS average_grade,
    COUNT(DISTINCT st.id) AS total_students
FROM 
    schools s
JOIN 
    students st ON s.id = st.school_id
JOIN 
    grades g ON st.id = g.student_id
GROUP BY 
    s.id, s.name, s.location
ORDER BY 
    average_grade DESC
LIMIT 10;


SELECT 
    grade_group,
    s.name AS school_name,
    COUNT(DISTINCT st.id) AS total_students,
    ROUND(AVG(g.grade), 2) AS average_grade
FROM 
    schools s
JOIN 
    students st ON s.id = st.school_id
JOIN 
    grades g ON st.id = g.student_id

CROSS APPLY (
    SELECT 
        CASE 
            WHEN AVG(g.grade) >= 90 THEN 'A'
            WHEN AVG(g.grade) >= 80 THEN 'B'
            WHEN AVG(g.grade) >= 70 THEN 'C'
            WHEN AVG(g.grade) >= 60 THEN 'D'
            ELSE 'F'
        END AS grade_group
) grp
GROUP BY 
    grade_group, s.name
ORDER BY 
    grade_group, average_grade DESC;
