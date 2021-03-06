USE [master]
GO
/****** Object:  Database [TnfArchitecture]    Script Date: 05/07/2017 10:32:25 ******/
CREATE DATABASE [TnfArchitecture]
GO
ALTER DATABASE [TnfArchitecture] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TnfArchitecture] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TnfArchitecture] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TnfArchitecture] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TnfArchitecture] SET ARITHABORT OFF 
GO
ALTER DATABASE [TnfArchitecture] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TnfArchitecture] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TnfArchitecture] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TnfArchitecture] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TnfArchitecture] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TnfArchitecture] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TnfArchitecture] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TnfArchitecture] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TnfArchitecture] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TnfArchitecture] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TnfArchitecture] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TnfArchitecture] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TnfArchitecture] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TnfArchitecture] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TnfArchitecture] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TnfArchitecture] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TnfArchitecture] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TnfArchitecture] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TnfArchitecture] SET  MULTI_USER 
GO
ALTER DATABASE [TnfArchitecture] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TnfArchitecture] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TnfArchitecture] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TnfArchitecture] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TnfArchitecture] SET DELAYED_DURABILITY = DISABLED 
GO
USE [TnfArchitecture]
GO
/****** Object:  Table [dbo].[Countries]    Script Date: 05/07/2017 10:32:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Countries](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SYS009_PROFESSIONAL]    Script Date: 05/07/2017 10:32:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SYS009_PROFESSIONAL](
	[SYS009_PROFESSIONAL_ID] [numeric](15, 0) IDENTITY(1,1) NOT NULL,
	[SYS009_PROFESSIONAL_CODE] [uniqueidentifier] NOT NULL,
	[SYS009_NAME] [varchar](50) NULL,
	[SYS009_ADDRESS] [varchar](50) NULL,
	[SYS009_ADDRESS_NUMBER] [varchar](9) NULL,
	[SYS009_ADDRESS_COMPLEMENT] [varchar](100) NULL,
	[SYS009_ZIP_CODE] [varchar](15) NULL,
	[SYS009_PHONE] [varchar](50) NULL,
	[SYS009_EMAIL] [varchar](50) NULL,
 CONSTRAINT [PK_SYS009_PROFESSIONAL] PRIMARY KEY CLUSTERED 
(
	[SYS009_PROFESSIONAL_ID] ASC,
	[SYS009_PROFESSIONAL_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SYS010_PROFESSIONAL_SPECIALTIES]    Script Date: 05/07/2017 10:32:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYS010_PROFESSIONAL_SPECIALTIES](
	[SYS009_PROFESSIONAL_ID] [numeric](15, 0) NOT NULL,
	[SYS009_PROFESSIONAL_CODE] [uniqueidentifier] NOT NULL,
	[SYS011_SPECIALTIES_ID] [int] NOT NULL,
 CONSTRAINT [PK_SYS010_PROFESSIONAL_SPECIALTIES] PRIMARY KEY CLUSTERED 
(
	[SYS009_PROFESSIONAL_ID] ASC,
	[SYS009_PROFESSIONAL_CODE] ASC,
	[SYS011_SPECIALTIES_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SYS011_SPECIALTIES]    Script Date: 05/07/2017 10:32:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SYS011_SPECIALTIES](
	[SYS011_SPECIALTIES_ID] [int] IDENTITY(1,1) NOT NULL,
	[SYS011_SPECIALTIES_DESCRIPTION] [varchar](100) NOT NULL,
 CONSTRAINT [SYS011_SPECIALTIES_ID] PRIMARY KEY CLUSTERED 
(
	[SYS011_SPECIALTIES_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TnfLanguages]    Script Date: 05/07/2017 10:32:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TnfLanguages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TenantId] [int] NULL,
	[Name] [nvarchar](10) NOT NULL,
	[DisplayName] [nvarchar](64) NOT NULL,
	[Icon] [nvarchar](128) NULL,
	[IsDeleted] [bit] NOT NULL,
	[DeleterUserId] [bigint] NULL,
	[DeletionTime] [datetime] NULL,
	[LastModificationTime] [datetime] NULL,
	[LastModifierUserId] [bigint] NULL,
	[CreationTime] [datetime] NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[IsDisabled] [bit] NOT NULL DEFAULT ((0)),
 CONSTRAINT [PK_dbo.AbpLanguages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TnfLanguageTexts]    Script Date: 05/07/2017 10:32:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TnfLanguageTexts](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[TenantId] [int] NULL,
	[LanguageName] [nvarchar](10) NOT NULL,
	[Source] [nvarchar](128) NOT NULL,
	[Key] [nvarchar](256) NOT NULL,
	[Value] [nvarchar](max) NOT NULL,
	[LastModificationTime] [datetime] NULL,
	[LastModifierUserId] [bigint] NULL,
	[CreationTime] [datetime] NOT NULL,
	[CreatorUserId] [bigint] NULL,
 CONSTRAINT [PK_dbo.AbpLanguageTexts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Countries] ON 

GO
INSERT [dbo].[Countries] ([Id], [Name]) VALUES (5002, N'Brasil')
GO
INSERT [dbo].[Countries] ([Id], [Name]) VALUES (5003, N'EUA')
GO
SET IDENTITY_INSERT [dbo].[Countries] OFF
GO
SET IDENTITY_INSERT [dbo].[SYS009_PROFESSIONAL] ON 

GO
INSERT [dbo].[SYS009_PROFESSIONAL] ([SYS009_PROFESSIONAL_ID], [SYS009_PROFESSIONAL_CODE], [SYS009_NAME], [SYS009_ADDRESS], [SYS009_ADDRESS_NUMBER], [SYS009_ADDRESS_COMPLEMENT], [SYS009_ZIP_CODE], [SYS009_PHONE], [SYS009_EMAIL]) VALUES (CAST(3 AS Numeric(15, 0)), N'bedf015a-bf2e-45eb-594e-08d49659dee4', N'João da Silva', N'Rua Do Comercio', N'123', N'APT 123', N'12345678', N'98653214', N'joao@silva.com')
GO
SET IDENTITY_INSERT [dbo].[SYS009_PROFESSIONAL] OFF
GO
INSERT [dbo].[SYS010_PROFESSIONAL_SPECIALTIES] ([SYS009_PROFESSIONAL_ID], [SYS009_PROFESSIONAL_CODE], [SYS011_SPECIALTIES_ID]) VALUES (CAST(3 AS Numeric(15, 0)), N'bedf015a-bf2e-45eb-594e-08d49659dee4', 3)
GO
SET IDENTITY_INSERT [dbo].[SYS011_SPECIALTIES] ON 

GO
INSERT [dbo].[SYS011_SPECIALTIES] ([SYS011_SPECIALTIES_ID], [SYS011_SPECIALTIES_DESCRIPTION]) VALUES (3, N'Cirurgia Geral')
GO
INSERT [dbo].[SYS011_SPECIALTIES] ([SYS011_SPECIALTIES_ID], [SYS011_SPECIALTIES_DESCRIPTION]) VALUES (4, N'Cirurgia Vascular')
GO
SET IDENTITY_INSERT [dbo].[SYS011_SPECIALTIES] OFF
GO
SET IDENTITY_INSERT [dbo].[TnfLanguages] ON 

GO
INSERT [dbo].[TnfLanguages] ([Id], [TenantId], [Name], [DisplayName], [Icon], [IsDeleted], [DeleterUserId], [DeletionTime], [LastModificationTime], [LastModifierUserId], [CreationTime], [CreatorUserId], [IsDisabled]) VALUES (2, NULL, N'en', N'English', N'famfamfam-flags gb', 0, NULL, NULL, NULL, NULL, CAST(N'2017-02-16 10:53:32.873' AS DateTime), NULL, 0)
GO
INSERT [dbo].[TnfLanguages] ([Id], [TenantId], [Name], [DisplayName], [Icon], [IsDeleted], [DeleterUserId], [DeletionTime], [LastModificationTime], [LastModifierUserId], [CreationTime], [CreatorUserId], [IsDisabled]) VALUES (3, NULL, N'pt-BR', N'Português-BR', N'famfamfam-flags br', 0, NULL, NULL, NULL, NULL, CAST(N'2017-02-16 10:55:14.277' AS DateTime), NULL, 0)
GO
SET IDENTITY_INSERT [dbo].[TnfLanguages] OFF
GO
SET IDENTITY_INSERT [dbo].[TnfLanguageTexts] ON 

GO
INSERT [dbo].[TnfLanguageTexts] ([Id], [TenantId], [LanguageName], [Source], [Key], [Value], [LastModificationTime], [LastModifierUserId], [CreationTime], [CreatorUserId]) VALUES (2, NULL, N'en', N'ArchitectureApp', N'President_Title', N'Home Page', NULL, NULL, CAST(N'2017-02-16 15:09:10.600' AS DateTime), NULL)
GO
INSERT [dbo].[TnfLanguageTexts] ([Id], [TenantId], [LanguageName], [Source], [Key], [Value], [LastModificationTime], [LastModifierUserId], [CreationTime], [CreatorUserId]) VALUES (13, NULL, N'pt-BR', N'ArchitectureApp', N'President_Title', N'Página Inicial', NULL, NULL, CAST(N'2017-03-13 10:21:24.423' AS DateTime), NULL)
GO
INSERT [dbo].[TnfLanguageTexts] ([Id], [TenantId], [LanguageName], [Source], [Key], [Value], [LastModificationTime], [LastModifierUserId], [CreationTime], [CreatorUserId]) VALUES (10002, NULL, N'en', N'ArchitectureApp', N'PresidentZipCodeMustHaveValue', N'A president must have a name', NULL, NULL, CAST(N'2017-03-30 19:46:50.727' AS DateTime), NULL)
GO
INSERT [dbo].[TnfLanguageTexts] ([Id], [TenantId], [LanguageName], [Source], [Key], [Value], [LastModificationTime], [LastModifierUserId], [CreationTime], [CreatorUserId]) VALUES (10003, NULL, N'pt-BR', N'ArchitectureApp', N'PresidentZipCodeMustHaveValue', N'Um presidente precisa ter um nome', NULL, NULL, CAST(N'2017-03-30 19:47:02.350' AS DateTime), NULL)
GO
INSERT [dbo].[TnfLanguageTexts] ([Id], [TenantId], [LanguageName], [Source], [Key], [Value], [LastModificationTime], [LastModifierUserId], [CreationTime], [CreatorUserId]) VALUES (10004, NULL, N'en', N'ArchitectureApp', N'PresidentNameMustHaveValue', N'A president must have a Zip Code', NULL, NULL, CAST(N'2017-03-30 19:47:45.170' AS DateTime), NULL)
GO
INSERT [dbo].[TnfLanguageTexts] ([Id], [TenantId], [LanguageName], [Source], [Key], [Value], [LastModificationTime], [LastModifierUserId], [CreationTime], [CreatorUserId]) VALUES (10005, NULL, N'pt-BR', N'ArchitectureApp', N'PresidentNameMustHaveValue', N'Um presidente precisa ter um CEP', NULL, NULL, CAST(N'2017-03-30 19:47:45.177' AS DateTime), NULL)
GO
INSERT [dbo].[TnfLanguageTexts] ([Id], [TenantId], [LanguageName], [Source], [Key], [Value], [LastModificationTime], [LastModifierUserId], [CreationTime], [CreatorUserId]) VALUES (10006, NULL, N'pt-BR', N'ArchitectureApp', N'InvalidParameter', N'Parâmetro inválido: {0}', NULL, NULL, CAST(N'2017-06-19 00:00:00.000' AS DateTime), NULL)
GO
INSERT [dbo].[TnfLanguageTexts] ([Id], [TenantId], [LanguageName], [Source], [Key], [Value], [LastModificationTime], [LastModifierUserId], [CreationTime], [CreatorUserId]) VALUES (10009, NULL, N'en', N'ArchitectureApp', N'InvalidParameter', N'Invalid parameter: {0}', NULL, NULL, CAST(N'2017-06-19 00:00:00.000' AS DateTime), NULL)
GO
SET IDENTITY_INSERT [dbo].[TnfLanguageTexts] OFF

GO
ALTER TABLE [dbo].[SYS010_PROFESSIONAL_SPECIALTIES]  WITH CHECK ADD  CONSTRAINT [FK_SYS009_PROFESSIONAL] FOREIGN KEY([SYS009_PROFESSIONAL_ID], [SYS009_PROFESSIONAL_CODE])
REFERENCES [dbo].[SYS009_PROFESSIONAL] ([SYS009_PROFESSIONAL_ID], [SYS009_PROFESSIONAL_CODE])
GO
ALTER TABLE [dbo].[SYS010_PROFESSIONAL_SPECIALTIES] CHECK CONSTRAINT [FK_SYS009_PROFESSIONAL]
GO
ALTER TABLE [dbo].[SYS010_PROFESSIONAL_SPECIALTIES]  WITH CHECK ADD  CONSTRAINT [FK_SYS011_SPECIALTIES] FOREIGN KEY([SYS011_SPECIALTIES_ID])
REFERENCES [dbo].[SYS011_SPECIALTIES] ([SYS011_SPECIALTIES_ID])
GO
ALTER TABLE [dbo].[SYS010_PROFESSIONAL_SPECIALTIES] CHECK CONSTRAINT [FK_SYS011_SPECIALTIES]
GO
USE [master]
GO
ALTER DATABASE [TnfArchitecture] SET  READ_WRITE 
GO
