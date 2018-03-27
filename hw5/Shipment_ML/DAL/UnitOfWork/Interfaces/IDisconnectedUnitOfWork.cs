using Core.Entities;
using DAL.Repositories.Interfaces;

namespace DAL.UnitOfWork.Interfaces
{
    public interface IDisconnectedUnitOfWork
	{
		IDisconnectedRepository<Route> RouteRepository { get; }

		IDisconnectedRepository<Warehouse> WarehouseRepository { get; }

        void LoadEntities();

		void SaveChanges();
	}
}
