CREATE TABLE [dbo].[ContactInformation] (
    [Id]        INT            IDENTITY (1, 1) NOT NULL,
    [FirstName] NVARCHAR (100) NOT NULL,
    [LastName]  NVARCHAR (100) NOT NULL,
    [CellPhone] NVARCHAR (20)  NOT NULL,
    CONSTRAINT [pk_ContactInformation] PRIMARY KEY CLUSTERED ([Id] ASC)
);

