-- Task 1: 

DECLARE @sql AS NVARCHAR(MAX) = '';


SELECT @sql = @sql + '
USE [' + name + '];

SELECT 
    ''' + name + ''' AS DatabaseName,
    s.name AS SchemaName,
    t.name AS TableName,
    c.name AS ColumnName,
    ty.name AS ColumnDataType
FROM sys.tables t
INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
INNER JOIN sys.columns c ON t.object_id = c.object_id
INNER JOIN sys.types ty ON c.user_type_id = ty.user_type_id
WHERE t.is_ms_shipped = 0
AND s.name <> ''sys'' AND t.name NOT LIKE ''%''
ORDER BY SchemaName, TableName, ColumnName;
'
FROM sys.databases
WHERE state_desc = 'ONLINE' 
AND name NOT IN ('master', 'tempdb', 'model', 'msdb'); 

EXEC sp_executesql @sql;

-- Task 2

CREATE PROCEDURE GetProceduresAndFunctions 
    @DatabaseName NVARCHAR(128) = NULL
AS
BEGIN
    DECLARE @sql AS NVARCHAR(MAX) = '';

    IF @DatabaseName IS NOT NULL
    BEGIN

        SET @sql = 'USE ' + QUOTENAME(@DatabaseName) + ';
        SELECT 
            SCHEMA_NAME(p.schema_id) AS SchemaName,
            p.name AS ObjectName,
            p.type_desc AS ObjectType,
            param.name AS ParameterName,
            t.name AS ParameterDataType,
            param.max_length AS ParameterMaxLength
        FROM sys.procedures p
        LEFT JOIN sys.parameters param ON p.object_id = param.object_id
        LEFT JOIN sys.types t ON param.user_type_id = t.user_type_id
        WHERE p.is_ms_shipped = 0
        ORDER BY SchemaName, ObjectName, param.parameter_id;';
    END
    ELSE
    BEGIN
        SET @sql = '
        DECLARE @dbName NVARCHAR(128);
        DECLARE db_cursor CURSOR FOR
        SELECT name
        FROM sys.databases
        WHERE state_desc = ''ONLINE'' AND name NOT IN (''master'', ''tempdb'', ''model'', ''msdb'');
        
        OPEN db_cursor;
        FETCH NEXT FROM db_cursor INTO @dbName;
        
        WHILE @@FETCH_STATUS = 0
        BEGIN
            EXEC(''USE '' + QUOTENAME(@dbName) + ''; 
            SELECT 
                SCHEMA_NAME(p.schema_id) AS SchemaName,
                p.name AS ObjectName,
                p.type_desc AS ObjectType,
                param.name AS ParameterName,
                t.name AS ParameterDataType,
                param.max_length AS ParameterMaxLength
            FROM sys.procedures p
            LEFT JOIN sys.parameters param ON p.object_id = param.object_id
            LEFT JOIN sys.types t ON param.user_type_id = t.user_type_id
            WHERE p.is_ms_shipped = 0
            ORDER BY SchemaName, ObjectName, param.parameter_id;'');
            
            FETCH NEXT FROM db_cursor INTO @dbName;
        END;
        
        CLOSE db_cursor;
        DEALLOCATE db_cursor;';
    END


    EXEC sp_executesql @sql;
END;          