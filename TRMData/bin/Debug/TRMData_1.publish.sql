﻿/*
Deployment script for TRMData

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "TRMData"
:setvar DefaultFilePrefix "TRMData"
:setvar DefaultDataPath "C:\Users\Ante\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB"
:setvar DefaultLogPath "C:\Users\Ante\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Creating [dbo].[Inventory]...';


GO
CREATE TABLE [dbo].[Inventory] (
    [Id]             INT           IDENTITY (1, 1) NOT NULL,
    [ProductId]      INT           NOT NULL,
    [Quantity]       INT           NOT NULL,
    [PurchasedPrice] MONEY         NOT NULL,
    [PurchaseDate]   DATETIME2 (7) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Product]...';


GO
CREATE TABLE [dbo].[Product] (
    [Id]           INT            IDENTITY (1, 1) NOT NULL,
    [ProductName]  NVARCHAR (50)  NOT NULL,
    [Description]  NVARCHAR (MAX) NOT NULL,
    [RetailPrice]  MONEY          NOT NULL,
    [CreateDate]   DATETIME2 (7)  NOT NULL,
    [LastModified] DATETIME2 (7)  NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Sale]...';


GO
CREATE TABLE [dbo].[Sale] (
    [Id]        INT           IDENTITY (1, 1) NOT NULL,
    [CashierId] NVARCHAR (50) NOT NULL,
    [SaleDate]  DATETIME2 (7) NOT NULL,
    [SubTotoal] MONEY         NOT NULL,
    [Tax]       MONEY         NOT NULL,
    [Total]     MONEY         NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[SaleDetails]...';


GO
CREATE TABLE [dbo].[SaleDetails] (
    [Id]            INT   IDENTITY (1, 1) NOT NULL,
    [SaleId]        INT   NOT NULL,
    [ProductId]     INT   NOT NULL,
    [Quantity]      INT   NOT NULL,
    [PurchasePrice] MONEY NOT NULL,
    [Tax]           MONEY NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[User]...';


GO
CREATE TABLE [dbo].[User] (
    [Id]           NVARCHAR (128) NOT NULL,
    [FirstName]    NVARCHAR (50)  NOT NULL,
    [LastName]     NVARCHAR (50)  NOT NULL,
    [EmailAddress] NVARCHAR (256) NOT NULL,
    [CreatedDate]  DATETIME2 (7)  NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating unnamed constraint on [dbo].[Inventory]...';


GO
ALTER TABLE [dbo].[Inventory]
    ADD DEFAULT 1 FOR [Quantity];


GO
PRINT N'Creating unnamed constraint on [dbo].[Inventory]...';


GO
ALTER TABLE [dbo].[Inventory]
    ADD DEFAULT getutcdate() FOR [PurchaseDate];


GO
PRINT N'Creating unnamed constraint on [dbo].[Product]...';


GO
ALTER TABLE [dbo].[Product]
    ADD DEFAULT getutcDate() FOR [CreateDate];


GO
PRINT N'Creating unnamed constraint on [dbo].[Product]...';


GO
ALTER TABLE [dbo].[Product]
    ADD DEFAULT getutcdate() FOR [LastModified];


GO
PRINT N'Creating unnamed constraint on [dbo].[SaleDetails]...';


GO
ALTER TABLE [dbo].[SaleDetails]
    ADD DEFAULT 1 FOR [Quantity];


GO
PRINT N'Creating unnamed constraint on [dbo].[SaleDetails]...';


GO
ALTER TABLE [dbo].[SaleDetails]
    ADD DEFAULT 0 FOR [Tax];


GO
PRINT N'Creating unnamed constraint on [dbo].[User]...';


GO
ALTER TABLE [dbo].[User]
    ADD DEFAULT getutcdate() FOR [CreatedDate];


GO
PRINT N'Update complete.';


GO
