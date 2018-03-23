using Core.Entities;
using DAL.Context;
using DAL.Mappers.Implementations;
using DAL.Mappers.Interfaces;
using DAL.Repositories.Interfaces;
using DAL.SqlExpressionProviders.Implementations;
using DAL.SqlExpressionProviders.Interfaces;
using System;
using System.Collections.Generic;

namespace DAL.Repositories.Implementations
{
	public class DisconnectedRepository<TEntity> : IDisconnectedRepository<TEntity> where TEntity : BaseEntity
	{
		private readonly DisconnectedContext _context;
		private readonly IDataMapper<TEntity> _dataMapper;
		private readonly ISqlExpressionProvider _expressionProvider;

		private readonly string _tableName;

		public DisconnectedRepository(DisconnectedContext context)
		{
			_context = context;
			_dataMapper = new DataMapper<TEntity>();
			_expressionProvider = new SqlExpressionProvider();

			_tableName = typeof(TEntity).Name;
		}

		public void Create(TEntity entity)
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
