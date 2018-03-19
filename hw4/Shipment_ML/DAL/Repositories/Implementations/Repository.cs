using Core.Entities;
using DAL.Mappers.Implementations;
using DAL.Mappers.Interfaces;
using DAL.Repositories.Interfaces;
using DAL.SqlExpressionProviders.Implementations;
using DAL.SqlExpressionProviders.Interfaces;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace DAL.Repositories.Implementations
{
    public class Repository<TEntity> : IRepository<TEntity> where TEntity : BaseEntity
    {
        private readonly SqlConnection _connection;
        private readonly IDataMapper<TEntity> _dataMapper;
        private readonly ISqlExpressionProvider _expressionProvider;

        private readonly Type _entityType;
        private readonly string _tableName;

        public Repository()
        {
            var connectionString = "Data Source=.;Integrated Security=True;Initial Catalog=Shipment_ML;";
            _connection = new SqlConnection(connectionString);
            _connection.Open();
            _dataMapper = new DataMapper<TEntity>();
            _expressionProvider = new SqlExpressionProvider();

            _entityType = typeof(TEntity);
            _tableName = _entityType.Name;
        }

        public TEntity Create(TEntity entity)
        {
			var properties = _dataMapper.MapToProperties(entity);
	        var expression = _expressionProvider.ProvideCreateExpression(_tableName, properties);
	        var command = new SqlCommand(expression, _connection);

	        var idParameter = new SqlParameter
	        {
		        ParameterName = "@id",
		        SqlDbType = SqlDbType.Int,
		        Direction = ParameterDirection.Output
	        };

	        command.Parameters.Add(idParameter);
			command.ExecuteNonQuery();

	        expression = _expressionProvider.ProvideReadOneExpression(_tableName, idParameter.Value);
	        command = new SqlCommand(expression, _connection);
	        var reader = command.ExecuteReader();
	        entity = _dataMapper.MapToEntity(reader);

	        reader.Close();
	        _connection.Close();

			return entity;
        }

        public void Delete(int id)
        {
            var expression = _expressionProvider.ProvideDeleteExpression(_tableName, id);
            var command = new SqlCommand(expression, _connection);
            command.ExecuteNonQuery();

            _connection.Close();
        }

        public IEnumerable<TEntity> ReadAll()
        {
            var expression = _expressionProvider.ProvideReadAllExpression(_tableName);
            var command = new SqlCommand(expression, _connection);
            var reader = command.ExecuteReader();
            var entities = _dataMapper.MapToEntityList(reader);

            reader.Close();
            _connection.Close();

            return entities;
        }

        public TEntity ReadOne(int id)
        {
            var expression = _expressionProvider.ProvideReadOneExpression(_tableName, id);
            var command = new SqlCommand(expression, _connection);
            var reader = command.ExecuteReader();
            var entity = _dataMapper.MapToEntity(reader);

            reader.Close();
            _connection.Close();

            return entity;
        }

        public void Update(TEntity entity)
        {
            var properties = _dataMapper.MapToProperties(entity);
            var expression = _expressionProvider.ProvideUpdateExpression(_tableName, entity.Id, properties);
            var command = new SqlCommand(expression, _connection);

            command.ExecuteNonQuery();

            _connection.Close();
        }
    }
}
