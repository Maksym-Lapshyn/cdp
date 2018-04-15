using System.Data.Common;
using System.Data.Entity.Infrastructure.Interception;

namespace DAL.DatabaseConfiguration
{
    public class TestCommandInterceptor : DbCommandInterceptor
    {
        private int _queryNumber;

        public TestCommandInterceptor()
        {
            _queryNumber = 0;
        }

        public override void ReaderExecuting(DbCommand command, DbCommandInterceptionContext<DbDataReader> interceptionContext)
        {
            var queryIsThird = _queryNumber == 3;

            if (queryIsThird)
            {
                interceptionContext.Exception = new TestTransientException();
            }

            _queryNumber++;

            base.ReaderExecuting(command, interceptionContext);
        }
    }
}
