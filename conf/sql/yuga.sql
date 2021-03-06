USE [Yuga]
GO
/****** Object:  Table [dbo].[UnsubmitRequest]    Script Date: 09/29/2014 11:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UnsubmitRequest](
	[requestID] [nvarchar](10) NOT NULL,
	[noticeID] [nvarchar](10) NOT NULL,
	[timecardProjectID] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_UnsubmitRequest] PRIMARY KEY CLUSTERED 
(
	[requestID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transaction]    Script Date: 09/29/2014 11:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transaction](
	[transactionID] [nvarchar](15) NOT NULL,
	[tableName] [nvarchar](20) NOT NULL,
	[lastUpdated] [datetime] NOT NULL,
	[validDate] [date] NULL,
	[remark] [nvarchar](250) NULL,
 CONSTRAINT [PK_Transaction] PRIMARY KEY CLUSTERED 
(
	[transactionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TimecardProject]    Script Date: 09/29/2014 11:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TimecardProject](
	[timecardProjectID] [nvarchar](10) NOT NULL,
	[timecardID] [nvarchar](10) NOT NULL,
	[projectID] [nvarchar](10) NOT NULL,
	[day1] [float] NULL,
	[day2] [float] NULL,
	[day3] [float] NULL,
	[day4] [float] NULL,
	[day5] [float] NULL,
	[day6] [float] NULL,
	[day7] [float] NULL,
	[totalHour] [float] NULL,
	[status] [nvarchar](8) NOT NULL,
 CONSTRAINT [PK_TimecardProject] PRIMARY KEY CLUSTERED 
(
	[timecardProjectID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Timecard]    Script Date: 09/29/2014 11:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Timecard](
	[timecardID] [nvarchar](10) NOT NULL,
	[employeeID] [nvarchar](10) NOT NULL,
	[empLevelID] [nvarchar](10) NOT NULL,
	[orgID] [nvarchar](10) NOT NULL,
	[startDate] [date] NOT NULL,
	[endDate] [date] NOT NULL,
	[day1] [float] NULL,
	[day2] [float] NULL,
	[day3] [float] NULL,
	[day4] [float] NULL,
	[day5] [float] NULL,
	[day6] [float] NULL,
	[day7] [float] NULL,
	[totalHour] [float] NULL,
	[updatedTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Timecard] PRIMARY KEY CLUSTERED 
(
	[timecardID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProjectType]    Script Date: 09/29/2014 11:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectType](
	[projectTypeID] [nvarchar](10) NOT NULL,
	[title] [nvarchar](50) NOT NULL,
	[sortOrder] [int] NOT NULL,
	[remark] [nvarchar](250) NULL,
	[flag] [nvarchar](20) NULL,
 CONSTRAINT [PK_ProjectType] PRIMARY KEY CLUSTERED 
(
	[projectTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProjectResourcePlan]    Script Date: 09/29/2014 11:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectResourcePlan](
	[resourcePlanID] [nvarchar](10) NOT NULL,
	[projectMemberID] [nvarchar](10) NOT NULL,
	[year] [int] NOT NULL,
	[month] [int] NOT NULL,
	[plannedWorkSize] [float] NOT NULL,
 CONSTRAINT [PK_ProjectResourcePlan] PRIMARY KEY CLUSTERED 
(
	[resourcePlanID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProjectResourceActual]    Script Date: 09/29/2014 11:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectResourceActual](
	[resourceActualID] [nvarchar](10) NOT NULL,
	[projectMemberID] [nvarchar](10) NOT NULL,
	[resourcePlanID] [nvarchar](10) NOT NULL,
	[first] [float] NULL,
	[second] [float] NULL,
	[third] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[resourceActualID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProjectMember]    Script Date: 09/29/2014 11:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProjectMember](
	[projectMemberID] [nvarchar](10) NOT NULL,
	[empLevelID] [nvarchar](10) NULL,
	[employeeID] [nvarchar](10) NULL,
	[projectID] [nvarchar](10) NOT NULL,
	[orgID] [nvarchar](10) NULL,
	[name] [nvarchar](50) NULL,
	[actualWorkSize] [float] NULL,
	[plannedWorkSize] [float] NULL,
	[overtimeSize] [float] NULL,
	[overtimeApproved] [bit] NULL,
	[approvedDate] [date] NULL,
	[remark] [nvarchar](500) NULL,
	[type] [varchar](6) NOT NULL,
 CONSTRAINT [PK_ProjectMember] PRIMARY KEY CLUSTERED 
(
	[projectMemberID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProjectBudgetActual]    Script Date: 09/29/2014 11:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectBudgetActual](
	[budgetActualID] [nvarchar](10) NOT NULL,
	[projectID] [nvarchar](10) NOT NULL,
	[year] [int] NOT NULL,
	[month] [int] NOT NULL,
	[vendorExpense] [float] NULL,
	[outsourcingExpense] [float] NULL,
	[projectExpense] [float] NULL,
	[opexExpense] [float] NULL,
 CONSTRAINT [PK_ProjectBudgetActual] PRIMARY KEY CLUSTERED 
(
	[budgetActualID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProjectBilled]    Script Date: 09/29/2014 11:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProjectBilled](
	[billedID] [nvarchar](10) NOT NULL,
	[projectID] [nvarchar](10) NOT NULL,
	[billedDate] [date] NOT NULL,
	[billedAmount] [int] NOT NULL,
	[billedType] [varchar](6) NOT NULL,
	[remark] [nvarchar](50) NULL,
	[plannedBilledID] [nvarchar](10) NULL,
 CONSTRAINT [PK_ProjectPlannedBilled] PRIMARY KEY CLUSTERED 
(
	[billedID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Project]    Script Date: 09/29/2014 11:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Project](
	[projectID] [nvarchar](10) NOT NULL,
	[employeeID] [nvarchar](10) NOT NULL,
	[orgID] [nvarchar](10) NOT NULL,
	[projectTypeID] [nvarchar](10) NOT NULL,
	[projectName] [nvarchar](100) NOT NULL,
	[startDate] [date] NOT NULL,
	[endDate] [date] NOT NULL,
	[currency] [nvarchar](5) NULL,
	[licenseRevenue] [decimal](18, 2) NOT NULL,
	[siRevenue] [decimal](18, 2) NOT NULL,
	[smRevenue] [decimal](18, 2) NOT NULL,
	[vendorSolution] [decimal](18, 2) NOT NULL,
	[vendorOutSourcing] [decimal](18, 2) NOT NULL,
	[expenseProject] [decimal](18, 2) NOT NULL,
	[expenseOPEX] [decimal](18, 2) NOT NULL,
	[status] [char](1) NOT NULL,
	[outsourceRevenue] [decimal](18, 2) NULL,
	[internalRDRevenue] [decimal](18, 2) NULL,
 CONSTRAINT [PK_Project] PRIMARY KEY CLUSTERED 
(
	[projectID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OvertimeRequest]    Script Date: 09/29/2014 11:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OvertimeRequest](
	[requestID] [nvarchar](10) NOT NULL,
	[noticeID] [nvarchar](10) NOT NULL,
	[timecardProjectID] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_OvertimeRequest] PRIMARY KEY CLUSTERED 
(
	[requestID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Organization]    Script Date: 09/29/2014 11:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Organization](
	[orgID] [nvarchar](10) NOT NULL,
	[parentOrgID] [nvarchar](10) NULL,
	[orgLevel] [int] NOT NULL,
	[orgName] [nvarchar](100) NOT NULL,
	[orgAlias] [nvarchar](100) NULL,
	[comment] [nvarchar](100) NULL,
	[updateDate] [date] NULL,
 CONSTRAINT [PK_Organization] PRIMARY KEY CLUSTERED 
(
	[orgID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notice]    Script Date: 09/29/2014 11:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Notice](
	[noticeID] [nvarchar](10) NOT NULL,
	[senderID] [nvarchar](10) NOT NULL,
	[receiverID] [nchar](10) NOT NULL,
	[projectID] [nvarchar](10) NOT NULL,
	[noticeTime] [datetime] NOT NULL,
	[noticeType] [nchar](10) NOT NULL,
	[message] [nvarchar](500) NOT NULL,
	[isResponse] [char](1) NULL,
	[isApproved] [char](1) NULL,
	[responseTime] [datetime] NULL,
	[isRejected] [char](1) NULL,
	[rejectReason] [nvarchar](500) NULL,
	[responseMessage] [nvarchar](500) NULL,
 CONSTRAINT [PK_Notice] PRIMARY KEY CLUSTERED 
(
	[noticeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MemberShipRequest]    Script Date: 09/29/2014 11:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MemberShipRequest](
	[requestID] [nvarchar](10) NOT NULL,
	[noticeID] [nvarchar](10) NOT NULL,
	[projectID] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_MemberShipRequest] PRIMARY KEY CLUSTERED 
(
	[requestID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Holiday]    Script Date: 09/29/2014 11:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Holiday](
	[holidayID] [nvarchar](10) NOT NULL,
	[startDate] [date] NOT NULL,
	[endDate] [date] NOT NULL,
	[holidayTitle] [nvarchar](500) NOT NULL,
 CONSTRAINT [PK_CalendarHoliday] PRIMARY KEY CLUSTERED 
(
	[holidayID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmployeeLog]    Script Date: 09/29/2014 11:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EmployeeLog](
	[logID] [nvarchar](10) NOT NULL,
	[employeeID] [nvarchar](10) NOT NULL,
	[empLevelID] [nvarchar](10) NOT NULL,
	[orgID] [nvarchar](10) NOT NULL,
	[employeeName] [nvarchar](50) NOT NULL,
	[title] [nvarchar](50) NOT NULL,
	[team] [nvarchar](50) NULL,
	[department] [nvarchar](50) NULL,
	[division] [nvarchar](50) NULL,
	[email] [nvarchar](50) NOT NULL,
	[password] [nvarchar](50) NULL,
	[lastPromotionDate] [date] NOT NULL,
	[role] [char](1) NOT NULL,
 CONSTRAINT [PK_EmployeeLog] PRIMARY KEY CLUSTERED 
(
	[logID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EmployeeLevel]    Script Date: 09/29/2014 11:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeeLevel](
	[empLevelID] [nvarchar](10) NOT NULL,
	[title] [nvarchar](50) NOT NULL,
	[laborCostUS] [float] NULL,
	[listPriceUS] [float] NULL,
	[devCostUS] [float] NULL,
	[internalBillingPriceUS] [float] NULL,
	[internalDevCostUS] [float] NULL,
	[laborCostKRW] [float] NULL,
	[listPriceKRW] [float] NULL,
	[devCostKRW] [float] NULL,
	[internalBillingPriceKRW] [float] NULL,
	[internalDevCostKRW] [float] NULL,
	[remark] [nvarchar](50) NULL,
	[updateDate] [date] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 09/29/2014 11:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Employee](
	[employeeID] [nvarchar](10) NOT NULL,
	[empLevelID] [nvarchar](10) NOT NULL,
	[orgID] [nvarchar](10) NOT NULL,
	[employeeName] [nvarchar](50) NOT NULL,
	[title] [nvarchar](50) NOT NULL,
	[team] [nvarchar](50) NULL,
	[department] [nvarchar](50) NULL,
	[division] [nvarchar](50) NULL,
	[email] [nvarchar](50) NOT NULL,
	[password] [nvarchar](50) NULL,
	[lastPromotionDate] [date] NOT NULL,
	[role] [char](1) NOT NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[employeeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Default [DF__ProjectMem__type__4222D4EF]    Script Date: 09/29/2014 11:05:05 ******/
ALTER TABLE [dbo].[ProjectMember] ADD  CONSTRAINT [DF__ProjectMem__type__4222D4EF]  DEFAULT ('MEMBER') FOR [type]
GO
