using Core.Entities;
using DAL.Context;
using DAL.UnitOfWork.Implementation;

namespace EntryPoint
{
    class Program
    {
        static void Main(string[] args)
        {
            var uow = new DisconnectedUnitOfWork();
            uow.LoadEntities();
            var entity = uow.WarehouseRepository.ReadOne(18);
            var entities = uow.WarehouseRepository.ReadAll();
            var newEntity = new Warehouse()
            {
                City = "Batman",
                State = "Bin Superman"
            };
            uow.WarehouseRepository.Create(newEntity);
            uow.SaveChanges();
        }
	}
}
