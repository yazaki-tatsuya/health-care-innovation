CREATE OR ALTER VIEW vw_sleep_log_with_hr AS
SELECT
    s.client_id,
    s.log_date,
    s.sleep_log_id,
    s.is_main_sleep,
    s.start_time,
    s.end_time,
    s.total_time_in_bed,
    s.total_minutes_asleep,
    s.sleep_efficiency,
    s.minutes_deep_sleep,
    s.minutes_light_sleep,
    s.minutes_rem_sleep,
    s.minutes_awake,
    s.total_nap_minutes,
    s.nap_count,
    -- 睡眠中の平均心拍数
    AVG(h.value) AS avg_hr_sleep
FROM
    sleep_log s
LEFT JOIN activities_heart h
    ON s.client_id = h.client_id
    AND h.date = s.log_date
    AND CAST(h.time AS TIME) BETWEEN CAST(s.start_time AS TIME) AND CAST(s.end_time AS TIME)
WHERE
    s.is_main_sleep = 1
GROUP BY
    s.client_id,
    s.log_date,
    s.sleep_log_id,
    s.is_main_sleep,
    s.start_time,
    s.end_time,
    s.total_time_in_bed,
    s.total_minutes_asleep,
    s.sleep_efficiency,
    s.minutes_deep_sleep,
    s.minutes_light_sleep,
    s.minutes_rem_sleep,
    s.minutes_awake,
    s.total_nap_minutes,
    s.nap_count;