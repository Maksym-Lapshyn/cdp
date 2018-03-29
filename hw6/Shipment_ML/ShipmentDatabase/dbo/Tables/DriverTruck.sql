CREATE TABLE [dbo].[DriverTruck] (
    [TruckId]  INT NOT NULL,
    [DriverId] INT NOT NULL,
    CONSTRAINT [pk_DriverTruck] PRIMARY KEY CLUSTERED ([DriverId] ASC, [TruckId] ASC),
    CONSTRAINT [fk_DriverTruck_Driver] FOREIGN KEY ([DriverId]) REFERENCES [dbo].[Driver] ([Id]),
    CONSTRAINT [fk_DriverTruck_Truck] FOREIGN KEY ([TruckId]) REFERENCES [dbo].[Truck] ([Id])
);

