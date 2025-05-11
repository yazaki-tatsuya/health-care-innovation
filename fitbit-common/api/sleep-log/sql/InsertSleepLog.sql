CREATE PROCEDURE [dbo].[InsertSleepLog]
    -- ① キー／メタ
    @client_id            NVARCHAR(50),
    @log_date             DATE,
    @sleep_log_id         BIGINT           = NULL,
    @is_main_sleep        BIT              = NULL,
    @type                 NVARCHAR(20)     = NULL,

    -- ② タイムライン
    @start_time             DATETIME        = NULL,
    @end_time               DATETIME        = NULL,
    @total_time_in_bed      INT             = NULL,
    @minutes_to_fall_asleep INT             = NULL,
    @minutes_after_wakeup   INT             = NULL,

    -- ③ 集計スコア
    @total_minutes_asleep INT              = NULL,
    @sleep_efficiency     INT              = NULL,
    @sleep_score          INT              = NULL,
    @score_duration       INT              = NULL,
    @score_composition    INT              = NULL,
    @score_revitalization INT              = NULL,

    -- ④ 目覚め指標
    @awakenings_count    INT               = NULL,
    @awakenings_duration INT               = NULL,

    -- ⑤ ステージ詳細
    @minutes_deep_sleep  INT               = NULL,
    @minutes_light_sleep INT               = NULL,
    @minutes_rem_sleep   INT               = NULL,
    @minutes_awake       INT               = NULL,

    -- ⑥ 生体指標
    @avg_hr_sleep        INT               = NULL,
    @breathing_rate      DECIMAL(4,1)      = NULL,
    @skin_temp_deviation DECIMAL(4,1)      = NULL,

    -- ⑦ ローデータ
    @raw_json NVARCHAR(MAX) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    MERGE dbo.sleep_log AS tgt
    USING (SELECT @client_id AS client_id, @log_date AS log_date) AS src
       ON tgt.client_id = src.client_id
      AND tgt.log_date  = src.log_date
    WHEN MATCHED THEN
      UPDATE SET
          sleep_log_id           = @sleep_log_id,
          is_main_sleep          = @is_main_sleep,
          type                   = @type,
          start_time             = @start_time,
          end_time               = @end_time,
          total_time_in_bed      = @total_time_in_bed,
          minutes_to_fall_asleep = @minutes_to_fall_asleep,
          minutes_after_wakeup   = @minutes_after_wakeup,
          total_minutes_asleep   = @total_minutes_asleep,
          sleep_efficiency       = @sleep_efficiency,
          sleep_score            = @sleep_score,
          score_duration         = @score_duration,
          score_composition      = @score_composition,
          score_revitalization   = @score_revitalization,
          awakenings_count       = @awakenings_count,
          awakenings_duration    = @awakenings_duration,
          minutes_deep_sleep     = @minutes_deep_sleep,
          minutes_light_sleep    = @minutes_light_sleep,
          minutes_rem_sleep      = @minutes_rem_sleep,
          minutes_awake          = @minutes_awake,
          avg_hr_sleep           = @avg_hr_sleep,
          breathing_rate         = @breathing_rate,
          skin_temp_deviation    = @skin_temp_deviation,
          raw_json               = @raw_json
    WHEN NOT MATCHED THEN
      INSERT (
				client_id,
				log_date,
				sleep_log_id,
				is_main_sleep,
				type,
				start_time,
				end_time,
				total_time_in_bed,
				minutes_to_fall_asleep,
				minutes_after_wakeup,
				total_minutes_asleep,
				sleep_efficiency,
				sleep_score,
				score_duration,
				score_composition,
				score_revitalization,
				awakenings_count,
				awakenings_duration,
				minutes_deep_sleep,
				minutes_light_sleep,
				minutes_rem_sleep,
				minutes_awake,
				avg_hr_sleep,
				breathing_rate,
				skin_temp_deviation,
				raw_json
      )
      VALUES (
				@client_id, @log_date,
				@sleep_log_id,
				@is_main_sleep,
				@type,
				@start_time,
				@end_time,
				@total_time_in_bed,
				@minutes_to_fall_asleep,
				@minutes_after_wakeup,
				@total_minutes_asleep,
				@sleep_efficiency,
				@sleep_score,
				@score_duration,
				@score_composition,
				@score_revitalization,
				@awakenings_count,
				@awakenings_duration,
				@minutes_deep_sleep,
				@minutes_light_sleep,
				@minutes_rem_sleep,
				@minutes_awake,
				@avg_hr_sleep,
				@breathing_rate,
				@skin_temp_deviation,
				@raw_json
      );
END;
GO
