using Core.Entities;
using Core.Exceptions;
using DAL.Repositories.Interfaces;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;

namespace DAL.Repositories.Implementations
{
    public class Repository<TEntity> : IRepository<TEntity> where TEntity : BaseEntity
    {
        private readonly DbContext _context;

        public Repository(DbContext context)
        {
            _context = context;
        }

        public TEntity Create(TEntity newEntity)
        {
            newEntity = _context.Set<TEntity>().Add(newEntity);

            return newEntity;
        }

        public TEntity Read(int id)
        {
            var entity = _context.Set<TEntity>().Find(id);

            return entity;
        }

        public IEnumerable<TEntity> ReadAll()
        {
            var entities = _context.Set<TEntity>().ToList();

            return entities;
        }

        public void Update(TEntity entity)
        {
            var existingEntity = _context.Set<TEntity>().Find(entity.Id);

            if (existingEntity == null)
            {
                throw new NotFoundException("Entity with such Id does not exist in the database.");
            }

            _context.Entry(entity).State = EntityState.Modified;
        }

        public void Delete(int id)
        {
            var existingEntity = _context.Set<TEntity>().Find(id);

            if (existingEntity == null)
            {
                throw new NotFoundException("Entity with such Id does not exist in the database.");
            }

            _context.Set<TEntity>().Remove(existingEntity);
        }
    }
}
