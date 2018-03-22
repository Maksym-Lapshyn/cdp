using Core.Entities;
using DAL.Repositories.Interfaces;

namespace DAL.UnitOfWork.Interfaces
{
	public interface IUnitOfWork
	{
		IRepository<Route> RouteRepository { get; }

		IRepository<Warehouse> WarehouseRepository { get }

		void BeginTransaction();

		void CommitTransaction();

		void RollbackTransaction();
	}
}
