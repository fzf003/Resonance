USE [master]
GO
/****** Object:  Database [ResonanceDB]    Script Date: 15-10-2016 16:26:15 ******/
CREATE DATABASE [ResonanceDB]
GO
ALTER DATABASE [ResonanceDB] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ResonanceDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ResonanceDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ResonanceDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ResonanceDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ResonanceDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ResonanceDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [ResonanceDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ResonanceDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ResonanceDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ResonanceDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ResonanceDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ResonanceDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ResonanceDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ResonanceDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ResonanceDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ResonanceDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ResonanceDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ResonanceDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ResonanceDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ResonanceDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ResonanceDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ResonanceDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ResonanceDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ResonanceDB] SET RECOVERY FULL 
GO
ALTER DATABASE [ResonanceDB] SET  MULTI_USER 
GO
ALTER DATABASE [ResonanceDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ResonanceDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ResonanceDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ResonanceDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ResonanceDB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'ResonanceDB', N'ON'
GO
ALTER DATABASE [ResonanceDB] SET QUERY_STORE = OFF
GO
USE [ResonanceDB]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [ResonanceDB]
GO
/****** Object:  Table [dbo].[ConsumedSubscriptionEvent]    Script Date: 15-10-2016 16:26:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConsumedSubscriptionEvent](
	[Id] [bigint] NOT NULL,
	[SubscriptionId] [bigint] NOT NULL,
	[EventName] [nvarchar](50) NULL,
	[PublicationDateUtc] [datetime2](7) NOT NULL,
	[FunctionalKey] [nvarchar](50) NOT NULL,
	[Priority] [int] NOT NULL,
	[PayloadId] [bigint] NULL,
	[DeliveryDateUtc] [datetime2](7) NOT NULL,
	[ConsumedDateUtc] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_DeliveredSubscriptionEvents] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EventPayload]    Script Date: 15-10-2016 16:26:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventPayload](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Payload] [ntext] NOT NULL,
 CONSTRAINT [PK_EventPayload] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FailedSubscriptionEvent]    Script Date: 15-10-2016 16:26:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FailedSubscriptionEvent](
	[Id] [bigint] NOT NULL,
	[SubscriptionId] [bigint] NOT NULL,
	[EventName] [nvarchar](50) NULL,
	[PublicationDateUtc] [datetime2](7) NOT NULL,
	[FunctionalKey] [nvarchar](50) NOT NULL,
	[Priority] [int] NOT NULL,
	[PayloadId] [bigint] NULL,
	[DeliveryDateUtc] [datetime2](7) NULL,
	[FailedDateUtc] [datetime2](7) NOT NULL,
	[Reason] [int] NOT NULL,
	[ReasonOther] [nvarchar](1000) NULL,
 CONSTRAINT [PK_FailedSubscriptionEvents] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LastConsumedSubscriptionEvent]    Script Date: 15-10-2016 16:26:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LastConsumedSubscriptionEvent](
	[SubscriptionId] [bigint] NOT NULL,
	[FunctionalKey] [nvarchar](50) NOT NULL,
	[PublicationDateUtc] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_LastConsumedSubscriptionEvent] PRIMARY KEY CLUSTERED 
(
	[SubscriptionId] ASC,
	[FunctionalKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Subscription]    Script Date: 15-10-2016 16:26:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subscription](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Ordered] [bit] NOT NULL,
	[TimeToLive] [int] NULL,
	[MaxDeliveries] [int] NOT NULL,
	[DeliveryDelay] [int] NULL,
 CONSTRAINT [PK_Subscription] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UK_Subscription_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SubscriptionEvent]    Script Date: 15-10-2016 16:26:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubscriptionEvent](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[SubscriptionId] [bigint] NOT NULL,
	[TopicEventId] [bigint] NOT NULL,
	[EventName] [nvarchar](50) NULL,
	[PublicationDateUtc] [datetime2](7) NOT NULL,
	[FunctionalKey] [nvarchar](50) NOT NULL,
	[Priority] [int] NOT NULL,
	[PayloadId] [bigint] NULL,
	[ExpirationDateUtc] [datetime2](7) NOT NULL,
	[DeliveryDelayedUntilUtc] [datetime2](7) NOT NULL,
	[DeliveryCount] [int] NOT NULL,
	[DeliveryDateUtc] [datetime2](7) NULL,
	[DeliveryKey] [varchar](36) NOT NULL,
	[InvisibleUntilUtc] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_SubscriptionEvent] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Topic]    Script Date: 15-10-2016 16:26:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Topic](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Notes] [nvarchar](500) NULL,
 CONSTRAINT [PK_Topic] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UK_Topic_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TopicEvent]    Script Date: 15-10-2016 16:26:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TopicEvent](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[TopicId] [bigint] NOT NULL,
	[EventName] [nvarchar](50) NULL,
	[PublicationDateUtc] [datetime2](7) NOT NULL,
	[ExpirationDateUtc] [datetime2](7) NOT NULL,
	[FunctionalKey] [nvarchar](50) NOT NULL,
	[Headers] [nvarchar](1000) NULL,
	[Priority] [int] NOT NULL,
	[PayloadId] [bigint] NULL,
 CONSTRAINT [PK_TopicEvent] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TopicSubscription]    Script Date: 15-10-2016 16:26:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TopicSubscription](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[TopicId] [bigint] NOT NULL,
	[SubscriptionId] [bigint] NOT NULL,
	[Enabled] [bit] NOT NULL,
	[Filtered] [bit] NOT NULL,
 CONSTRAINT [PK_TopicSubscription] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TopicSubscriptionFilter]    Script Date: 15-10-2016 16:26:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TopicSubscriptionFilter](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[TopicSubscriptionId] [bigint] NOT NULL,
	[Header] [nvarchar](100) NOT NULL,
	[MatchExpression] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_TopicSubscriptionFilter] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[ConsumedSubscriptionEvent]  WITH CHECK ADD  CONSTRAINT [FK_ConsumedSubscriptionEvent_EventPayload] FOREIGN KEY([PayloadId])
REFERENCES [dbo].[EventPayload] ([Id])
GO
ALTER TABLE [dbo].[ConsumedSubscriptionEvent] CHECK CONSTRAINT [FK_ConsumedSubscriptionEvent_EventPayload]
GO
ALTER TABLE [dbo].[SubscriptionEvent]  WITH CHECK ADD  CONSTRAINT [FK_SubscriptionEvent_EventPayload] FOREIGN KEY([PayloadId])
REFERENCES [dbo].[EventPayload] ([Id])
GO
ALTER TABLE [dbo].[SubscriptionEvent] CHECK CONSTRAINT [FK_SubscriptionEvent_EventPayload]
GO
ALTER TABLE [dbo].[SubscriptionEvent]  WITH CHECK ADD  CONSTRAINT [FK_SubscriptionEvent_TopicEvent] FOREIGN KEY([TopicEventId])
REFERENCES [dbo].[TopicEvent] ([Id])
GO
ALTER TABLE [dbo].[SubscriptionEvent] CHECK CONSTRAINT [FK_SubscriptionEvent_TopicEvent]
GO
ALTER TABLE [dbo].[TopicEvent]  WITH CHECK ADD  CONSTRAINT [FK_TopicEvent_EventPayload] FOREIGN KEY([PayloadId])
REFERENCES [dbo].[EventPayload] ([Id])
GO
ALTER TABLE [dbo].[TopicEvent] CHECK CONSTRAINT [FK_TopicEvent_EventPayload]
GO
ALTER TABLE [dbo].[TopicSubscription]  WITH CHECK ADD  CONSTRAINT [FK_TopicSubscription_Subscription] FOREIGN KEY([SubscriptionId])
REFERENCES [dbo].[Subscription] ([Id])
GO
ALTER TABLE [dbo].[TopicSubscription] CHECK CONSTRAINT [FK_TopicSubscription_Subscription]
GO
ALTER TABLE [dbo].[TopicSubscription]  WITH CHECK ADD  CONSTRAINT [FK_TopicSubscription_Topic] FOREIGN KEY([TopicId])
REFERENCES [dbo].[Topic] ([Id])
GO
ALTER TABLE [dbo].[TopicSubscription] CHECK CONSTRAINT [FK_TopicSubscription_Topic]
GO
ALTER TABLE [dbo].[TopicSubscriptionFilter]  WITH CHECK ADD  CONSTRAINT [FK_TopicSubscriptionFilter_TopicSubscription] FOREIGN KEY([TopicSubscriptionId])
REFERENCES [dbo].[TopicSubscription] ([Id])
GO
ALTER TABLE [dbo].[TopicSubscriptionFilter] CHECK CONSTRAINT [FK_TopicSubscriptionFilter_TopicSubscription]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0=Unknown, 1=Expired, 2=MaxRetriesReached, 3=Other' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FailedSubscriptionEvent', @level2type=N'COLUMN',@level2name=N'Reason'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Time to live in seconds' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Subscription', @level2type=N'COLUMN',@level2name=N'TimeToLive'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Delay the delivery by number of seconds' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Subscription', @level2type=N'COLUMN',@level2name=N'DeliveryDelay'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Custom payload for this subscriber, in case the payload was transformed/modified for this subscription.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SubscriptionEvent', @level2type=N'COLUMN',@level2name=N'PayloadId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Json-formatted key-value pair. Only used for topic-subscription filtering.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicEvent', @level2type=N'COLUMN',@level2name=N'Headers'
GO
USE [master]
GO
ALTER DATABASE [ResonanceDB] SET  READ_WRITE 
GO
