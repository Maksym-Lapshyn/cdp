/*
Скрипт развертывания для Shipment_ML

Этот код был создан программным средством.
Изменения, внесенные в этот файл, могут привести к неверному выполнению кода и будут потеряны
в случае его повторного формирования.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "Shipment_ML"
:setvar DefaultFilePrefix "Shipment_ML"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Проверьте режим SQLCMD и отключите выполнение скрипта, если режим SQLCMD не поддерживается.
Чтобы повторно включить скрипт после включения режима SQLCMD выполните следующую инструкцию:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'Для успешного выполнения этого скрипта должен быть включен режим SQLCMD.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Выполняется создание $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Параметры базы данных изменить нельзя. Применить эти параметры может только пользователь SysAdmin.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Параметры базы данных изменить нельзя. Применить эти параметры может только пользователь SysAdmin.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Выполняется создание [dbo].[Cargo]...';


GO
CREATE TABLE [dbo].[Cargo] (
    [Id]          INT IDENTITY (1, 1) NOT NULL,
    [Weight]      INT NOT NULL,
    [Volume]      INT NOT NULL,
    [SenderId]    INT NOT NULL,
    [RecipientId] INT NOT NULL,
    [ShipmentId]  INT NULL,
    CONSTRAINT [pk_Cargo] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Выполняется создание [dbo].[ContactInformation]...';


GO
CREATE TABLE [dbo].[ContactInformation] (
    [Id]        INT            IDENTITY (1, 1) NOT NULL,
    [FirstName] NVARCHAR (100) NOT NULL,
    [LastName]  NVARCHAR (100) NOT NULL,
    [CellPhone] NVARCHAR (20)  NOT NULL,
    CONSTRAINT [pk_ContactInformation] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Выполняется создание [dbo].[Driver]...';


GO
CREATE TABLE [dbo].[Driver] (
    [Id]        INT            IDENTITY (1, 1) NOT NULL,
    [FirstName] NVARCHAR (100) NOT NULL,
    [LastName]  NVARCHAR (100) NOT NULL,
    [Birthdate] NVARCHAR (100) NOT NULL,
    CONSTRAINT [pk_Driver] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Выполняется создание [dbo].[DriverTruck]...';


GO
CREATE TABLE [dbo].[DriverTruck] (
    [TruckId]  INT NOT NULL,
    [DriverId] INT NOT NULL,
    CONSTRAINT [pk_DriverTruck] PRIMARY KEY CLUSTERED ([DriverId] ASC, [TruckId] ASC)
);


GO
PRINT N'Выполняется создание [dbo].[Route]...';


GO
CREATE TABLE [dbo].[Route] (
    [Id]            INT IDENTITY (1, 1) NOT NULL,
    [OriginId]      INT NULL,
    [DestinationId] INT NULL,
    [Distance]      INT NOT NULL,
    CONSTRAINT [pk_Route] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Выполняется создание [dbo].[Shipment]...';


GO
CREATE TABLE [dbo].[Shipment] (
    [Id]             INT      IDENTITY (1, 1) NOT NULL,
    [RouteId]        INT      NOT NULL,
    [DriverId]       INT      NOT NULL,
    [TruckId]        INT      NOT NULL,
    [DepartureDate]  DATETIME NOT NULL,
    [DeliveryDate]   DATETIME NOT NULL,
    [ActualDistance] INT      NULL,
    [Status]         INT      NOT NULL,
    CONSTRAINT [pk_Shipment] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Выполняется создание [dbo].[ShipmentStatus]...';


GO
CREATE TABLE [dbo].[ShipmentStatus] (
    [Id]          INT           IDENTITY (1, 1) NOT NULL,
    [DisplayName] NVARCHAR (50) NOT NULL,
    CONSTRAINT [pk_ShipmentStatus] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Выполняется создание [dbo].[Truck]...';


GO
CREATE TABLE [dbo].[Truck] (
    [Id]                 INT            IDENTITY (1, 1) NOT NULL,
    [BrandName]          NVARCHAR (100) NOT NULL,
    [RegistrationNumber] NVARCHAR (100) NOT NULL,
    [Year]               NVARCHAR (50)  NULL,
    [Payload]            INT            NOT NULL,
    [FuelConsumption]    INT            NOT NULL,
    [Volume]             INT            NOT NULL,
    CONSTRAINT [pk_Truck] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Выполняется создание [dbo].[Warehouse]...';


GO
CREATE TABLE [dbo].[Warehouse] (
    [Id]    INT           IDENTITY (1, 1) NOT NULL,
    [City]  NVARCHAR (50) NOT NULL,
    [State] NVARCHAR (50) NOT NULL,
    CONSTRAINT [pk_Warehouse] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Выполняется создание ограничение без названия для [dbo].[Shipment]...';


GO
ALTER TABLE [dbo].[Shipment]
    ADD DEFAULT 1 FOR [Status];


GO
PRINT N'Выполняется создание [dbo].[fk_Cargo_Recipient]...';


GO
ALTER TABLE [dbo].[Cargo]
    ADD CONSTRAINT [fk_Cargo_Recipient] FOREIGN KEY ([RecipientId]) REFERENCES [dbo].[ContactInformation] ([Id]);


GO
PRINT N'Выполняется создание [dbo].[fk_Cargo_Sender]...';


GO
ALTER TABLE [dbo].[Cargo]
    ADD CONSTRAINT [fk_Cargo_Sender] FOREIGN KEY ([SenderId]) REFERENCES [dbo].[ContactInformation] ([Id]);


GO
PRINT N'Выполняется создание [dbo].[fk_Cargo_Shipment]...';


GO
ALTER TABLE [dbo].[Cargo]
    ADD CONSTRAINT [fk_Cargo_Shipment] FOREIGN KEY ([ShipmentId]) REFERENCES [dbo].[Shipment] ([Id]) ON DELETE SET NULL;


GO
PRINT N'Выполняется создание [dbo].[fk_DriverTruck_Driver]...';


GO
ALTER TABLE [dbo].[DriverTruck]
    ADD CONSTRAINT [fk_DriverTruck_Driver] FOREIGN KEY ([DriverId]) REFERENCES [dbo].[Driver] ([Id]);


GO
PRINT N'Выполняется создание [dbo].[fk_DriverTruck_Truck]...';


GO
ALTER TABLE [dbo].[DriverTruck]
    ADD CONSTRAINT [fk_DriverTruck_Truck] FOREIGN KEY ([TruckId]) REFERENCES [dbo].[Truck] ([Id]);


GO
PRINT N'Выполняется создание [dbo].[fk_Route_Destination]...';


GO
ALTER TABLE [dbo].[Route]
    ADD CONSTRAINT [fk_Route_Destination] FOREIGN KEY ([DestinationId]) REFERENCES [dbo].[Warehouse] ([Id]);


GO
PRINT N'Выполняется создание [dbo].[fk_Route_Origin]...';


GO
ALTER TABLE [dbo].[Route]
    ADD CONSTRAINT [fk_Route_Origin] FOREIGN KEY ([OriginId]) REFERENCES [dbo].[Warehouse] ([Id]);


GO
PRINT N'Выполняется создание [dbo].[fk_Shipment_Driver]...';


GO
ALTER TABLE [dbo].[Shipment]
    ADD CONSTRAINT [fk_Shipment_Driver] FOREIGN KEY ([DriverId]) REFERENCES [dbo].[Driver] ([Id]);


GO
PRINT N'Выполняется создание [dbo].[fk_Shipment_Route]...';


GO
ALTER TABLE [dbo].[Shipment]
    ADD CONSTRAINT [fk_Shipment_Route] FOREIGN KEY ([RouteId]) REFERENCES [dbo].[Route] ([Id]);


GO
PRINT N'Выполняется создание [dbo].[fk_Shipment_Truck]...';


GO
ALTER TABLE [dbo].[Shipment]
    ADD CONSTRAINT [fk_Shipment_Truck] FOREIGN KEY ([TruckId]) REFERENCES [dbo].[Truck] ([Id]);


GO
PRINT N'Выполняется создание [dbo].[fk_Shipment_ShipmentStatus]...';


GO
ALTER TABLE [dbo].[Shipment]
    ADD CONSTRAINT [fk_Shipment_ShipmentStatus] FOREIGN KEY ([Status]) REFERENCES [dbo].[ShipmentStatus] ([Id]);


GO
PRINT N'Выполняется создание [dbo].[vNewId]...';


GO

CREATE VIEW dbo.vNewId
AS
SELECT NEWID() AS Id
GO
PRINT N'Выполняется создание [dbo].[GenerateRandomDate]...';


GO

CREATE FUNCTION dbo.GenerateRandomDate (@dateFrom DATETIME, @dateTo DATETIME)
RETURNS DATETIME
AS BEGIN
    DECLARE @days_diff AS INT = cast(@dateTo - @dateFrom AS INT);
	DECLARE @departureDate DATETIME;

	SELECT @departureDate = @dateFrom +
		DATEADD(second, ABS(CHECKSUM((SELECT Id FROM dbo.vNewId)) % 60), 0) +
		DATEADD(minute, ABS(CHECKSUM((SELECT Id FROM dbo.vNewId)) % 60), 0) +
		DATEADD(hour, ABS(CHECKSUM((SELECT Id FROM dbo.vNewId)) % 24), 0) +
		DATEADD(day, ABS(CHECKSUM((SELECT Id FROM dbo.vNewId)) % @days_diff), 0);

    RETURN @departureDate
END
GO
PRINT N'Выполняется создание [dbo].[GetDriversExec]...';


GO

CREATE PROCEDURE dbo.GetDriversExec (@fieldName NVARCHAR(100), @fieldValue NVARCHAR(100))
AS BEGIN
	DECLARE @sqlCommand NVARCHAR(500);

	SET @sqlCommand = 'SELECT Firstname, Lastname, Birthdate FROM dbo.Driver WHERE ' + @fieldName + ' = ''' + @fieldValue  + ''';';

	EXEC(@sqlCommand);
END
GO
PRINT N'Выполняется создание [dbo].[GetDriversExecuteSQL]...';


GO

/*Procedure using EXECUTE sp_executesql*/

CREATE PROCEDURE dbo.GetDriversExecuteSQL (@fieldName NVARCHAR(100), @fieldValue NVARCHAR(100))
AS BEGIN
	DECLARE @sqlCommand NVARCHAR(500);

	SET @sqlCommand = 'SELECT Firstname, Lastname, Birthdate FROM dbo.Driver WHERE ' + @fieldName + '= @fieldValue;';

	EXECUTE sp_executesql @sqlCommand, N'@fieldValue NVARCHAR(100)', @fieldValue;
END
GO
PRINT N'Выполняется создание [dbo].[GetDriversOpenXML]...';


GO

CREATE PROCEDURE dbo.GetDriversOpenXML (@filterList XML)
AS BEGIN
	DECLARE @handle INT;
	DECLARE @prepareXmlStatus INT;
	DECLARE @filterTable TABLE (FieldName NVARCHAR(100), FieldValue NVARCHAR(100));

	EXEC @prepareXmlStatus= sp_xml_preparedocument @handle OUTPUT, @filterList;

	INSERT INTO @filterTable
	SELECT *
	FROM OPENXML(@handle, '/filters/filter', 2)  
	WITH (
		fieldName NVARCHAR(100),
		fieldValue NVARCHAR(100)
	);

	EXEC sp_xml_removedocument @handle;

	DECLARE @whereString NVARCHAR(1000);
	 
	SELECT @whereString = COALESCE(@whereString + ' AND ' , '') + FieldName + ' = ' + '''' + FieldValue + ''''
	FROM @filterTable;

	DECLARE @sqlCommand NVARCHAR(2000);
	SET @sqlCommand = 'SELECT Firstname, Lastname, Birthdate FROM dbo.Driver WHERE ';
	SET @sqlCommand = CONCAT(@sqlCommand, '', @whereString);

	EXEC(@sqlCommand);
END
GO
PRINT N'Выполняется создание [dbo].[GetDriversXMLNodes]...';


GO

CREATE PROCEDURE dbo.GetDriversXMLNodes (@filterList XML)
AS BEGIN
	DECLARE @filterTable TABLE (FieldName NVARCHAR(100), FieldValue NVARCHAR(100));

	INSERT INTO @filterTable
	SELECT FieldName = Filter.value('(fieldName)[1]', 'NVARCHAR(100)'), FieldValue = Filter.value('(fieldValue)[1]', 'NVARCHAR(100)')
	FROM @filterList.nodes('/filters/filter') AS Filters(Filter);

	DECLARE @whereString NVARCHAR(1000);
	 
	SELECT @whereString = COALESCE(@whereString + ' AND ' , '') + FieldName + ' = ' + '''' + FieldValue + ''''
	FROM @filterTable;

	DECLARE @sqlCommand NVARCHAR(2000);
	SET @sqlCommand = 'SELECT Firstname, Lastname, Birthdate FROM dbo.Driver WHERE ';
	SET @sqlCommand = CONCAT(@sqlCommand, '', @whereString);

	EXEC(@sqlCommand);
END

/*Test for procedures*/

--GO

--DECLARE @filterList AS XML = 
--'<filters>
--	<filter>
--		<fieldName>LastName</fieldName>
--		<fieldValue>Olson</fieldValue>
--	</filter>
--	<filter>
--		<fieldName>FirstName</fieldName>
--		<fieldValue>Alta</fieldValue>
--	</filter>
--</filters>';

--EXEC dbo.GetDriversXMLNodes @filterList;
GO
/*
Post-Deployment Script Template                            
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.        
 Use SQLCMD syntax to include a file in the post-deployment script.            
 Example:      :r .\myfile.sql                                
 Use SQLCMD syntax to reference a variable in the post-deployment script.        
 Example:      :setvar TableName MyTable                            
               SELECT * FROM [$(TableName)]                    
--------------------------------------------------------------------------------------
*/

INSERT INTO dbo.Driver(FirstName,LastName,BirthDate) VALUES (N'John',N'Doe',N'1/23/1967');
INSERT INTO dbo.Driver(FirstName,LastName,BirthDate) VALUES (N'Adam',N'Petr',N'5/23/1975');
INSERT INTO dbo.Driver(FirstName,LastName,BirthDate) VALUES (N'Jin',N'Partida',N'3/15/1980');
INSERT INTO dbo.Driver(FirstName,LastName,BirthDate) VALUES (N'Scott',N'Lucas',N'4/1/1985');
INSERT INTO dbo.Driver(FirstName,LastName,BirthDate) VALUES (N'Alta',N'Olson',N'6/14/1975');
INSERT INTO dbo.Driver(FirstName,LastName,BirthDate) VALUES (N'Arthur',N'Sullivan',N'4/26/1982');
INSERT INTO dbo.Driver(FirstName,LastName,BirthDate) VALUES (N'Robert',N'Suarez',N'4/11/1975');
INSERT INTO dbo.Driver(FirstName,LastName,BirthDate) VALUES (N'Timothy',N'Johns',N'10/7/1985');
INSERT INTO dbo.Driver(FirstName,LastName,BirthDate) VALUES (N'Olive',N'Tucker',N'12/25/1986');
INSERT INTO dbo.Driver(FirstName,LastName,BirthDate) VALUES (N'Lela',N'Coleman',N'4/20/1977');
INSERT INTO dbo.Driver(FirstName,LastName,BirthDate) VALUES (N'Maurice',N'Elam',N'4/2/1981');
INSERT INTO dbo.Driver(FirstName,LastName,BirthDate) VALUES (N'Charles',N'Delacruz',N'1/18/1975');
INSERT INTO dbo.Driver(FirstName,LastName,BirthDate) VALUES (N'Branden',N'Webster',N'7/3/1964');
INSERT INTO dbo.Driver(FirstName,LastName,BirthDate) VALUES (N'Bennie',N'Morley',N'12/25/1986');
INSERT INTO dbo.Driver(FirstName,LastName,BirthDate) VALUES (N'Jacob',N'Sanders',N'4/20/1936');
INSERT INTO dbo.Driver(FirstName,LastName,BirthDate) VALUES (N'Perry',N'Haley',N'4/26/1982');
INSERT INTO dbo.Driver(FirstName,LastName,BirthDate) VALUES (N'Emma',N'White',N'4/3/1955');
INSERT INTO dbo.Driver(FirstName,LastName,BirthDate) VALUES (N'Bryan',N'Baldridge',N'4/16/1952');
INSERT INTO dbo.Driver(FirstName,LastName,BirthDate) VALUES (N'Tom',N'Stennis',N'1/27/1985');
INSERT INTO dbo.Driver(FirstName,LastName,BirthDate) VALUES (N'Mike',N'O''Connor',N'12/20/1977');
INSERT INTO dbo.Truck(BrandName,RegistrationNumber,[Year],Payload,FuelConsumption,Volume) VALUES (N'MAN',N'1ABC234',N'2010',18500,22,100);
INSERT INTO dbo.Truck(BrandName,RegistrationNumber,[Year],Payload,FuelConsumption,Volume) VALUES (N'DAF',N'1ABC235',N'2009',15000,20,90);
INSERT INTO dbo.Truck(BrandName,RegistrationNumber,[Year],Payload,FuelConsumption,Volume) VALUES (N'MERCEDES BENZ',N'1ABC236',N'2013',15000,18,100);
INSERT INTO dbo.Truck(BrandName,RegistrationNumber,[Year],Payload,FuelConsumption,Volume) VALUES (N'Foton',N'1ABC237',N'2011',9000,18,30);
INSERT INTO dbo.Truck(BrandName,RegistrationNumber,[Year],Payload,FuelConsumption,Volume) VALUES (N'DAF',N'1ABC238',N'2009',26000,20,70);
INSERT INTO dbo.Truck(BrandName,RegistrationNumber,[Year],Payload,FuelConsumption,Volume) VALUES (N'DAF',N'1ABC239',N'2011',12000,20,70);
INSERT INTO dbo.Truck(BrandName,RegistrationNumber,[Year],Payload,FuelConsumption,Volume) VALUES (N'DAF',N'1ABC240',N'2014',12000,20,70);
INSERT INTO dbo.Truck(BrandName,RegistrationNumber,[Year],Payload,FuelConsumption,Volume) VALUES (N'DAF',N'1ABC241',N'2011',9000,18,50);
INSERT INTO dbo.Truck(BrandName,RegistrationNumber,[Year],Payload,FuelConsumption,Volume) VALUES (N'DAF',N'1ABC242',N'2011',9000,18,50);
INSERT INTO dbo.Truck(BrandName,RegistrationNumber,[Year],Payload,FuelConsumption,Volume) VALUES (N'Ford',N'1ABC243',N'2011',9000,18,50);
INSERT INTO dbo.Truck(BrandName,RegistrationNumber,[Year],Payload,FuelConsumption,Volume) VALUES (N'MAN',N'1ABC244',N'2013',9000,18,50);
INSERT INTO dbo.Truck(BrandName,RegistrationNumber,[Year],Payload,FuelConsumption,Volume) VALUES (N'MAN',N'1ABC245',N'2012',5000,18,50);
INSERT INTO dbo.Truck(BrandName,RegistrationNumber,[Year],Payload,FuelConsumption,Volume) VALUES (N'MAN',N'1ABC246',N'2011',18500,20,50);
INSERT INTO dbo.Truck(BrandName,RegistrationNumber,[Year],Payload,FuelConsumption,Volume) VALUES (N'MAN',N'1ABC247',N'2011',26000,18,50);
INSERT INTO dbo.Truck(BrandName,RegistrationNumber,[Year],Payload,FuelConsumption,Volume) VALUES (N'MAN',N'1ABC248',N'2011',20000,18,50);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (1,1);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (1,2);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (2,3);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (3,1);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (4,4);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (5,6);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (6,5);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (7,7);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (7,20);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (8,8);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (9,9);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (9,8);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (10,10);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (11,10);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (12,11);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (13,12);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (13,13);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (13,14);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (14,15);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (14,16);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (15,17);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (15,18);
INSERT INTO dbo.DriverTruck(TruckId,DriverId) VALUES (15,19);
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('New York','New York');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Los Angeles','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Chicago','Illinois');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Houston','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Philadelphia','Pennsylvania');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Phoenix','Arizona');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('San Antonio','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('San Diego','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Dallas','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('San Jose','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Austin','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Indianapolis','Indiana');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Jacksonville','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('San Francisco','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Columbus','Ohio');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Charlotte','North Carolina');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Fort Worth','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Detroit','Michigan');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('El Paso','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Memphis','Tennessee');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Seattle','Washington');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Denver','Colorado');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Washington','District of Columbia');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Boston','Massachusetts');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Nashville','Tennessee');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Baltimore','Maryland');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Oklahoma City','Oklahoma');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Louisville','Kentucky');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Portland','Oregon');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Las Vegas','Nevada');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Milwaukee','Wisconsin');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Albuquerque','New Mexico');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Tucson','Arizona');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Fresno','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Sacramento','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Long Beach','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Kansas City','Missouri');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Mesa','Arizona');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Virginia Beach','Virginia');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Atlanta','Georgia');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Colorado Springs','Colorado');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Omaha','Nebraska');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Raleigh','North Carolina');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Miami','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Oakland','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Minneapolis','Minnesota');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Tulsa','Oklahoma');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Cleveland','Ohio');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Wichita','Kansas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Arlington','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('New Orleans','Louisiana');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Bakersfield','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Tampa','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Honolulu','Hawai''i');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Aurora','Colorado');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Anaheim','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Santa Ana','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('St. Louis','Missouri');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Riverside','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Corpus Christi','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Lexington','Kentucky');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Pittsburgh','Pennsylvania');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Anchorage','Alaska');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Stockton','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Cincinnati','Ohio');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Saint Paul','Minnesota');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Toledo','Ohio');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Greensboro','North Carolina');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Newark','New Jersey');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Plano','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Henderson','Nevada');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Lincoln','Nebraska');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Buffalo','New York');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Jersey City','New Jersey');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Chula Vista','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Fort Wayne','Indiana');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Orlando','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('St. Petersburg','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Chandler','Arizona');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Laredo','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Norfolk','Virginia');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Durham','North Carolina');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Madison','Wisconsin');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Lubbock','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Irvine','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Winston?Salem','North Carolina');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Glendale','Arizona');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Garland','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Hialeah','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Reno','Nevada');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Chesapeake','Virginia');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Gilbert','Arizona');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Baton Rouge','Louisiana');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Irving','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Scottsdale','Arizona');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('North Las Vegas','Nevada');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Fremont','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Boise','Idaho');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Richmond','Virginia');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('San Bernardino','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Birmingham','Alabama');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Spokane','Washington');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Rochester','New York');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Des Moines','Iowa');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Modesto','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Fayetteville','North Carolina');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Tacoma','Washington');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Oxnard','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Fontana','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Columbus','Georgia');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Montgomery','Alabama');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Moreno Valley','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Shreveport','Louisiana');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Aurora','Illinois');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Yonkers','New York');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Akron','Ohio');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Huntington Beach','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Little Rock','Arkansas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Augusta','Georgia');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Amarillo','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Glendale','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Mobile','Alabama');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Grand Rapids','Michigan');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Salt Lake City','Utah');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Tallahassee','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Huntsville','Alabama');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Grand Prairie','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Knoxville','Tennessee');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Worcester','Massachusetts');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Newport News','Virginia');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Brownsville','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Overland Park','Kansas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Santa Clarita','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Providence','Rhode Island');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Garden Grove','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Chattanooga','Tennessee');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Oceanside','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Jackson','Mississippi');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Fort Lauderdale','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Santa Rosa','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Rancho Cucamonga','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Port St. Lucie','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Tempe','Arizona');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Ontario','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Vancouver','Washington');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Cape Coral','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Sioux Falls','South Dakota');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Springfield','Missouri');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Peoria','Arizona');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Pembroke Pines','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Elk Grove','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Salem','Oregon');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Lancaster','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Corona','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Eugene','Oregon');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Palmdale','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Salinas','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Springfield','Massachusetts');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Pasadena','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Fort Collins','Colorado');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Hayward','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Pomona','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Cary','North Carolina');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Rockford','Illinois');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Alexandria','Virginia');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Escondido','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('McKinney','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Kansas City','Kansas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Joliet','Illinois');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Sunnyvale','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Torrance','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Bridgeport','Connecticut');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Lakewood','Colorado');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Hollywood','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Paterson','New Jersey');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Naperville','Illinois');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Syracuse','New York');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Mesquite','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Dayton','Ohio');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Savannah','Georgia');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Clarksville','Tennessee');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Orange','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Pasadena','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Fullerton','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Killeen','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Frisco','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Hampton','Virginia');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('McAllen','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Warren','Michigan');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Bellevue','Washington');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('West Valley City','Utah');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Columbia','South Carolina');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Olathe','Kansas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Sterling Heights','Michigan');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('New Haven','Connecticut');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Miramar','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Waco','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Thousand Oaks','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Cedar Rapids','Iowa');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Charleston','South Carolina');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Visalia','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Topeka','Kansas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Elizabeth','New Jersey');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Gainesville','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Thornton','Colorado');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Roseville','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Carrollton','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Coral Springs','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Stamford','Connecticut');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Simi Valley','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Concord','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Hartford','Connecticut');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Kent','Washington');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Lafayette','Louisiana');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Midland','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Surprise','Arizona');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Denton','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Victorville','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Evansville','Indiana');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Santa Clara','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Abilene','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Athens','Georgia');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Vallejo','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Allentown','Pennsylvania');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Norman','Oklahoma');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Beaumont','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Independence','Missouri');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Murfreesboro','Tennessee');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Ann Arbor','Michigan');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Springfield','Illinois');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Berkeley','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Peoria','Illinois');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Provo','Utah');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('El Monte','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Columbia','Missouri');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Lansing','Michigan');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Fargo','North Dakota');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Downey','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Costa Mesa','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Wilmington','North Carolina');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Arvada','Colorado');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Inglewood','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Miami Gardens','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Carlsbad','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Westminster','Colorado');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Rochester','Minnesota');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Odessa','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Manchester','New Hampshire');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Elgin','Illinois');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('West Jordan','Utah');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Round Rock','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Clearwater','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Waterbury','Connecticut');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Gresham','Oregon');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Fairfield','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Billings','Montana');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Lowell','Massachusetts');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Ventura','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Pueblo','Colorado');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('High Point','North Carolina');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('West Covina','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Richmond','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Murrieta','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Cambridge','Massachusetts');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Antioch','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Temecula','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Norwalk','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Centennial','Colorado');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Everett','Washington');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Palm Bay','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Wichita Falls','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Green Bay','Wisconsin');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Daly City','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Burbank','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Richardson','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Pompano Beach','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('North Charleston','South Carolina');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Broken Arrow','Oklahoma');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Boulder','Colorado');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('West Palm Beach','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Santa Maria','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('El Cajon','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Davenport','Iowa');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Rialto','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Edison','New Jersey');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Las Cruces','New Mexico');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('San Mateo','California');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Lewisville','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('South Bend','Indiana');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Lakeland','Florida');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Erie','Pennsylvania');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Woodbridge','New Jersey');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Tyler','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('Pearland','Texas');
INSERT INTO dbo.Warehouse(City,[State]) VALUES ('College Station','Texas');

DECLARE @maxDistance INT = 3000;
DECLARE @minDistance INT = 100;

INSERT INTO dbo.Route(
	OriginId,
	DestinationId,
	Distance
)
SELECT DISTINCT
    origin.Id,
    destination.Id,
	FLOOR(RAND(CHECKSUM(NEWID()))*(@maxDistance - @minDistance) + @minDistance)
FROM 
    dbo.Warehouse AS origin
CROSS JOIN
    dbo.Warehouse AS destination
WHERE origin.Id != destination.Id;
MERGE INTO dbo.ShipmentStatus AS t
USING (VALUES(N'Scheduled'),(N'Departured'),(N'Arrived'),(N'Cancelled'),(N'Completed')) AS s (DisplayName)
ON (t.DisplayName = s.DisplayName)
WHEN MATCHED AND (t.DisplayName <> s.DisplayName) THEN
    UPDATE SET
    DisplayName = s.DisplayName
WHEN NOT MATCHED BY TARGET THEN
    INSERT(DisplayName)
    VALUES(s.DisplayName)
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;
INSERT INTO dbo.ContactInformation(
	[FirstName],
    [LastName],
	[CellPhone]
)
VALUES(
	'Maksym',
	'Lapshyn',
	'111222333'
);

DECLARE @currentRow INT = 0;
DECLARE @shipmentsToInsert INT;

SELECT @shipmentsToInsert = 1000;

DECLARE @routeCount INT;
DECLARE @truckCount INT;

SELECT @routeCount = COUNT(*)
FROM dbo.[Route];

SELECT @truckCount = COUNT(*)
FROM dbo.Truck;

WHILE @currentRow < @shipmentsToInsert
BEGIN
	DECLARE @truckId INT = ROUND(((@truckCount - 1) * RAND() + 1), 0);
	DECLARE @driverId INT;
	DECLARE @dateFrom AS DATETIME = '1990-01-01';
	DECLARE @dateTo AS DATETIME = '2004-01-01';
	DECLARE @departureDate DATETIME = dbo.GenerateRandomDate(@dateFrom, @dateTo);
	SET @dateFrom = '2004-01-01';
	SET @dateTo = '2018-01-01';
	DECLARE @deliveryDate DATETIME = dbo.GenerateRandomDate(@dateFrom, @dateTo);

	SELECT TOP 1 @driverId = DriverId
	FROM dbo.DriverTruck
	WHERE TruckId = @truckId
	ORDER BY NEWID();

	INSERT INTO dbo.Shipment(
		[RouteId],
		[DriverId],
		[TruckId],
		[DepartureDate],
		[DeliveryDate]
	)
	VALUES(
		ROUND(((@routeCount - 1) * RAND() + 1), 0),
		@driverId,
		@truckId,
		@departureDate,
		@deliveryDate
	)

	SET @currentRow = @currentRow + 1;
END

SET @currentRow = 0;
DECLARE @contactId INT = 1;
DECLARE @cargosToInsert INT = 10000;
DECLARE @maxVolume INT = 50;
DECLARE @minVolume INT = 1;
DECLARE @maxWeight INT = 5000;
DECLARE @minWeight INT = 1;

WHILE @currentRow < @cargosToInsert
BEGIN
	INSERT INTO dbo.Cargo(
		[Weight],
		[Volume],
		[SenderId],
		[RecipientId],
		[ShipmentId]
	)
	VALUES(
		FLOOR(RAND()*(@maxWeight - @minWeight) + @minWeight),
		FLOOR(RAND()*(@maxVolume - @minVolume) + @minVolume),
		@contactId,
		@contactId,
		FLOOR(RAND()*(@shipmentsToInsert - 1) + 1)
	)

	SET @currentRow = @currentRow + 1;
END
GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Обновление завершено.';


GO
