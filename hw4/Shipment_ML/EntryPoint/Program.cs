using Core.Entities;
using DAL.UnitOfWork.Implementation;

namespace EntryPoint
{
	class Program
    {
        static void Main(string[] args)
        {
	        var uow = new UnitOfWork();

			uow.BeginTransaction();

	        var warehouse = new Warehouse
	        {
		        City = "Utah",
				State = "Jazz"
	        };

	        warehouse = uow.WarehouseRepository.Create(warehouse);

			uow.CommitTransaction();
        }
	}
}
