using System.Collections.Generic;

namespace DAL.SqlExpressionProviders.Interfaces
{
    public interface ISqlExpressionProvider
    {
        string ProvideCreateExpression(string tableName);

        string ProvideReadOneExpression(string tableName, object id);

        string ProvideReadAllExpression(string tableName);

        string ProvideUpdateExpression(string tableName, object id, Dictionary<string, object> properties);

        string ProvideDeleteAllExpression(string tableName, object id);
    }
}
