CREATE TABLE [dbo].[Shipment] (
    [Id]            INT      IDENTITY (1, 1) NOT NULL,
    [RouteId]       INT      NOT NULL,
    [DriverId]      INT      NOT NULL,
    [TruckId]       INT      NOT NULL,
    [DepartureDate] DATETIME NOT NULL,
    [DeliveryDate]  DATETIME NOT NULL,
    [ActualDistance] INT NULL, 
    [Status] INT NOT NULL DEFAULT 1 , 
    CONSTRAINT [pk_Shipment] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [fk_Shipment_Driver] FOREIGN KEY ([DriverId]) REFERENCES [dbo].[Driver] ([Id]),
    CONSTRAINT [fk_Shipment_Route] FOREIGN KEY ([RouteId]) REFERENCES [dbo].[Route] ([Id]),
    CONSTRAINT [fk_Shipment_Truck] FOREIGN KEY ([TruckId]) REFERENCES [dbo].[Truck] ([Id]),
	CONSTRAINT [fk_Shipment_ShipmentStatus] FOREIGN KEY ([Status]) REFERENCES [dbo].[ShipmentStatus] ([Id])
);

