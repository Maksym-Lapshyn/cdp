CREATE TABLE [dbo].[Route] (
    [Id]            INT IDENTITY (1, 1) NOT NULL,
    [OriginId]      INT NULL,
    [DestinationId] INT NULL,
    [Distance]      INT NOT NULL,
    [IsDeleted] BIT NOT NULL DEFAULT 0, 
    CONSTRAINT [pk_Route] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [fk_Route_Destination] FOREIGN KEY ([DestinationId]) REFERENCES [dbo].[Warehouse] ([Id]),
    CONSTRAINT [fk_Route_Origin] FOREIGN KEY ([OriginId]) REFERENCES [dbo].[Warehouse] ([Id])
);

