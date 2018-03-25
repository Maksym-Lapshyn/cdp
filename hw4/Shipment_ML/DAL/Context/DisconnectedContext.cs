using DAL.DataPopulators.Implementations;
using DAL.DataPopulators.Interfaces;
using DAL.SqlExpressionProviders.Implementations;
using DAL.SqlExpressionProviders.Interfaces;
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
        private readonly ISqlExpressionProvider _sqlExpressionProvider;
        private readonly string[] _tableNames;

		public DisconnectedContext(string connectionString, string[] tableNames)
		{
			_connection = new SqlConnection(connectionString);
			_dataAdapter = new SqlDataAdapter();
            _dataSetPopulator = new DataSetPopulator();
            _sqlExpressionProvider = new SqlExpressionProvider();
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

            var transaction = _connection.BeginTransaction();

            try
            {
                foreach (var tableName in _tableNames)
                {
                    var selectExpression = _sqlExpressionProvider.ProvideReadAllExpression(tableName);
                    var selectCommand = new SqlCommand(selectExpression, _connection, transaction);
                    var dataAdapter = new SqlDataAdapter(selectCommand);
                    var builder = new SqlCommandBuilder(dataAdapter);

                    dataAdapter.Update(_dataSet, tableName);
                }

                transaction.Commit();
            }
            catch(Exception e)
            {
                transaction.Rollback();   
            }
            finally
            {
                _connection.Close();
            }
		}
	}
}
