using Core.Entities;
using DAL.Mappers.Interfaces;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace DAL.Mappers.Implementations
{
	public class DataMapper<TEntity> : IDataMapper<TEntity> where TEntity : BaseEntity
    {
        private readonly Type _entityType;

        public DataMapper()
        {
            _entityType = typeof(TEntity);
        }

        public TEntity MapToEntity(SqlDataReader reader)
        {
            CheckIfReaderHasRows(reader);

            reader.Read();

            var fieldCount = reader.FieldCount;
            var entity = Activator.CreateInstance(_entityType);

            for (var i = 0; i < fieldCount; i++)
            {
                var propertyInfo = _entityType.GetProperty(reader.GetName(i));

                propertyInfo.SetValue(entity, reader.GetValue(i));
            }

            return entity as TEntity;
        }

        public IEnumerable<TEntity> MapToEntityList(SqlDataReader reader)
        {
            CheckIfReaderHasRows(reader);

            var entities = new List<TEntity>();
            var fieldCount = reader.FieldCount;

            while (reader.Read())
            {
                var entity = Activator.CreateInstance(_entityType) as TEntity;

                for (var i = 0; i < fieldCount; i++)
                {
                    var propertyInfo = _entityType.GetProperty(reader.GetName(i));

                    propertyInfo.SetValue(entity, reader.GetValue(i));
                }

                entities.Add(entity);
            }

            return entities;
        }

        public Dictionary<string, object> MapToProperties(TEntity entity)
        {
            var properties = _entityType.GetProperties();

            var propertyDict = new Dictionary<string, object>(0);

            foreach (var p in properties)
            {
	            propertyDict.Add(p.Name, p.GetValue(entity));
            }

            return propertyDict;
        }

        private void CheckIfReaderHasRows(SqlDataReader reader)
        {
            if (!reader.HasRows)
            {
                throw new InvalidOperationException("Specified table does not contain entries");
            }
        }
    }
}
