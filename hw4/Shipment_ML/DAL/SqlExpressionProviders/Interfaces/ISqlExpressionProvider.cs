using System.Collections.Generic;

namespace DAL.SqlExpressionProviders.Interfaces
{
    public interface ISqlExpressionProvider
    {
        string ProvideCreateExpression(string tableName, Dictionary<string, object> properties);

        string ProvideReadOneExpression(string tableName, object id);

        string ProvideReadAllExpression(string tableName);

        string ProvideUpdateExpression(string tableName, object id, Dictionary<string, object> properties);

        string ProvideDeleteExpression(string tableName, object id);

        string ProvideFilteringExpression(object id);
    }
}
