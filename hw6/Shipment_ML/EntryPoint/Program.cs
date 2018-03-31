using DAL.UnitOfWork.Implementation;
using System.Data;

namespace EntryPoint
{
    class Program
    {
        static void Main(string[] args)
        {
	        var uow = new EfUnitOfWork();
	        var route = uow.RouteRepository.ReadOne(10);
        }
	}
}
