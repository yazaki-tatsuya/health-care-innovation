/*───────────────────────────────────────────────────────────*/
/* sleep_log テーブルの PK_sleep_log 制約削除＆テーブル再作成 */
/*   ─ 他テーブルには一切影響しない版                      */
/*───────────────────────────────────────────────────────────*/

-- ① sleep_log テーブルが存在するかチェック
IF OBJECT_ID(N'dbo.sleep_log', 'U') IS NOT NULL
BEGIN
    PRINT N'sleep_log テーブルが存在します。制約とテーブルを削除します…';

    -- ② sleep_log テーブルの PK_sleep_log 制約が存在するかチェック
    IF EXISTS (
        SELECT 1
        FROM sys.key_constraints kc
        WHERE kc.name = N'PK_sleep_log'
          AND OBJECT_NAME(kc.parent_object_id) = N'sleep_log'
          AND OBJECT_SCHEMA_NAME(kc.parent_object_id) = N'dbo'  -- ←ここを修正
    )
    BEGIN
        PRINT N'→ PK_sleep_log 制約を削除します';
        ALTER TABLE dbo.sleep_log
        DROP CONSTRAINT PK_sleep_log;
    END
    ELSE
    BEGIN
        PRINT N'→ PK_sleep_log 制約は見つかりませんでした';
    END

    -- ③ sleep_log テーブル本体を削除
    PRINT N'→ sleep_log テーブルを削除します';
    DROP TABLE dbo.sleep_log;
END
ELSE
BEGIN
    PRINT N'sleep_log テーブルは存在しませんでした';
END
GO

-- ④ sleep_log テーブルを再作成
PRINT N'sleep_log テーブルを再作成します';
CREATE TABLE dbo.sleep_log
(
    -- キー／メタ
    client_id        NVARCHAR(50)  NOT NULL,
    log_date         DATE          NOT NULL,
    sleep_log_id     BIGINT        NULL,
    is_main_sleep    BIT           NULL,
    type             NVARCHAR(20)  NULL,

    -- タイムライン
    start_time             DATETIME NULL,
    end_time               DATETIME NULL,
    total_time_in_bed      INT      NULL,
    minutes_to_fall_asleep INT      NULL,
    minutes_after_wakeup   INT      NULL,
    nap_count         INT  NULL,  -- 日次ナップ回数 (is_main_sleep=0 の件数)
    total_nap_minutes INT  NULL,  -- 日次ナップ合計分

    -- 集計スコア
    total_minutes_asleep INT NULL,
    sleep_efficiency     INT NULL,
    sleep_score          INT NULL,  -- 2025年6月現在、睡眠のAPIでは取得不可
    score_duration       INT NULL,  -- 2025年6月現在、睡眠のAPIでは取得不可
    score_composition    INT NULL,  -- 2025年6月現在、睡眠のAPIでは取得不可
    score_revitalization INT NULL,  -- 2025年6月現在、睡眠のAPIでは取得不可

    -- 目覚め指標
    awakenings_count     INT NULL,
    awakenings_duration  INT NULL,

    -- ステージ詳細
    minutes_deep_sleep   INT NULL,
    minutes_light_sleep  INT NULL,
    minutes_rem_sleep    INT NULL,
    minutes_awake        INT NULL,

    -- 生体指標
    avg_hr_sleep        INT         NULL, -- 睡眠のAPIでは取得不可だが、ActivityHeartsRate テーブルから取得可能のため、vw_SleepLogWithHeartRate ビューを参照すること。
    breathing_rate      DECIMAL(4,1) NULL, -- 睡眠のAPIでは取得不可
    skin_temp_deviation DECIMAL(4,1) NULL, -- 睡眠のAPIでは取得不可

    -- ローデータ
    raw_json NVARCHAR(MAX) NULL,

    CONSTRAINT PK_sleep_log PRIMARY KEY CLUSTERED (client_id, log_date)
);
PRINT N'sleep_log テーブルの再作成が完了しました';
GO
