using Core.Entities;
using DAL.Context;
using DAL.Mappers.Implementations;
using DAL.Mappers.Interfaces;
using DAL.Repositories.Interfaces;
using DAL.SqlExpressionProviders.Implementations;
using DAL.SqlExpressionProviders.Interfaces;
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
            var row = _table.NewRow();
            row = _dataMapper.MapToDataRow(entity, row);

            _table.Rows.Add(row);
		}

		public TEntity ReadOne(int id)
		{
            var row = GetDataRowById(id);
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
            var row = GetDataRowById(entity.Id);
            row = _dataMapper.MapToDataRow(entity, row);
        }

		public void Delete(int id)
		{
            var row = GetDataRowById(id);

            _table.Rows.Remove(row);
		}

        private DataRow GetDataRowById(int id)
        {
            var whereExpression = _expressionProvider.ProvideFilteringExpression(id);
            var rows = _table.Select(whereExpression);
            var row = default(DataRow);

            foreach (var r in rows)
            {
                if (r.Field<int>("Id") == id)
                {
                    row = r;
                    break;
                }
            }

            return row;
        }
	}
}
