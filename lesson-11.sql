
--1

SELECT 
    DB_NAME() AS DatabaseName,  
    schemas.name AS SchemaName,  
    tables.name AS TableName,    
    columns.name AS ColumnName,  
    columns.data_type AS DataType  
FROM 
    sys.databases AS databases  
JOIN 
    sys.tables AS tables ON tables.is_ms_shipped = 0  
JOIN 
    sys.schemas AS schemas ON tables.schema_id = schemas.schema_id  
JOIN 
    sys.columns AS columns ON tables.object_id = columns.object_id  
WHERE 
    databases.name NOT IN ('master', 'tempdb', 'model', 'msdb') 
ORDER BY 
    DatabaseName, SchemaName, TableName, ColumnName;

--2

CREATE PROCEDURE GetProceduresAndFunctions 
    @DatabaseName NVARCHAR(128) = NULL
AS
BEGIN
    DECLARE @SQL NVARCHAR(MAX);


    IF @DatabaseName IS NOT NULL
    BEGIN
        SET @SQL = N'
        USE [' + @DatabaseName + '];
        SELECT 
            OBJECT_SCHEMA_NAME(p.object_id) AS SchemaName,
            p.name AS ObjectName,
            p.type_desc AS ObjectType,
            PARAM.name AS ParameterName,
            t.name AS ParameterDataType,
            PARAM.max_length AS ParameterMaxLength
        FROM 
            sys.objects AS p
        LEFT JOIN 
            sys.parameters AS PARAM ON p.object_id = PARAM.object_id
        LEFT JOIN 
            sys.types AS t ON PARAM.user_type_id = t.user_type_id
        WHERE 
            p.type IN (''P'', ''FN'', ''IF'', ''TF'')  -- Procedures and Functions
        ORDER BY 
            SchemaName, ObjectName, ParameterName;';
    END
    ELSE
    BEGIN

        SET @SQL = N'
        DECLARE @DBName NVARCHAR(128);
        DECLARE db_cursor CURSOR FOR
        SELECT name FROM sys.databases WHERE state_desc = ''ONLINE'' AND name NOT IN (''master'', ''tempdb'', ''model'', ''msdb'');
        
        OPEN db_cursor;
        FETCH NEXT FROM db_cursor INTO @DBName;
        
        WHILE @@FETCH_STATUS = 0
        BEGIN
            PRINT ''Processing database: '' + @DBName;
            EXEC(''USE ['' + @DBName + ''];
                SELECT 
                    OBJECT_SCHEMA_NAME(p.object_id) AS SchemaName,
                    p.name AS ObjectName,
                    p.type_desc AS ObjectType,
                    PARAM.name AS ParameterName,
                    t.name AS ParameterDataType,
                    PARAM.max_length AS ParameterMaxLength
                FROM 
                    sys.objects AS p
                LEFT JOIN 
                    sys.parameters AS PARAM ON p.object_id = PARAM.object_id
                LEFT JOIN 
                    sys.types AS t ON PARAM.user_type_id = t.user_type_id
                WHERE 
                    p.type IN (''P'', ''FN'', ''IF'', ''TF'')
                ORDER BY 
                    SchemaName, ObjectName, ParameterName;'');
            FETCH NEXT FROM db_cursor INTO @DBName;
        END
        
        CLOSE db_cursor;
        DEALLOCATE db_cursor;';
    END

    EXEC sp_executesql @SQL;
END
