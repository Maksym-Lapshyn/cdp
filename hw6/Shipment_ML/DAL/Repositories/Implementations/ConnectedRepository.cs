using Core.Entities;
using DAL.Mappers.Implementations;
using DAL.Mappers.Interfaces;
using DAL.Repositories.Interfaces;
using DAL.SqlExpressionProviders.Implementations;
using DAL.SqlExpressionProviders.Interfaces;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace DAL.Repositories.Implementations
{
	public class ConnectedRepository<TEntity> : IRepository<TEntity> where TEntity : BaseEntity
    {
        private readonly SqlConnection _connection;
	    private readonly SqlTransaction _transaction;
        private readonly IDataMapper<TEntity> _dataMapper;
        private readonly ISqlExpressionProvider _expressionProvider;

        private readonly string _tableName;

        public ConnectedRepository(SqlConnection connection, SqlTransaction transaction)
        {
	        _connection = connection;
	        _transaction = transaction;
            _dataMapper = new DataMapper<TEntity>();
            _expressionProvider = new SqlExpressionProvider();
            _tableName = typeof(TEntity).Name;
        }

        public TEntity Create(TEntity entity)
        {
			var properties = _dataMapper.MapToProperties(entity);
	        var expression = _expressionProvider.ProvideCreateExpressionWithSetIdentity(_tableName, properties);

	        var command = new SqlCommand(expression, _connection)
	        {
		        Transaction = _transaction
	        };

	        var idParameter = new SqlParameter
	        {
		        ParameterName = "@id",
		        SqlDbType = SqlDbType.Int,
		        Direction = ParameterDirection.Output
	        };

	        command.Parameters.Add(idParameter);
			command.ExecuteNonQuery();

	        expression = _expressionProvider.ProvideReadOneExpression(_tableName, idParameter.Value);

	        command = new SqlCommand(expression, _connection)
	        {
		        Transaction = _transaction
	        };

	        var reader = command.ExecuteReader();
	        entity = _dataMapper.MapToEntity(reader);

	        reader.Close();

			return entity;
        }

        public void Delete(int id)
        {
            var expression = _expressionProvider.ProvideDeleteExpression(_tableName, id);

	        var command = new SqlCommand(expression, _connection)
	        {
		        Transaction = _transaction
	        };

            command.ExecuteNonQuery();
        }

        public IEnumerable<TEntity> ReadAll()
        {
            var expression = _expressionProvider.ProvideReadAllExpression(_tableName);

	        var command = new SqlCommand(expression, _connection)
	        {
		        Transaction = _transaction
	        };

            var reader = command.ExecuteReader();
            var entities = _dataMapper.MapToEntityList(reader);

            reader.Close();

            return entities;
        }

        public TEntity ReadOne(int id)
        {
            var expression = _expressionProvider.ProvideReadOneExpression(_tableName, id);

	        var command = new SqlCommand(expression, _connection)
	        {
		        Transaction = _transaction
	        };

            var reader = command.ExecuteReader();
            var entity = _dataMapper.MapToEntity(reader);

            reader.Close();

            return entity;
        }

        public void Update(TEntity entity)
        {
            var properties = _dataMapper.MapToProperties(entity);
            var expression = _expressionProvider.ProvideUpdateExpression(_tableName, entity.Id, properties);

	        var command = new SqlCommand(expression, _connection)
	        {
		        Transaction = _transaction
	        };

            command.ExecuteNonQuery();
        }
    }
}
