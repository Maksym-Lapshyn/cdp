using Core.Entities;
using DAL.UnitOfWork.Implementation;
using System;
using System.Data;
using System.Data.SqlClient;
using Xunit;

namespace Tests.DAL
{
	public class UnitOfWorkTests : IDisposable
	{
		private const string ConnectionString = "Data Source=.;Integrated Security=True;Initial Catalog=Shipment_ML;";
		private const string WarehouseTableName = "[dbo].[Warehouse]";
		private const string RouteTableName = "[dbo].[Route]";

		private readonly SqlConnection _connection;
		private readonly SqlCommand _getWarehouseCountCommand;
		private readonly SqlCommand _getRouteCountCommand;

		public UnitOfWorkTests()
		{
			_connection = new SqlConnection(ConnectionString);
			_getWarehouseCountCommand = GetSqlCommand(WarehouseTableName);
			_getRouteCountCommand = GetSqlCommand(RouteTableName);
			
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
		public void Uow_CreatesAndReadsRoutesAndWarehouses()
		{
			var firstUow = new UnitOfWork();

			var origin = new Warehouse
			{
				City = "Gotham City",
				State = "New Jersey"
			};

			var destination = new Warehouse
			{
				City = "Metropolis",
				State = "New Jersey"
			};

			firstUow.BeginTransaction(IsolationLevel.ReadUncommitted);

			origin = firstUow.WarehouseRepository.Create(origin);
			destination = firstUow.WarehouseRepository.Create(destination);

			var route = new Route
			{
				OriginId = origin.Id,
				DestinationId = destination.Id,
				Distance = 1000
			};

			route = firstUow.RouteRepository.Create(route);
			var secondUow = new UnitOfWork();

			secondUow.BeginTransaction(IsolationLevel.ReadUncommitted);

			var routeFromDatabase = secondUow.RouteRepository.ReadOne(route.Id);

			Assert.Equal(route.Id, routeFromDatabase.Id);
			Assert.Equal(origin.Id, routeFromDatabase.OriginId);
			Assert.Equal(route.Distance, routeFromDatabase.Distance);
			Assert.Equal(destination.Id, routeFromDatabase.DestinationId);

			secondUow.RollbackTransaction();
			firstUow.RollbackTransaction();
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
