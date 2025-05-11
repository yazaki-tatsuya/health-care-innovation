/****** Object:  Table [dbo].[activities_heart]    Script Date: 2025/05/10 16:23:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[activities_heart](
	[client_id] [char](10) NOT NULL,
	[date] [date] NOT NULL,
	[time] [time](7) NOT NULL,
	[value] [int] NOT NULL,
 CONSTRAINT [PK_activities_heart] PRIMARY KEY CLUSTERED 
(
	[client_id] ASC,
	[date] ASC,
	[time] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

