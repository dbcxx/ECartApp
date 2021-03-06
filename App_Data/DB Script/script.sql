USE [master]
GO
/****** Object:  Database [eCartDb]    Script Date: 28/02/2021 1:36:54 AM ******/
CREATE DATABASE [eCartDb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'eCartDb', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\eCartDb.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'eCartDb_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\eCartDb_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [eCartDb] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [eCartDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [eCartDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [eCartDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [eCartDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [eCartDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [eCartDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [eCartDb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [eCartDb] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [eCartDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [eCartDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [eCartDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [eCartDb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [eCartDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [eCartDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [eCartDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [eCartDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [eCartDb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [eCartDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [eCartDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [eCartDb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [eCartDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [eCartDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [eCartDb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [eCartDb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [eCartDb] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [eCartDb] SET  MULTI_USER 
GO
ALTER DATABASE [eCartDb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [eCartDb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [eCartDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [eCartDb] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [eCartDb]
GO
/****** Object:  User [NT AUTHORITY\SYSTEM]    Script Date: 28/02/2021 1:36:54 AM ******/
CREATE USER [NT AUTHORITY\SYSTEM] FOR LOGIN [NT AUTHORITY\SYSTEM] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [NT AUTHORITY\SYSTEM]
GO
/****** Object:  Schema [Master]    Script Date: 28/02/2021 1:36:55 AM ******/
CREATE SCHEMA [Master]
GO
/****** Object:  Schema [order]    Script Date: 28/02/2021 1:36:55 AM ******/
CREATE SCHEMA [order]
GO
/****** Object:  Table [Master].[Categories]    Script Date: 28/02/2021 1:36:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Master].[Categories](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryCode] [varchar](150) NOT NULL,
	[CategoryName] [varchar](150) NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Master].[Items]    Script Date: 28/02/2021 1:36:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Master].[Items](
	[ItemId] [uniqueidentifier] NOT NULL,
	[CategoryId] [int] NOT NULL,
	[ItemCode] [varchar](50) NOT NULL,
	[ItemName] [varchar](250) NOT NULL,
	[Description] [varchar](250) NULL,
	[ImagePath] [varchar](550) NOT NULL,
	[ItemPrice] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Items] PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [order].[OrderDetails]    Script Date: 28/02/2021 1:36:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [order].[OrderDetails](
	[OrderDetailId] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NOT NULL,
	[ItemId] [varchar](550) NOT NULL,
	[Quantity] [decimal](18, 2) NOT NULL,
	[UnitPrice] [decimal](18, 2) NOT NULL,
	[Total] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[OrderDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [order].[Orders]    Script Date: 28/02/2021 1:36:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [order].[Orders](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[OrderNumber] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [Master].[Categories] ON 

INSERT [Master].[Categories] ([CategoryId], [CategoryCode], [CategoryName]) VALUES (1, N'mob', N'mobile')
INSERT [Master].[Categories] ([CategoryId], [CategoryCode], [CategoryName]) VALUES (2, N'lap', N'laptop')
INSERT [Master].[Categories] ([CategoryId], [CategoryCode], [CategoryName]) VALUES (3, N'bot', N'robot')
INSERT [Master].[Categories] ([CategoryId], [CategoryCode], [CategoryName]) VALUES (4, N'ass', N'assesories')
SET IDENTITY_INSERT [Master].[Categories] OFF
INSERT [Master].[Items] ([ItemId], [CategoryId], [ItemCode], [ItemName], [Description], [ImagePath], [ItemPrice]) VALUES (N'd5449846-fca1-41ab-acb0-00bbd9d62cd2', 3, N'rob', N'Gump', N'Gumps to deploy ', N'~/Images/5d44db4d-3355-42e4-8a0a-639857a466ed.jpg', CAST(100000.00 AS Decimal(18, 2)))
INSERT [Master].[Items] ([ItemId], [CategoryId], [ItemCode], [ItemName], [Description], [ImagePath], [ItemPrice]) VALUES (N'679d13c4-3f82-4f53-a235-1a84a44e2b9c', 4, N'bk', N'Bike ', N'Mountain bike ', N'~/Images/7743c4c9-4e88-442a-a045-6664f64b4258.jpg', CAST(30000.00 AS Decimal(18, 2)))
INSERT [Master].[Items] ([ItemId], [CategoryId], [ItemCode], [ItemName], [Description], [ImagePath], [ItemPrice]) VALUES (N'e77aa010-2fdd-4e00-9ad0-243f37d8f854', 1, N'msl', N'Microsoft Lumia Cyan', N'Microsoft Lumia Cyan', N'~/Images/cb666b8a-df0d-4152-8e20-051eee89b332.jpeg', CAST(11000.00 AS Decimal(18, 2)))
INSERT [Master].[Items] ([ItemId], [CategoryId], [ItemCode], [ItemName], [Description], [ImagePath], [ItemPrice]) VALUES (N'cb639a2a-478a-4ece-96f2-32e0c7399d60', 1, N'msl', N'Microsoft Lumia 730', N'Microsoft Lumia 730', N'~/Images/ce96e4fe-8ebe-4264-8667-5bac10ce586a.jpg', CAST(5670.00 AS Decimal(18, 2)))
INSERT [Master].[Items] ([ItemId], [CategoryId], [ItemCode], [ItemName], [Description], [ImagePath], [ItemPrice]) VALUES (N'5ab1e4c6-101d-46cc-9000-71c92b0cdf45', 4, N'die', N'dice', N'set of colored dice', N'~/Images/625c7c64-3231-4de2-b849-1cf34091da13.jpg', CAST(20.00 AS Decimal(18, 2)))
INSERT [Master].[Items] ([ItemId], [CategoryId], [ItemCode], [ItemName], [Description], [ImagePath], [ItemPrice]) VALUES (N'71463164-5d75-4670-a5a9-9de419ac4537', 1, N'msl', N'Microsoft Lumia 560', N'Microsoft Lumia 560', N'~/Images/20a08f99-8c94-444b-a43a-b424bc99fde3.jpg', CAST(1300.00 AS Decimal(18, 2)))
INSERT [Master].[Items] ([ItemId], [CategoryId], [ItemCode], [ItemName], [Description], [ImagePath], [ItemPrice]) VALUES (N'0c1d2c80-cd3b-49c3-8e81-e1b08897f334', 1, N'msl', N'Microsoft Lumia 550', N'Microsoft Lumia 550', N'~/Images/52b420fa-f150-4b7b-bc9d-8ad7e4b62d81.jpeg', CAST(6577.00 AS Decimal(18, 2)))
INSERT [Master].[Items] ([ItemId], [CategoryId], [ItemCode], [ItemName], [Description], [ImagePath], [ItemPrice]) VALUES (N'51403ba7-0de1-4177-a197-e1cf62185631', 1, N'msl', N'Microsoft Lumia Cyan', N'Microsoft Lumia Cyan', N'~/Images/31729577-4f85-495a-ab18-6e615a44a1a9.jpeg', CAST(11000.00 AS Decimal(18, 2)))
INSERT [Master].[Items] ([ItemId], [CategoryId], [ItemCode], [ItemName], [Description], [ImagePath], [ItemPrice]) VALUES (N'72eb5254-3768-4e03-acc6-e467a0a79257', 1, N'msl', N'Microsoft Lumia Dual Sim', N'Microsoft Lumia Dual Sim', N'~/Images/33a121e3-9caf-4554-a791-138eff0a814d.jpg', CAST(14000.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [order].[OrderDetails] ON 

INSERT [order].[OrderDetails] ([OrderDetailId], [OrderId], [ItemId], [Quantity], [UnitPrice], [Total]) VALUES (1, 1, N'e77aa010-2fdd-4e00-9ad0-243f37d8f854', CAST(1.00 AS Decimal(18, 2)), CAST(11000.00 AS Decimal(18, 2)), CAST(11000.00 AS Decimal(18, 2)))
INSERT [order].[OrderDetails] ([OrderDetailId], [OrderId], [ItemId], [Quantity], [UnitPrice], [Total]) VALUES (2, 1, N'71463164-5d75-4670-a5a9-9de419ac4537', CAST(1.00 AS Decimal(18, 2)), CAST(1300.00 AS Decimal(18, 2)), CAST(1300.00 AS Decimal(18, 2)))
INSERT [order].[OrderDetails] ([OrderDetailId], [OrderId], [ItemId], [Quantity], [UnitPrice], [Total]) VALUES (3, 1, N'72eb5254-3768-4e03-acc6-e467a0a79257', CAST(3.00 AS Decimal(18, 2)), CAST(14000.00 AS Decimal(18, 2)), CAST(42000.00 AS Decimal(18, 2)))
INSERT [order].[OrderDetails] ([OrderDetailId], [OrderId], [ItemId], [Quantity], [UnitPrice], [Total]) VALUES (4, 1, N'd5449846-fca1-41ab-acb0-00bbd9d62cd2', CAST(1.00 AS Decimal(18, 2)), CAST(100000.00 AS Decimal(18, 2)), CAST(100000.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [order].[OrderDetails] OFF
SET IDENTITY_INSERT [order].[Orders] ON 

INSERT [order].[Orders] ([OrderId], [OrderDate], [OrderNumber]) VALUES (1, CAST(0x0000ACDD000AB239 AS DateTime), N'28382021003856')
SET IDENTITY_INSERT [order].[Orders] OFF
USE [master]
GO
ALTER DATABASE [eCartDb] SET  READ_WRITE 
GO
