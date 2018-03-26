using System;
using System.Data;
using System.Data.SqlClient;
using Xunit;

namespace Tests.DAL
{
	public class UnitOfWorkTests : IDisposable
	{
		private readonly SqlConnection _connection;
		private readonly SqlCommand _getWarehouseCountCommand;
		private readonly SqlCommand _getRouteCountCommand;

		public UnitOfWorkTests()
		{
			_connection = new SqlConnection("Data Source=.;Integrated Security=True;Initial Catalog=Shipment_ML;");
			_getWarehouseCountCommand = GetSqlCommand("[dbo].[Warehouse]");
			_getRouteCountCommand = GetSqlCommand("[dbo].[Route]");
			
			_connection.Open();

			var warehouseCount = _getWarehouseCountCommand.ExecuteScalar();
			var routeCount = _getRouteCountCommand.ExecuteScalar();

			_connection.Close();
		}

		public void Dispose()
		{
			_connection.Open();

			var warehouseCount = _getWarehouseCountCommand.ExecuteScalar();
			var routeCount = _getRouteCountCommand.ExecuteScalar();

			_connection.Close();
			_connection.Dispose();
		}

		[Fact]
		public void TestSomething()
		{

		}

		private SqlCommand GetSqlCommand(string tableName)
		{
			var command = new SqlCommand("GetRowCount", _connection)
			{
				CommandType = CommandType.StoredProcedure,

				Parameters =
				{
					new SqlParameter("@tableName", SqlDbType.NVarChar)
					{
						Value = tableName
					}
				}
			};

			return command;
		}
	}
}
