
DECLARE @HTML NVARCHAR(MAX);


SET @HTML = 
N'<html>
<head>
<style>
    table { border-collapse: collapse; width: 100%; font-family: Arial, sans-serif; }
    th, td { border: 1px solid #dddddd; padding: 8px; text-align: left; }
    th { background-color: #f2f2f2; }
</style>
</head>
<body>
<h3>SQL Server Index Metadata Report</h3>
<table>
<tr>
    <th>Table Name</th>
    <th>Index Name</th>
    <th>Index Type</th>
    <th>Column Type</th>
</tr>' +
(
    SELECT
        td = 
            (SELECT 
                t.name AS [td],
                i.name AS [td],
                i.type_desc AS [td],
                ic.is_included_column AS [td]
             FROM 
                sys.indexes i
                INNER JOIN sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
                INNER JOIN sys.tables t ON i.object_id = t.object_id
             WHERE 
                i.is_hypothetical = 0
             FOR XML RAW('tr'), ELEMENTS, TYPE
            ).value('.', 'NVARCHAR(MAX)')
) +
N'</table>
</body>
</html>';


EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'YourDatabaseMailProfile', 
    @recipients = 'recipient@example.com',    
    @subject = 'SQL Server Index Metadata Report',
    @body = @HTML,
    @body_format = 'HTML';
