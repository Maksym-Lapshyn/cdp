using System.Data;
using DAL.Context;
using DAL.Repositories.Implementations;
using DAL.UnitOfWork.Implementation;

namespace EntryPoint
{
    class Program
    {
        static void Main(string[] args)
        {
	        var uow = new UnitOfWork();
			uow.BeginTransaction(IsolationLevel.ReadUncommitted);
	        var route = uow.RouteRepository.ReadOne(10);
			uow.CommitTransaction();
        }
	}
}
