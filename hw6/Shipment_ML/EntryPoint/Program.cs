using Core.Entities;
using DAL.Context;
using DAL.UnitOfWork.Implementation;

namespace EntryPoint
{
    class Program
    {
        static void Main(string[] args)
        {
            var uow = new UnitOfWork();
	        var route = uow.RouteRepository.ReadOne(6);
        }
	}
}
