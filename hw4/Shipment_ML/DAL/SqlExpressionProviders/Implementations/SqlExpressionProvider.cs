using DAL.SqlExpressionProviders.Interfaces;
using System;
using System.Collections.Generic;
using System.Text;

namespace DAL.SqlExpressionProviders.Implementations
{
    public class SqlExpressionProvider : ISqlExpressionProvider
    {
        public string ProvideCreateExpression(string tableName)
        {
            throw new NotImplementedException();
        }

        public string ProvideDeleteAllExpression(string tableName, object id)
        {
            var expression = $"DELETE FROM FROM [dbo].[{tableName}] WHERE Id = {id};";

            return expression;
        }

        public string ProvideReadAllExpression(string tableName)
        {
            var expression = $"SELECT * FROM [dbo].[{tableName}];";

            return expression;
        }

        public string ProvideReadOneExpression(string tableName, object id)
        {
            var expression = $"SELECT * FROM [dbo].[{tableName}] WHERE Id = {id};";

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

                sb.Append($"{property.Key} = '{property.Value}', ");
            }

            sb.Remove(sb.Length - 2, 1);
            sb.Append($"WHERE Id = {id}");
            sb.Append(";");

            var expression = sb.ToString();

            return expression;
        }
    }
}
