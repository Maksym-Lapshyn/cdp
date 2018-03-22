CREATE TABLE [dbo].[Warehouse] (
    [Id]    INT           IDENTITY (1, 1) NOT NULL,
    [City]  NVARCHAR (50) NOT NULL,
    [State] NVARCHAR (50) NOT NULL,
    [IsDeleted] BIT NOT NULL DEFAULT 0, 
    CONSTRAINT [pk_Warehouse] PRIMARY KEY CLUSTERED ([Id] ASC)
);

