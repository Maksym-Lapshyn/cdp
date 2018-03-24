using Core.Entities;
using DAL.Context;
using DAL.Mappers.Implementations;
using DAL.Mappers.Interfaces;
using DAL.Repositories.Interfaces;
using DAL.SqlExpressionProviders.Implementations;
using DAL.SqlExpressionProviders.Interfaces;
using System;
using System.Collections.Generic;
using System.Data;

namespace DAL.Repositories.Implementations
{
    public class DisconnectedRepository<TEntity> : IDisconnectedRepository<TEntity> where TEntity : BaseEntity
	{
		private readonly DisconnectedContext _context;
        private readonly string _tableName;
        private readonly DataTable _table;
        private readonly IDataMapper<TEntity> _dataMapper;
		private readonly ISqlExpressionProvider _expressionProvider;

		public DisconnectedRepository(DisconnectedContext context)
		{
			_context = context;
            _tableName = typeof(TEntity).Name;
            _table = _context.DataSet.Tables[_tableName];
            _dataMapper = new DataMapper<TEntity>();
			_expressionProvider = new SqlExpressionProvider();
		}

		public void Create(TEntity entity)
		{
			throw new NotImplementedException();
		}

		public TEntity ReadOne(int id)
		{
            var whereExpression = _expressionProvider.ProvideFilteringExpression(id);
            var rows = _table.Select(whereExpression);
            DataRow row = default(DataRow);

            foreach (var r in rows)
            {
                if (r.Field<int>("Id") == id)
                {
                    row = r;
                    break;
                }
            }

            var entity = _dataMapper.MapToEntity(row);

            return entity;
		}

		public IEnumerable<TEntity> ReadAll()
		{
            var rows = _table.Select();
            var entities = _dataMapper.MapToEntityList(rows);

            return entities;
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
