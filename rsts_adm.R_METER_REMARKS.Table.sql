USE [RXDB]
GO
/****** Object:  Table [rsts_adm].[R_METER_REMARKS]    Script Date: 9/9/2020 4:15:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rsts_adm].[R_METER_REMARKS](
	[CODE] [varchar](5) NOT NULL,
	[DESCRIPTION] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
