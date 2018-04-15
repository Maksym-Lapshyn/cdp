using System.Data.Entity;
using System.Data.Entity.Infrastructure.Interception;

namespace DAL.DatabaseConfiguration
{
    public class TestConfiguration : DbConfiguration
    {
        private const string SqlProviderName = "System.Data.SqlClient";

        public TestConfiguration()
        {
            DbInterception.Add(new TestCommandInterceptor());
            SetExecutionStrategy(SqlProviderName, () => new TestExecutionStrategy());
        }
    }
}
