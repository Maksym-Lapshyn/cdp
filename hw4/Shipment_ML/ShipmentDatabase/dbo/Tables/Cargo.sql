CREATE TABLE [dbo].[Cargo] (
    [Id]          INT IDENTITY (1, 1) NOT NULL,
    [Weight]      FLOAT NOT NULL,
    [Volume]      FLOAT NOT NULL,
    [SenderId]    INT NOT NULL,
    [RecipientId] INT NOT NULL,
    [ShipmentId]  INT NULL,
    CONSTRAINT [pk_Cargo] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [fk_Cargo_Recipient] FOREIGN KEY ([RecipientId]) REFERENCES [dbo].[ContactInformation] ([Id]),
    CONSTRAINT [fk_Cargo_Sender] FOREIGN KEY ([SenderId]) REFERENCES [dbo].[ContactInformation] ([Id]),
    CONSTRAINT [fk_Cargo_Shipment] FOREIGN KEY ([ShipmentId]) REFERENCES [dbo].[Shipment] ([Id]) ON DELETE SET NULL
);

