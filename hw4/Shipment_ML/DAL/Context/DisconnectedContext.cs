using System.Data;
using System.Data.SqlClient;

namespace DAL.Context
{
	public class DisconnectedContext
	{
		private readonly DataSet _dataSet;
		private readonly SqlDataAdapter _dataAdapter;
		private readonly SqlConnection _connection;

		public DisconnectedContext(string connectionString)
		{
			_connection = new SqlConnection(connectionString);
			_dataAdapter = new SqlDataAdapter();

			var command = new SqlCommand
			{
				CommandText = "SELECT * FROM [dbo].[Route]; SELECT * FROM [dbo].[Warehouse];",
				Connection = new SqlConnection(connectionString)
			};

			_dataSet = new DataSet();
			_dataAdapter.SelectCommand = command;
			_connection.Open();
			_dataAdapter.Fill(_dataSet);
			_connection.Close();
		}

		public DataSet DataSet => _dataSet;

		public void SaveChanges()
		{
			_connection.Open();
			_dataAdapter.Update(_dataSet);
			_connection.Close();
		}
	}
}
