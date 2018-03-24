using DAL.DataPopulators.Implementations;
using DAL.DataPopulators.Interfaces;
using System.Data;
using System.Data.SqlClient;

namespace DAL.Context
{
    public class DisconnectedContext
	{
		private readonly DataSet _dataSet;
		private readonly SqlDataAdapter _dataAdapter;
		private readonly SqlConnection _connection;
        private readonly IDataSetPopulator _dataSetPopulator;

		public DisconnectedContext(string connectionString, string[] tableNames)
		{
			_connection = new SqlConnection(connectionString);
			_dataAdapter = new SqlDataAdapter();
            _dataSetPopulator = new DataSetPopulator();

			_dataSet = new DataSet();
			_connection.Open();
            _dataSetPopulator.PopulateDataSet(_dataSet, _dataAdapter, _connection, tableNames);
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
