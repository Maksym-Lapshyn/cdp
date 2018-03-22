using Core.Entities;
using DAL.Repositories.Interfaces;
using System;
using System.Collections.Generic;

namespace DAL.Repositories.Implementations
{
	public class DisconnectedRepository<TEntity> : IRepository<TEntity> where TEntity : BaseEntity
	{
		public TEntity Create(TEntity entity)
		{
			throw new NotImplementedException();
		}

		public TEntity ReadOne(int id)
		{
			throw new NotImplementedException();
		}

		public IEnumerable<TEntity> ReadAll()
		{
			throw new NotImplementedException();
		}

		public void Update(TEntity entity)
		{
			throw new NotImplementedException();
		}

		public void Delete(int id)
		{
			throw new NotImplementedException();
		}
	}
}
