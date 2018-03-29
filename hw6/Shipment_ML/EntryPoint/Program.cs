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
	        var route = new Route
	        {
		        DestinationId = 1,
		        Distance = 1,
		        OriginId = 1,
				Id = 20
	        };

	        uow.RouteRepository.Update(route);
        }
	}
}
