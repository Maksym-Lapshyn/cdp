using System.Data;
using System.Data.SqlClient;

namespace DAL.DataPopulators.Interfaces
{
	public interface IDataSetPopulator
	{
		void PopulateDataSet(DataSet dataSet, SqlDataAdapter dataAdapter, SqlConnection connection, string[] tableNames);
	}
}
