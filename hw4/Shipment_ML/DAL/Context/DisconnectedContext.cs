using DAL.DataPopulators.Implementations;
using DAL.DataPopulators.Interfaces;
using System;
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
        private readonly string[] _tableNames;

		public DisconnectedContext(string connectionString, string[] tableNames)
		{
			_connection = new SqlConnection(connectionString);
			_dataAdapter = new SqlDataAdapter();
            var commandBuilder = new SqlCommandBuilder(_dataAdapter);
            _dataSetPopulator = new DataSetPopulator();
			_dataSet = new DataSet();
            _tableNames = tableNames;
		}

		public DataSet DataSet => _dataSet;

        public void LoadContext()
        {
            _connection.Open();
            _dataSetPopulator.PopulateDataSet(_dataSet, _dataAdapter, _connection, _tableNames);
            _connection.Close();
        }

		public void SaveChanges()
		{
			_connection.Open();
			_dataAdapter.Update(_dataSet);
			_connection.Close();
		}
	}
}
