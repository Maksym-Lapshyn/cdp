using DAL.Context;
using DAL.UnitOfWork.Implementation;

namespace EntryPoint
{
    class Program
    {
        static void Main(string[] args)
        {
            var uow = new DisconnectedUnitOfWork();
            var entity = uow.WarehouseRepository.ReadOne(18);
            var entities = uow.WarehouseRepository.ReadAll();
        }
	}
}
