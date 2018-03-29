using DAL.SqlExpressionProviders.Interfaces;
using System.Collections.Generic;
using System.Text;

namespace DAL.SqlExpressionProviders.Implementations
{
	public class SqlExpressionProvider : ISqlExpressionProvider
    {
        public string ProvideCreateExpressionWithSetIdentity(string tableName, Dictionary<string, object> properties)
        {
	        var sb = ProvideCreateExpression(tableName, properties);

	        sb.Append("SET @id=SCOPE_IDENTITY();");

	        var expression = sb.ToString();

	        return expression;
        }

	    public string ProvideCreateExpressionWithSelectIdentity(string tableName, Dictionary<string, object> properties)
	    {
		    var sb = ProvideCreateExpression(tableName, properties);

			sb.Append("SELECT CAST(SCOPE_IDENTITY() as INT);");

		    var expression = sb.ToString();

		    return expression;
		}

	    public string ProvideDeleteExpression(string tableName, object id)
        {
            var expression = $"DELETE FROM [dbo].[{tableName}] WHERE [Id] = {id};";

            return expression;
        }

        public string ProvideReadAllExpression(string tableName)
        {
            var expression = $"SELECT * FROM [dbo].[{tableName}];";

            return expression;
        }

        public string ProvideReadOneExpression(string tableName, object id)
        {
            var expression = $"SELECT * FROM [dbo].[{tableName}] WHERE [Id] = {id};";

            return expression;
        }

        public string ProvideUpdateExpression(string tableName, object id, Dictionary<string, object> properties)
        {
            var sb = new StringBuilder();

            sb.Append($"UPDATE [dbo].[{tableName}] SET ");

            foreach (var property in properties)
            {
                if (property.Key == "Id")
                {
                    continue;
                }

                sb.Append($"[{property.Key}] = '{property.Value}', ");
            }

            sb.Remove(sb.Length - 2, 2);
            sb.Append($"WHERE [Id] = {id};");

            var expression = sb.ToString();

            return expression;
        }

        public string ProvideFilteringExpression(object id)
        {
            var expression = $"Id = {id}";

            return expression;
        }

	    private StringBuilder ProvideCreateExpression(string tableName, Dictionary<string, object> properties)
	    {
			var sb = new StringBuilder();
		    sb.Append($"INSERT INTO [dbo].[{tableName}] (");

		    foreach (var property in properties)
		    {
			    if (property.Key == "Id")
			    {
				    continue;
			    }

			    sb.Append($"[{property.Key}], ");
		    }

		    sb.Remove(sb.Length - 2, 2);
		    sb.Append(") VALUES (");

		    foreach (var property in properties)
		    {
			    if (property.Key == "Id")
			    {
				    continue;
			    }

			    sb.Append($"'{property.Value}', ");
		    }

		    sb.Remove(sb.Length - 2, 2);
		    sb.Append(");");

		    return sb;
	    }
    }
}
