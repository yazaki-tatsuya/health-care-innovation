CREATE OR ALTER VIEW vw_activities_heart_hourly AS
SELECT
    client_id,
    date,
    DATEPART(HOUR, time) AS hour,
    DATEADD(HOUR, DATEPART(HOUR, time), CAST(date AS DATETIME)) AS datetime_key,
    COUNT(*) AS measurement_count,
    -- 丸めた値（例：四捨五入）
    ROUND(AVG(value), 0) AS avg_hr,
    MIN(value) AS min_hr,
    MAX(value) AS max_hr,
    STDEV(value) AS stddev_hr
FROM
    activities_heart
GROUP BY
    client_id,
    date,
    DATEPART(HOUR, time);