CREATE TABLE [dbo].[Truck] (
    [Id]                 INT            IDENTITY (1, 1) NOT NULL,
    [BrandName]          NVARCHAR (100) NOT NULL,
    [RegistrationNumber] NVARCHAR (100) NOT NULL,
    [Year]               NVARCHAR (50)  NULL,
    [Payload]            INT            NOT NULL,
    [FuelConsumption]    INT            NOT NULL,
    [Volume]             INT            NOT NULL,
    [Name]          NVARCHAR (100) NULL,
    [IsDeleted] BIT NOT NULL DEFAULT 0, 
    CONSTRAINT [pk_Truck] PRIMARY KEY CLUSTERED ([Id] ASC)
);

