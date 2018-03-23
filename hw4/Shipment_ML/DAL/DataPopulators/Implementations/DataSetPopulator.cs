using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL.DataPopulators.Interfaces;
using DAL.SqlExpressionProviders.Implementations;
using DAL.SqlExpressionProviders.Interfaces;

namespace DAL.DataPopulators.Implementations
{
	public class DataSetPopulator : IDataSetPopulator
	{
		private readonly ISqlExpressionProvider _expressionProvider;

		public DataSetPopulator()
		{
			_expressionProvider = new SqlExpressionProvider();
		}

		public void PopulateDataSet(DataSet dataSet, SqlDataAdapter dataAdapter, string[] tableNames)
		{
			throw new NotImplementedException();
		}
	}
}
