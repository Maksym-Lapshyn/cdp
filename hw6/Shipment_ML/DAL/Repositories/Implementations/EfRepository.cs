using Core.Entities;
using DAL.Context;
using DAL.Repositories.Interfaces;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;

namespace DAL.Repositories.Implementations
{
	public class EfRepository<TEntity> : IRepository<TEntity> where TEntity: BaseEntity
	{
		private readonly DbContext _context;

		public EfRepository()
		{
			_context = new EfContext();
		}

		public TEntity Create(TEntity entity)
		{
			_context.Set<TEntity>().Add(entity);

			return entity;
		}

		public TEntity ReadOne(int id)
		{
			var entity = _context.Set<TEntity>().FirstOrDefault(e => e.Id == id);

			return entity;
		}

		public IEnumerable<TEntity> ReadAll()
		{
			var entities = _context.Set<TEntity>().ToList();

			return entities;
		}

		public void Update(TEntity entity)
		{
			_context.Entry(entity).State = EntityState.Modified;
		}

		public void Delete(int id)
		{
			var entity = _context.Set<TEntity>().Find(id);
			_context.Entry(entity).State = EntityState.Deleted;
		}
	}
}
