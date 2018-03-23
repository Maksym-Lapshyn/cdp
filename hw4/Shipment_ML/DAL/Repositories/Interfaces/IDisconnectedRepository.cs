using Core.Entities;
using System.Collections.Generic;

namespace DAL.Repositories.Interfaces
{
	public interface IDisconnectedRepository<TEntity> where TEntity : BaseEntity
	{
		void Create(TEntity entity);

		TEntity ReadOne(int id);

		IEnumerable<TEntity> ReadAll();

		void Update(TEntity entity);

		void Delete(int id);
	}
}
