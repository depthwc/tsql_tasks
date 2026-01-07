-- 1

CREATE TABLE #ColumnInfo (
    DatabaseName SYSNAME,
    SchemaName SYSNAME,
    TableName SYSNAME,
    ColumnName SYSNAME,
    DataType NVARCHAR(128)
);

DECLARE @sql NVARCHAR(MAX);

EXEC sp_MSforeachdb '
IF ''?'' NOT IN (''master'', ''tempdb'', ''model'', ''msdb'')
BEGIN
    INSERT INTO #ColumnInfo (DatabaseName, SchemaName, TableName, ColumnName, DataType)
    SELECT 
        DB_NAME() AS DatabaseName,
        s.name AS SchemaName,
        t.name AS TableName,
        c.name AS ColumnName,
        ty.name + 
            CASE 
                WHEN ty.name IN (''char'', ''varchar'', ''nchar'', ''nvarchar'') 
                    THEN ''('' + CASE WHEN c.max_length = -1 THEN ''MAX'' ELSE CAST(
                        CASE WHEN ty.name LIKE ''n%'' THEN c.max_length/2 ELSE c.max_length END AS VARCHAR(10)) END + '')''
                WHEN ty.name IN (''decimal'', ''numeric'') 
                    THEN ''('' + CAST(c.precision AS VARCHAR(10)) + '','' + CAST(c.scale AS VARCHAR(10)) + '')''
                ELSE ''''
            END AS DataType
    FROM ?.sys.columns c
    INNER JOIN ?.sys.tables t ON c.object_id = t.object_id
    INNER JOIN ?.sys.schemas s ON t.schema_id = s.schema_id
    INNER JOIN ?.sys.types ty ON c.user_type_id = ty.user_type_id
    WHERE t.is_ms_shipped = 0
END
';


SELECT * FROM #ColumnInfo
ORDER BY DatabaseName, SchemaName, TableName, ColumnName;

DROP TABLE #ColumnInfo;


--2

CREATE PROCEDURE dbo.GetRoutineParameters
    @DatabaseName SYSNAME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    CREATE TABLE #RoutineParams (
        DatabaseName SYSNAME,
        SchemaName SYSNAME,
        RoutineName SYSNAME,
        RoutineType NVARCHAR(50),
        ParameterName SYSNAME,
        ParameterDataType NVARCHAR(128),
        MaxLength INT,
        Precision INT,
        Scale INT,
        ParameterMode NVARCHAR(10)
    );

    DECLARE @sql NVARCHAR(MAX);

    IF @DatabaseName IS NOT NULL
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM sys.databases WHERE name = @DatabaseName)
        BEGIN
            RAISERROR('Database %s does not exist.', 16, 1, @DatabaseName);
            RETURN;
        END

        SET @sql = N'
        INSERT INTO #RoutineParams (DatabaseName, SchemaName, RoutineName, RoutineType, ParameterName, ParameterDataType, MaxLength, Precision, Scale, ParameterMode)
        SELECT
            DB_NAME() AS DatabaseName,
            s.name AS SchemaName,
            o.name AS RoutineName,
            CASE 
                WHEN o.type IN (''P'') THEN ''Procedure''
                WHEN o.type IN (''FN'', ''IF'', ''TF'') THEN ''Function''
                ELSE ''Other''
            END AS RoutineType,
            p.name AS ParameterName,
            ty.name + 
                CASE 
                    WHEN ty.name IN (''char'', ''varchar'', ''nchar'', ''nvarchar'') 
                        THEN ''('' + CASE WHEN p.max_length = -1 THEN ''MAX'' ELSE CAST(
                            CASE WHEN ty.name LIKE ''n%'' THEN p.max_length/2 ELSE p.max_length END AS VARCHAR(10)) END + '')''
                    WHEN ty.name IN (''decimal'', ''numeric'') 
                        THEN ''('' + CAST(p.precision AS VARCHAR(10)) + '','' + CAST(p.scale AS VARCHAR(10)) + '')''
                    ELSE ''''
                END AS ParameterDataType,
            p.max_length AS MaxLength,
            p.precision AS Precision,
            p.scale AS Scale,
            CASE WHEN p.is_output = 1 THEN ''OUT'' ELSE ''IN'' END AS ParameterMode
        FROM ' + QUOTENAME(@DatabaseName) + '.sys.objects o
        INNER JOIN ' + QUOTENAME(@DatabaseName) + '.sys.schemas s ON o.schema_id = s.schema_id
        LEFT JOIN ' + QUOTENAME(@DatabaseName) + '.sys.parameters p ON o.object_id = p.object_id
        LEFT JOIN ' + QUOTENAME(@DatabaseName) + '.sys.types ty ON p.user_type_id = ty.user_type_id
        WHERE o.type IN (''P'', ''FN'', ''IF'', ''TF'')
        ORDER BY SchemaName, RoutineName, ParameterName;
        ';

        EXEC sp_executesql @sql;
    END
    ELSE
    BEGIN

        DECLARE @dbName SYSNAME;

        DECLARE db_cursor CURSOR FOR
        SELECT name FROM sys.databases
        WHERE name NOT IN ('master', 'tempdb', 'model', 'msdb')
          AND state = 0
          AND is_read_only = 0;

        OPEN db_cursor;
        FETCH NEXT FROM db_cursor INTO @dbName;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @sql = N'
            INSERT INTO #RoutineParams (DatabaseName, SchemaName, RoutineName, RoutineType, ParameterName, ParameterDataType, MaxLength, Precision, Scale, ParameterMode)
            SELECT
                ''' + QUOTENAME(@dbName,'''') + ''' AS DatabaseName,
                s.name AS SchemaName,
                o.name AS RoutineName,
                CASE 
                    WHEN o.type IN (''P'') THEN ''Procedure''
                    WHEN o.type IN (''FN'', ''IF'', ''TF'') THEN ''Function''
                    ELSE ''Other''
                END AS RoutineType,
                p.name AS ParameterName,
                ty.name + 
                    CASE 
                        WHEN ty.name IN (''char'', ''varchar'', ''nchar'', ''nvarchar'') 
                            THEN ''('' + CASE WHEN p.max_length = -1 THEN ''MAX'' ELSE CAST(
                                CASE WHEN ty.name LIKE ''n%'' THEN p.max_length/2 ELSE p.max_length END AS VARCHAR(10)) END + '')''
                        WHEN ty.name IN (''decimal'', ''numeric'') 
                            THEN ''('' + CAST(p.precision AS VARCHAR(10)) + '','' + CAST(p.scale AS VARCHAR(10)) + '')''
                        ELSE ''''
                    END AS ParameterDataType,
                p.max_length AS MaxLength,
                p.precision AS Precision,
                p.scale AS Scale,
                CASE WHEN p.is_output = 1 THEN ''OUT'' ELSE ''IN'' END AS ParameterMode
            FROM ' + QUOTENAME(@dbName) + '.sys.objects o
            INNER JOIN ' + QUOTENAME(@dbName) + '.sys.schemas s ON o.schema_id = s.schema_id
            LEFT JOIN ' + QUOTENAME(@dbName) + '.sys.parameters p ON o.object_id = p.object_id
            LEFT JOIN ' + QUOTENAME(@dbName) + '.sys.types ty ON p.user_type_id = ty.user_type_id
            WHERE o.type IN (''P'', ''FN'', ''IF'', ''TF'')
            ORDER BY SchemaName, RoutineName, ParameterName;
            ';

            BEGIN TRY
                EXEC sp_executesql @sql;
            END TRY
            BEGIN CATCH
       
                PRINT 'Warning: Could not access database ' + @dbName;
            END CATCH;

            FETCH NEXT FROM db_cursor INTO @dbName;
        END

        CLOSE db_cursor;
        DEALLOCATE db_cursor;
    END


    SELECT * FROM #RoutineParams
    ORDER BY DatabaseName, SchemaName, RoutineName, ParameterName;

    DROP TABLE #RoutineParams;
END
GO

