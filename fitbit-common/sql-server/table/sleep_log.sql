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
    /* ------- 基本キー ------- */
    client_id NVARCHAR(50) NOT NULL,
    log_date  DATE         NOT NULL,

    /* ------- 時系列情報 ------- */
    start_time DATETIME NULL,   -- ベッドに入った時刻
    end_time   DATETIME NULL,   -- ベッドを出た時刻

    /* ------- ベッドにいた時間 / 前後プロセス ------- */
    total_time_in_bed      INT NULL,  -- ベッド滞在総時間
    minutes_to_fall_asleep INT NULL,  -- ベッドに入ってから眠るまで
    minutes_after_wakeup   INT NULL,  -- 目覚めてからベッドを出るまで

    /* ------- 睡眠時間と効率 ------- */
    total_minutes_asleep INT NULL,    -- 実際に眠っていた総時間
    sleep_efficiency     INT NULL,    -- 睡眠効率（%）

    /* ------- ステージ別内訳 ------- */
    minutes_deep_sleep  INT NULL,
    minutes_light_sleep INT NULL,
    minutes_rem_sleep   INT NULL,
    minutes_awake       INT NULL,

    /* ------- ローデータ ------- */
    raw_json NVARCHAR(MAX) NULL,

    CONSTRAINT PK_sleep_log PRIMARY KEY CLUSTERED (client_id, log_date)
);
PRINT N'sleep_log テーブルの再作成が完了しました';
GO
