using Core.Entities;
using System.Data.Entity;

namespace DAL.Context
{
    public class EfContext : DbContext
	{
		public EfContext(string connectionstring)
			: base(connectionstring)
		{
		}

		public virtual DbSet<Route> Routes { get; set; }
		public virtual DbSet<Warehouse> Warehouses { get; set; }
	}
}
