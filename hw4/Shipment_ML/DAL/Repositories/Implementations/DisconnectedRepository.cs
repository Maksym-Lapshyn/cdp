using Core.Entities;
using DAL.Repositories.Interfaces;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using DAL.Mappers.Implementations;
using DAL.Mappers.Interfaces;
using DAL.SqlExpressionProviders.Implementations;
using DAL.SqlExpressionProviders.Interfaces;

namespace DAL.Repositories.Implementations
{
	public class DisconnectedRepository<TEntity> : IRepository<TEntity> where TEntity : BaseEntity
	{
		private readonly SqlConnection _connection;
		private readonly IDataMapper<TEntity> _dataMapper;
		private readonly ISqlExpressionProvider _expressionProvider;

		private readonly string _tableName;

		public DisconnectedRepository(SqlConnection connection)
		{
			_connection = connection;
			_dataMapper = new DataMapper<TEntity>();
			_expressionProvider = new SqlExpressionProvider();

			_tableName = typeof(TEntity).Name;
		}

		public TEntity Create(TEntity entity)
		{
			var expression = _expressionProvider.ProvideReadAllExpression(_tableName);

			_connection.Open();

			var adapter = new SqlDataAdapter(expression, _connection);
			var dataSet = new DataSet();

			adapter.Fill(dataSet);

			var dataTable = dataSet.Tables[0];

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
