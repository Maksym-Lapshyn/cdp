using DAL.DataPopulators.Interfaces;
using DAL.SqlExpressionProviders.Implementations;
using DAL.SqlExpressionProviders.Interfaces;
using System.Data;
using System.Data.SqlClient;

namespace DAL.DataPopulators.Implementations
{
    public class DataSetPopulator : IDataSetPopulator
	{
		private readonly ISqlExpressionProvider _expressionProvider;

		public DataSetPopulator()
		{
			_expressionProvider = new SqlExpressionProvider();
		}

		public void PopulateDataSet(DataSet dataSet, SqlDataAdapter dataAdapter, SqlConnection connection, string[] tableNames)
		{
            foreach (var tableName in tableNames)
            {
                var expression = _expressionProvider.ProvideReadAllExpression(tableName);

                var sqlCommand = new SqlCommand
                {
                    CommandText = expression,
                    Connection = connection
                };

                dataAdapter.SelectCommand = sqlCommand;

                dataAdapter.Fill(dataSet, tableName);
            }
        }
	}
}
