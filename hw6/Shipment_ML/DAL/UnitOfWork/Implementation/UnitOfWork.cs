using Core.Entities;
using DAL.Repositories.Implementations;
using DAL.Repositories.Interfaces;
using DAL.UnitOfWork.Interfaces;
using System;
using System.Data;
using System.Data.SqlClient;

namespace DAL.UnitOfWork.Implementation
{
	public class UnitOfWork : IRepositoryWrapper, ITransactionalUnitOfWork
	{
		private readonly SqlConnection _connection;
		private readonly Lazy<IRepository<Route>> _lazyRouteRepository;
		private readonly Lazy<IRepository<Warehouse>> _lazyWarehouseRepository;

		private SqlTransaction _transaction;

		public UnitOfWork()
		{
			var connectionString = "Data Source=.;Integrated Security=True;Initial Catalog=Shipment_ML;";
			_connection = new SqlConnection(connectionString);
			_lazyWarehouseRepository = new Lazy<IRepository<Warehouse>>(() => new ConnectedRepository<Warehouse>(_connection, _transaction));
			_lazyRouteRepository = new Lazy<IRepository<Route>>(() => new DapperRepository<Route>(_connection, _transaction));
		}

		public IRepository<Route> RouteRepository => _lazyRouteRepository.Value;
		public IRepository<Warehouse> WarehouseRepository => _lazyWarehouseRepository.Value;

		public void BeginTransaction(IsolationLevel isolationLevel)
		{
			_connection.Open();
			_transaction = _connection.BeginTransaction(isolationLevel);
		}

		public void CommitTransaction()
		{
			_transaction.Commit();
			_connection.Close();
		}

		public void RollbackTransaction()
		{
			_transaction.Rollback();
			_connection.Close();
		}
	}
}
