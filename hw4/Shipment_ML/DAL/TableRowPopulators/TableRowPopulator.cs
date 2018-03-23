using System.Collections.Generic;
using System.Data;

namespace DAL.TableRowPopulators
{
	public class TableRowPopulator
	{
		public void PopulateRow(DataRow row, Dictionary<string, object> properties)
		{
			foreach (var property in properties)
			{
				row.SetField(property.Key, property.Value);
			}
		}
	}
}
