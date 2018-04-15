using System;
using System.Data.Entity.Infrastructure;

namespace DAL.DatabaseConfiguration
{
    public class TestExecutionStrategy : DbExecutionStrategy
    {
        protected override bool ShouldRetryOn(Exception exception)
        {
            var exceptionIsTransient = exception.GetType() == typeof(TestTransientException);

            return exceptionIsTransient;
        }
    }
}
