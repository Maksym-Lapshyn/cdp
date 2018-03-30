using System.Data.Entity;

namespace DAL.Context
{
	public class EfContext : DbContext
	{
		public EfContext()
			: base("name=EfShipmentConnection")
		{
		}

		public virtual DbSet<Route> Routes { get; set; }
		public virtual DbSet<Warehouse> Warehouses { get; set; }

		protected override void OnModelCreating(DbModelBuilder modelBuilder)
		{
			modelBuilder.Entity<Warehouse>()
				.HasMany(e => e.Routes)
				.WithOptional(e => e.Warehouse)
				.HasForeignKey(e => e.DestinationId);

			modelBuilder.Entity<Warehouse>()
				.HasMany(e => e.Routes1)
				.WithOptional(e => e.Warehouse1)
				.HasForeignKey(e => e.OriginId);
		}
	}
}
