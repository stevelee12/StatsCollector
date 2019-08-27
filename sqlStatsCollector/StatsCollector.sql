CREATE DATABASE [StatsCollector]
CONTAINMENT = NONE
ON  PRIMARY
( NAME = N'StatsCollector', FILENAME = N'/var/opt/mssql/data/StatsCollector.mdf' , SIZE = 5120KB , FILEGROWTH = 1024KB )
LOG ON
( NAME = N'StatsCollector_log', FILENAME = N'/var/opt/mssql/data/StatsCollector_log.ldf' , SIZE = 3072KB , FILEGROWTH = 10%)
GO
ALTER DATABASE [StatsCollector] SET COMPATIBILITY_LEVEL = 120
GO
ALTER DATABASE [StatsCollector] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [StatsCollector] SET ANSI_NULLS OFF
GO
ALTER DATABASE [StatsCollector] SET ANSI_PADDING OFF
GO
ALTER DATABASE [StatsCollector] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [StatsCollector] SET ARITHABORT OFF
GO
ALTER DATABASE [StatsCollector] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [StatsCollector] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [StatsCollector] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [StatsCollector] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [StatsCollector] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [StatsCollector] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [StatsCollector] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [StatsCollector] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [StatsCollector] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [StatsCollector] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [StatsCollector] SET  DISABLE_BROKER
GO
ALTER DATABASE [StatsCollector] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [StatsCollector] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [StatsCollector] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [StatsCollector] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [StatsCollector] SET  READ_WRITE
GO
ALTER DATABASE [StatsCollector] SET RECOVERY FULL
GO
ALTER DATABASE [StatsCollector] SET  MULTI_USER
GO
ALTER DATABASE [StatsCollector] SET PAGE_VERIFY CHECKSUM 
GO
ALTER DATABASE [StatsCollector] SET TARGET_RECOVERY_TIME = 0 SECONDS
GO
ALTER DATABASE [StatsCollector] SET DELAYED_DURABILITY = DISABLED
GO
USE [StatsCollector]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [StatsCollector] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO
 
 
 
/*
   15 August 201915:06:43
   User:
   Server: devdbo01\test
   Database: Anaes
   Application:
*/
 
/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Reading
                (
                ReadingId int NOT NULL IDENTITY (1, 1),
                DeviceId varchar(100) NULL,
                MetricId varchar(50) NULL,
                ReadingValue varchar(100) NULL,
                ReadingDateTime datetime NULL,
                dtInput datetime NULL
                )  ON [PRIMARY]
GO
ALTER TABLE dbo.Reading ADD CONSTRAINT
                DF_Reading_dtInput DEFAULT getdate() FOR dtInput
GO
ALTER TABLE dbo.Reading ADD CONSTRAINT
                PK_Reading PRIMARY KEY CLUSTERED
                (
                ReadingId
                ) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
 
GO
ALTER TABLE dbo.Reading SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
 
USE StatsCollector
 
-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters
-- command (Ctrl-Shift-M) to fill in the parameter
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:                            Steve Lee
-- Create date: 15/08/2019
-- Description:    Save Reading into database
-- =============================================
CREATE PROCEDURE usp_SaveReading
                -- Add the parameters for the stored procedure here
		@DeviceId					varchar(100)		= NULL
		,@MetricId                  varchar(50)         = NULL
		,@ReadingValue              varchar(100)		= NULL
		,@ReadingDateTime			datetime			= NULL
 
AS
BEGIN
                -- SET NOCOUNT ON added to prevent extra result sets from
                -- interfering with SELECT statements.
                SET NOCOUNT ON;
 
    INSERT INTO [dbo].[Reading]
           ([DeviceId]
           ,[MetricId]
           ,[ReadingValue]
           ,[ReadingDateTime]
                ) VALUES (
			@DeviceId
           ,@MetricId
           ,@ReadingValue
           ,@ReadingDateTime
                )
          
END
GO
 
USE [StatsCollector]
GO
 
/****** Object:  StoredProcedure [dbo].[usp_LoadReading]    Script Date: 20/08/2019 11:59:50 ******/
SET ANSI_NULLS ON
GO
 
SET QUOTED_IDENTIFIER ON
GO
 
 
-- =============================================
-- Author:                            Steve Lee
-- Create date: 20/08/2019
-- Description:    Return an individual reading
-- =============================================
CREATE PROCEDURE [dbo].[usp_LoadReading]
                -- Add the parameters for the stored procedure here
                @ReadingId       int
AS
BEGIN
                -- SET NOCOUNT ON added to prevent extra result sets from
                -- interfering with SELECT statements.
                SET NOCOUNT ON;
 
    -- Insert statements for procedure here
                SELECT  r.ReadingId as Id
						,r.DeviceId
                        ,r.MetricId
                        ,r.ReadingValue
                        ,r.ReadingDateTime
                FROM   Reading r
                WHERE r.ReadingId = @ReadingId
END
 
 
GO
 
 
USE [StatsCollector]
GO
 
/****** Object:  StoredProcedure [dbo].[usp_LoadAllReadings]    Script Date: 20/08/2019 11:59:46 ******/
SET ANSI_NULLS ON
GO
 
SET QUOTED_IDENTIFIER ON
GO
 
-- =============================================
-- Author:                            Steve Lee
-- Create date: 20/08/2019
-- Description:    Return ALL readings (we'd never have this in live but we're purely demo)
-- =============================================
CREATE PROCEDURE [dbo].[usp_LoadAllReadings]
                -- Add the parameters for the stored procedure here
               
AS
BEGIN
                -- SET NOCOUNT ON added to prevent extra result sets from
                -- interfering with SELECT statements.
                SET NOCOUNT ON;
 
    -- Insert statements for procedure here
                SELECT  r.ReadingId as Id
						,r.DeviceId
                        ,r.MetricId
                        ,r.ReadingValue
                        ,r.ReadingDateTime
                FROM   Reading r
END
 
GO
 
 
USE [master]
GO
CREATE LOGIN [StatsCollectorWritter] WITH PASSWORD=N'someC0mpl3xPassword!', DEFAULT_DATABASE=[StatsCollector], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
USE [StatsCollector]
GO
CREATE USER [StatsCollectorWritter] FOR LOGIN [StatsCollectorWritter]
GO
 
 
USE StatsCollector
GO
GRANT EXECUTE ON [dbo].[usp_SaveReading] TO [StatsCollectorWritter]
GO
 
use [StatsCollector]
GO
GRANT EXECUTE ON [dbo].[usp_LoadReading] TO [StatsCollectorWritter]
GO
 
use [StatsCollector]
GO
GRANT EXECUTE ON [dbo].[usp_LoadAllReadings] TO [StatsCollectorWritter]
GO