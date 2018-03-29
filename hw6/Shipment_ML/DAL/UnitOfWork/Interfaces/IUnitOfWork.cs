using Core.Entities;
using DAL.Repositories.Interfaces;
using System.Data;

namespace DAL.UnitOfWork.Interfaces
{
	public interface IUnitOfWork
	{
		IRepository<Route> RouteRepository { get; }

		IRepository<Warehouse> WarehouseRepository { get; }

		void BeginTransaction(IsolationLevel isolationLevel);

		void CommitTransaction();

		void RollbackTransaction();
	}
}
