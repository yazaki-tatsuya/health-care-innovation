/****** Object:  StoredProcedure [dbo].[InsertHeartRatesFromJson]    Script Date: 2025/05/10 16:22:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- JSON 文字列を受け取り、その中身を実際に INSERT する SP
CREATE PROCEDURE [dbo].[InsertHeartRatesFromJson]
  @json NVARCHAR(MAX)
AS
BEGIN
  SET NOCOUNT ON;

  INSERT INTO dbo.activities_heart (client_id, date, time, value)
  SELECT
    client_id,
    date,
    time,
    value
  FROM OPENJSON(@json)
    WITH (
      client_id CHAR(10)   '$.client_id',
      date      DATE       '$.date',
      time      TIME(7)    '$.time',
      value     INT        '$.value'
    );
END
GO

