using System.Data.SqlClient;
using Core.Entities;
using DAL.Context;
using DAL.Repositories.Implementations;
using DAL.UnitOfWork.Implementation;

namespace EntryPoint
{
	class Program
    {
        static void Main(string[] args)
        {
	        var connectionString = "Data Source=.;Integrated Security=True;Initial Catalog=Shipment_ML;";
			var context = new DisconnectedContext(connectionString);
	        var tables = context.DataSet.Tables;
        }
	}
}
^