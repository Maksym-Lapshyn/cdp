CREATE TABLE [dbo].[ShipmentStatus]
(
	[Id] INT IDENTITY(1,1) NOT NULL,
	[DisplayName] NVARCHAR(50) NOT NULL, 
    CONSTRAINT [pk_ShipmentStatus] PRIMARY KEY CLUSTERED ([Id] ASC)
)
