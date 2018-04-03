using Core.Entities;
using DAL.Context;
using DAL.Repositories.Implementations;
using DAL.Repositories.Interfaces;
using DAL.UnitOfWork.Interfaces;
using System;

namespace DAL.UnitOfWork.Implementation
{
    public class DisconnectedUnitOfWork : IRepositoryWrapper, IDisconnectedUnitOfWork, IDisposable
	{
		private readonly DisconnectedContext _context;
		private readonly Lazy<IRepository<Route>> _lazyRouteRepository;
		private readonly Lazy<IRepository<Warehouse>> _lazyWarehouseRepository;

		public DisconnectedUnitOfWork()
		{
            var tableNames = new string[] { "Route", "Warehouse" };
            var connectionString = "Data Source=.;Integrated Security=True;Initial Catalog=Shipment_ML;";
			_context = new DisconnectedContext(connectionString, tableNames);

			_lazyWarehouseRepository = new Lazy<IRepository<Warehouse>>(() => new DisconnectedRepository<Warehouse>(_context));
			_lazyRouteRepository = new Lazy<IRepository<Route>>(() => new DisconnectedRepository<Route>(_context));
		}

		public IRepository<Route> RouteRepository => _lazyRouteRepository.Value;
		public IRepository<Warehouse> WarehouseRepository => _lazyWarehouseRepository.Value;

        public void Dispose()
        {
            _context.Dispose();
        }

        public void LoadEntities()
        {
            _context.LoadContext();
        }

		public void SaveChanges()
		{
			_context.SaveChanges();
		}
	}
}
