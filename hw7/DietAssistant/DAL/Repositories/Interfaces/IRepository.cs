using Core.Entities;
using System.Collections.Generic;

namespace DAL.Repositories.Interfaces
{
    public interface IRepository<TEntity> where TEntity : BaseEntity
    {
        TEntity Create(TEntity entity);

        TEntity Read(int id);

        IEnumerable<TEntity> ReadAll();

        void Update(TEntity entity);

        void Delete(int id);
    }
}
