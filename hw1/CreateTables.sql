BEGIN TRANSACTION;

USE XYZ;

IF EXISTS ( SELECT [Name] FROM sys.tables WHERE [Name] = 'Cargo' )
	DROP TABLE dbo.Cargo
GO

IF EXISTS ( SELECT [Name] FROM sys.tables WHERE [Name] = 'Shipment' )
	DROP TABLE dbo.Shipment
GO

IF EXISTS ( SELECT [Name] FROM sys.tables WHERE [Name] = 'Route' )
	DROP TABLE dbo.[Route]
GO

IF EXISTS ( SELECT [Name] FROM sys.tables WHERE [Name] = 'Driver' )
	DROP TABLE dbo.Driver
GO

IF EXISTS ( SELECT [Name] FROM sys.tables WHERE [Name] = 'Truck' )
	DROP TABLE dbo.Truck
GO

IF EXISTS ( SELECT [Name] FROM sys.tables WHERE [Name] = 'Warehouse' )
	DROP TABLE dbo.Warehouse
GO

IF EXISTS ( SELECT [Name] FROM sys.tables WHERE [Name] = 'ContactInformation' )
	DROP TABLE dbo.ContactInformation
GO

CREATE TABLE dbo.ContactInformation (
	Id INT IDENTITY(1, 1) NOT NULL,
	FirstName NVARCHAR(100) NOT NULL,
	LastName NVARCHAR(100) NOT NULL,
	CellPhone NVARCHAR(20) NOT NULL
);

ALTER TABLE dbo.ContactInformation   
	ADD CONSTRAINT pk_ContactInformation PRIMARY KEY CLUSTERED(Id ASC);

CREATE TABLE dbo.Warehouse (
	Id INT IDENTITY(1, 1) NOT NULL
);

ALTER TABLE dbo.Warehouse   
	ADD CONSTRAINT pk_Warehouse PRIMARY KEY CLUSTERED(Id ASC);

CREATE TABLE dbo.Truck (
	Id INT IDENTITY(1, 1) NOT NULL,
	BrandName NVARCHAR (100) NOT NULL,
	RegistrationNumber NVARCHAR(100) NOT NULL,
	Payload DECIMAL NOT NULL,
	Volume DECIMAL NOT NULL,
	FuelConsumption DECIMAL NOT NULL,
);

ALTER TABLE dbo.Truck   
	ADD CONSTRAINT pk_Truck PRIMARY KEY CLUSTERED(Id ASC);

CREATE TABLE dbo.Driver (
	Id INT IDENTITY(1, 1) NOT NULL,
	TruckId INT NOT NULL
);

ALTER TABLE dbo.Driver   
	ADD CONSTRAINT pk_Driver PRIMARY KEY CLUSTERED(Id ASC),
		CONSTRAINT fk_Driver_Truck FOREIGN KEY (TruckId) REFERENCES dbo.Truck (Id);

CREATE TABLE dbo.[Route] (
	Id INT IDENTITY(1, 1) NOT NULL,
	OriginId INT NOT NULL,
	DestinationId INT NOT NULL,
	Distance DECIMAL NOT NULL
);

ALTER TABLE dbo.[Route]   
	ADD CONSTRAINT pk_Route PRIMARY KEY CLUSTERED(Id ASC),
		CONSTRAINT fk_Route_Origin FOREIGN KEY (OriginId) REFERENCES dbo.Warehouse (Id),
		CONSTRAINT fk_Route_Destination FOREIGN KEY (DestinationId) REFERENCES dbo.Warehouse (Id);

CREATE TABLE dbo.Shipment (
	Id INT IDENTITY(1, 1) NOT NULL,
	RouteId INT NOT NULL,
	DriverId INT NOT NULL,
	TruckId INT NOT NULL
);

ALTER TABLE dbo.Shipment   
	ADD CONSTRAINT pk_Shipment PRIMARY KEY CLUSTERED(Id ASC),
		CONSTRAINT fk_Shipment_Route FOREIGN KEY (RouteId) REFERENCES dbo.[Route] (Id),
		CONSTRAINT fk_Shipment_Driver FOREIGN KEY (DriverId) REFERENCES dbo.Driver (Id),
		CONSTRAINT fk_Shipment_Truck FOREIGN KEY (TruckId) REFERENCES dbo.Truck (Id);

CREATE TABLE dbo.Cargo (
	Id INT IDENTITY(1, 1) NOT NULL,
	[Weight] DECIMAL NOT NULL,
	Volume DECIMAL NOT NULL,
	CustomerId INT NOT NULL,
	RecipientId INT NOT NULL,
	RouteId INT NOT NULL
);

ALTER TABLE dbo.Cargo   
	ADD CONSTRAINT pk_Cargo PRIMARY KEY CLUSTERED(Id ASC),
		CONSTRAINT fk_Cargo_Customer FOREIGN KEY (CustomerId) REFERENCES dbo.ContactInformation (Id),
		CONSTRAINT fk_Cargo_Recipient FOREIGN KEY (RecipientId) REFERENCES dbo.ContactInformation (Id),
		CONSTRAINT fk_Cargo_Route FOREIGN KEY (RouteId) REFERENCES dbo.Route (Id);

COMMIT TRANSACTION;