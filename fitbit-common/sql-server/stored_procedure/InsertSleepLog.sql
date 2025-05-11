CREATE PROCEDURE [dbo].[InsertSleepLog]
    @client_id            NVARCHAR(50),
    @log_date             DATE,
    @start_time           DATETIME      = NULL,
    @end_time             DATETIME      = NULL,
    @total_minutes_asleep INT           = NULL,
    @sleep_efficiency     INT           = NULL,
    @minutes_deep_sleep   INT           = NULL,
    @minutes_light_sleep  INT           = NULL,
    @minutes_rem_sleep    INT           = NULL,
    @minutes_awake        INT           = NULL,
    @raw_json             NVARCHAR(MAX) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    MERGE INTO dbo.sleep_log AS target
    USING (SELECT 
              @client_id AS client_id, 
              @log_date  AS log_date
           ) AS source
      ON target.client_id = source.client_id
     AND target.log_date    = source.log_date
    WHEN MATCHED THEN
      UPDATE SET
        start_time           = @start_time,
        end_time             = @end_time,
        total_minutes_asleep = @total_minutes_asleep,
        sleep_efficiency     = @sleep_efficiency,
        minutes_deep_sleep   = @minutes_deep_sleep,
        minutes_light_sleep  = @minutes_light_sleep,
        minutes_rem_sleep    = @minutes_rem_sleep,
        minutes_awake        = @minutes_awake,
        raw_json             = @raw_json
    WHEN NOT MATCHED THEN
      INSERT (
        client_id,
        log_date,
        start_time,
        end_time,
        total_minutes_asleep,
        sleep_efficiency,
        minutes_deep_sleep,
        minutes_light_sleep,
        minutes_rem_sleep,
        minutes_awake,
        raw_json
      )
      VALUES (
        @client_id,
        @log_date,
        @start_time,
        @end_time,
        @total_minutes_asleep,
        @sleep_efficiency,
        @minutes_deep_sleep,
        @minutes_light_sleep,
        @minutes_rem_sleep,
        @minutes_awake,
        @raw_json
      );
END;
GO
