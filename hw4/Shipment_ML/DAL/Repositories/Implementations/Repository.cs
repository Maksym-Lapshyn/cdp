using Core.Entities;
using DAL.Mappers.Implementations;
using DAL.Mappers.Interfaces;
using DAL.Repositories.Interfaces;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Repositories.Implementations
{
    public class Repository<TEntity> : IRepository<TEntity> where TEntity : BaseEntity
    {
        private readonly SqlConnection _connection;
        private readonly IDataMapper<TEntity> _dataMapper;

        private readonly Type _entityType;
        private readonly string _tableName;

        public Repository()
        {
            var connectionString = "Data Source=.;Integrated Security=True;Initial Catalog=Shipment_ML;";
            _connection = new SqlConnection(connectionString);
            _connection.Open();
            _dataMapper = new DataMapper<TEntity>();

            _entityType = typeof(TEntity);
            _tableName = _entityType.Name;
        }

        public TEntity Create(TEntity entity)
        {
            throw new NotImplementedException();
        }

        public void Delete(int id)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<TEntity> ReadAll()
        {
            var expression = $"SELECT * FROM [dbo].[{_tableName}];";
            var command = new SqlCommand(expression, _connection);
            var reader = command.ExecuteReader();
            var entities = _dataMapper.MapToEntityList(reader);

            reader.Close();

            return entities;
        }

        public TEntity ReadOne(int id)
        {
            var expression = $"SELECT * FROM [dbo].[{_tableName}] WHERE Id = {id};";
            var command = new SqlCommand(expression, _connection);
            var reader = command.ExecuteReader();
            var entity = _dataMapper.MapToEntity(reader);

            reader.Close();

            return entity;
        }

        public void Update(TEntity entity)
        {
            var properties = _dataMapper.MapToProperties(entity);
            var sb = new StringBuilder();

            sb.Append($"UPDATE [dbo].[{_tableName}] SET ");
            
            foreach (var property in properties)
            {
                if (property.Key == "Id")
                {
                    continue;
                }

                sb.Append($"{property.Key} = {property.Value}, ");
            }

            sb.Remove(sb.Length - 2, 1);
            sb.Append($"WHERE Id = {entity.Id}");
            sb.Append(";");

            var expression = sb.ToString();
            var command = new SqlCommand(expression, _connection);
            command.ExecuteNonQuery();
        }
    }
}
