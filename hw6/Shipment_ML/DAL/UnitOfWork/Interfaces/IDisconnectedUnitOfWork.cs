namespace DAL.UnitOfWork.Interfaces
{
    public interface IDisconnectedUnitOfWork
	{
        void LoadEntities();

		void SaveChanges();
	}
}
