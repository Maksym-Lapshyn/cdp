using System.Data;

namespace DAL.UnitOfWork.Interfaces
{
    public interface ITransactionalUnitOfWork
    {
        void BeginTransaction(IsolationLevel isolationLevel);

        void CommitTransaction();

        void RollbackTransaction();
    }
}
