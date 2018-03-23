using System;
using System.Data;
using System.Data.SqlClient;
using Core.Entities;
using DAL.Context;
using DAL.Repositories.Implementations;
using DAL.Repositories.Interfaces;
using DAL.UnitOfWork.Interfaces;

namespace DAL.UnitOfWork.Implementation
{
	public class DisconnectedUnitOfWork : IDisconnectedUnitOfWork
	{
		private readonly DisconnectedContext _context;
		private readonly Lazy<IDisconnectedRepository<Route>> _lazyRouteRepository;
		private readonly Lazy<IDisconnectedRepository<Warehouse>> _lazyWarehouseRepository;

		public DisconnectedUnitOfWork()
		{
			var connectionString = "Data Source=.;Integrated Security=True;Initial Catalog=Shipment_ML;";
			_context = new DisconnectedContext(connectionString);

			_lazyWarehouseRepository = new Lazy<IDisconnectedRepository<Warehouse>>(() => new DisconnectedRepository<Warehouse>(_context));
			_lazyRouteRepository = new Lazy<IDisconnectedRepository<Route>>(() => new DisconnectedRepository<Route>(_context));
		}

		public IDisconnectedRepository<Route> RouteRepository => _lazyRouteRepository.Value;
		public IDisconnectedRepository<Warehouse> WarehouseRepository => _lazyWarehouseRepository.Value;

		public void SaveChanges()
		{
			_context.SaveChanges();
		}
	}
}
