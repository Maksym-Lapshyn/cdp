namespace DAL.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class WarehouseUpdate : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Warehouse", "Address", c => c.String(maxLength: 100));
        }
        
        public override void Down()
        {
            DropColumn("dbo.Warehouse", "Address");
        }
    }
}
