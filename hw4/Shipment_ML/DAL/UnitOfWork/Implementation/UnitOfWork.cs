using Core.Entities;
using DAL.Repositories.Implementations;
using DAL.Repositories.Interfaces;
using DAL.UnitOfWork.Interfaces;
using System;
using System.Data.SqlClient;

namespace DAL.UnitOfWork.Implementation
{
	public class UnitOfWork : IUnitOfWork
	{
		private readonly SqlConnection _connection;
		private readonly Lazy<IRepository<Route>> _lazyRouteRepository;
		private readonly Lazy<IRepository<Warehouse>> _lazyWarehouseRepository;

		private SqlTransaction _transaction;

		public UnitOfWork()
		{
			var connectionString = "Data Source=.;Integrated Security=True;Initial Catalog=Shipment_ML;";
			_connection = new SqlConnection(connectionString);
			_lazyWarehouseRepository = new Lazy<IRepository<Warehouse>>(() => new ConnectedRepository<Warehouse>(_connection));
			_lazyRouteRepository = new Lazy<IRepository<Route>>(() => new ConnectedRepository<Route>(_connection));
		}

		public IRepository<Route> RouteRepository => _lazyRouteRepository.Value;

		public IRepository<Warehouse> WarehouseRepository => _lazyWarehouseRepository.Value;

		public void BeginTransaction()
		{
			_transaction = _connection.BeginTransaction();
		}

		public void CommitTransaction()
		{
			_transaction.Commit();
		}

		public void RollbackTransaction()
		{
			_transaction.Rollback();
		}

		public void Dispose()
		{
			_connection?.Dispose();
			_transaction?.Dispose();
		}
	}
}
