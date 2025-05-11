CREATE VIEW dbo.vw_sleep_log_columns AS
SELECT 
    c.column_id,
    c.name          AS column_name,
    t.name          AS data_type,
    c.max_length,
    p.value         AS description
FROM sys.columns AS c
JOIN sys.types   AS t ON c.user_type_id = t.user_type_id
LEFT JOIN sys.extended_properties AS p
       ON p.major_id = c.object_id
      AND p.minor_id = c.column_id
      AND p.name     = N'MS_Description'
WHERE c.object_id = OBJECT_ID(N'dbo.sleep_log')
ORDER BY c.column_id;
