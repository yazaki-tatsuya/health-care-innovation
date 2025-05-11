/*--- テーブル説明（任意） ---*/
EXEC sys.sp_addextendedproperty
    @name  = N'MS_Description',
    @value = N'Fitbit 睡眠ログ（日次）',
    @level0type = N'SCHEMA', @level0name = N'dbo',
    @level1type = N'TABLE',  @level1name = N'sleep_log';

/*--- 以下、列ごと ---*/
DECLARE @tbl SYSNAME = N'sleep_log', @sch SYSNAME = N'dbo';

EXEC sys.sp_addextendedproperty
  @name=N'MS_Description', @value=N'ユーザー識別子', 
  @level0type=N'SCHEMA', @level0name=@sch,
  @level1type=N'TABLE',  @level1name=@tbl,
  @level2type=N'COLUMN', @level2name=N'client_id';

EXEC sys.sp_addextendedproperty
  @name=N'MS_Description', @value=N'睡眠基準日（ローカル日付）',
  @level0type=N'SCHEMA', @level0name=@sch,
  @level1type=N'TABLE',  @level1name=@tbl,
  @level2type=N'COLUMN', @level2name=N'log_date';

/* ──以下コピペで列数ぶん── */
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fitbit 側の睡眠ログ ID',           @level0type=N'SCHEMA', @level0name=@sch, @level1type=N'TABLE', @level1name=@tbl, @level2type=N'COLUMN', @level2name=N'sleep_log_id';
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'メイン睡眠か昼寝か (1=main)',      @level0type=N'SCHEMA', @level0name=@sch, @level1type=N'TABLE', @level1name=@tbl, @level2type=N'COLUMN', @level2name=N'is_main_sleep';
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'記録方式 classic / stages',       @level0type=N'SCHEMA', @level0name=@sch, @level1type=N'TABLE', @level1name=@tbl, @level2type=N'COLUMN', @level2name=N'type';

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ベッドイン時刻',                    @level0type=N'SCHEMA', @level0name=@sch, @level1type=N'TABLE', @level1name=@tbl, @level2type=N'COLUMN', @level2name=N'start_time';
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ベッドアウト時刻',                  @level0type=N'SCHEMA', @level0name=@sch, @level1type=N'TABLE', @level1name=@tbl, @level2type=N'COLUMN', @level2name=N'end_time';
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ベッド滞在総時間（分）',            @level0type=N'SCHEMA', @level0name=@sch, @level1type=N'TABLE', @level1name=@tbl, @level2type=N'COLUMN', @level2name=N'total_time_in_bed';
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'入眠までの時間（分）',              @level0type=N'SCHEMA', @level0name=@sch, @level1type=N'TABLE', @level1name=@tbl, @level2type=N'COLUMN', @level2name=N'minutes_to_fall_asleep';
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'起床後ベッドを出るまでの時間（分）',@level0type=N'SCHEMA', @level0name=@sch, @level1type=N'TABLE', @level1name=@tbl, @level2type=N'COLUMN', @level2name=N'minutes_after_wakeup';

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'実睡眠時間（分）',                  @level0type=N'SCHEMA', @level0name=@sch, @level1type=N'TABLE', @level1name=@tbl, @level2type=N'COLUMN', @level2name=N'total_minutes_asleep';
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'睡眠効率（%）',                      @level0type=N'SCHEMA', @level0name=@sch, @level1type=N'TABLE', @level1name=@tbl, @level2type=N'COLUMN', @level2name=N'sleep_efficiency';
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fitbit 総合スコア (0-100)',        @level0type=N'SCHEMA', @level0name=@sch, @level1type=N'TABLE', @level1name=@tbl, @level2type=N'COLUMN', @level2name=N'sleep_score';
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'スコア内訳：睡眠時間',               @level0type=N'SCHEMA', @level0name=@sch, @level1type=N'TABLE', @level1name=@tbl, @level2type=N'COLUMN', @level2name=N'score_duration';
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'スコア内訳：睡眠ステージ構成',       @level0type=N'SCHEMA', @level0name=@sch, @level1type=N'TABLE', @level1name=@tbl, @level2type=N'COLUMN', @level2name=N'score_composition';
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'スコア内訳：回復度',                 @level0type=N'SCHEMA', @level0name=@sch, @level1type=N'TABLE', @level1name=@tbl, @level2type=N'COLUMN', @level2name=N'score_revitalization';

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'覚醒回数',                          @level0type=N'SCHEMA', @level0name=@sch, @level1type=N'TABLE', @level1name=@tbl, @level2type=N'COLUMN', @level2name=N'awakenings_count';
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'覚醒時間総分',                      @level0type=N'SCHEMA', @level0name=@sch, @level1type=N'TABLE', @level1name=@tbl, @level2type=N'COLUMN', @level2name=N'awakenings_duration';

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'深い睡眠（分）',                    @level0type=N'SCHEMA', @level0name=@sch, @level1type=N'TABLE', @level1name=@tbl, @level2type=N'COLUMN', @level2name=N'minutes_deep_sleep';
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'浅い睡眠（分）',                    @level0type=N'SCHEMA', @level0name=@sch, @level1type=N'TABLE', @level1name=@tbl, @level2type=N'COLUMN', @level2name=N'minutes_light_sleep';
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'REM 睡眠（分）',                    @level0type=N'SCHEMA', @level0name=@sch, @level1type=N'TABLE', @level1name=@tbl, @level2type=N'COLUMN', @level2name=N'minutes_rem_sleep';
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'覚醒状態の合計分',                  @level0type=N'SCHEMA', @level0name=@sch, @level1type=N'TABLE', @level1name=@tbl, @level2type=N'COLUMN', @level2name=N'minutes_awake';

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'睡眠中平均心拍数',                  @level0type=N'SCHEMA', @level0name=@sch, @level1type=N'TABLE', @level1name=@tbl, @level2type=N'COLUMN', @level2name=N'avg_hr_sleep';
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'安静呼吸数 (brpm)',                @level0type=N'SCHEMA', @level0name=@sch, @level1type=N'TABLE', @level1name=@tbl, @level2type=N'COLUMN', @level2name=N'breathing_rate';
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'体表温偏差 (℃)',                   @level0type=N'SCHEMA', @level0name=@sch, @level1type=N'TABLE', @level1name=@tbl, @level2type=N'COLUMN', @level2name=N'skin_temp_deviation';

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fitbit レスポンス JSON',           @level0type=N'SCHEMA', @level0name=@sch, @level1type=N'TABLE', @level1name=@tbl, @level2type=N'COLUMN', @level2name=N'raw_json';
