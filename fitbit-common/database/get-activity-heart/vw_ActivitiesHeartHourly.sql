CREATE OR ALTER VIEW vw_activities_heart_hourly AS
SELECT
    client_id,
    date,
    DATEPART(HOUR, time) AS hour,
    -- 並び順用に datetime_key を直接定義
    DATEADD(HOUR, DATEPART(HOUR, time), CAST(date AS DATETIME)) AS datetime_key,
    COUNT(*) AS measurement_count,
    AVG(value) AS avg_hr,
    MIN(value) AS min_hr,
    MAX(value) AS max_hr,
    STDEV(value) AS stddev_hr
FROM
    activities_heart
GROUP BY
    client_id,
    date,
    DATEPART(HOUR, time);