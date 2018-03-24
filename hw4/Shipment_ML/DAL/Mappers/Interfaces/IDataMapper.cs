using Core.Entities;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace DAL.Mappers.Interfaces
{
    public interface IDataMapper<TEntity> where TEntity : BaseEntity
    {
        TEntity MapToEntity(SqlDataReader reader);

        TEntity MapToEntity(DataRow row);

        IEnumerable<TEntity> MapToEntityList(SqlDataReader reader);

        IEnumerable<TEntity> MapToEntityList(DataRow[] rows);

        Dictionary<string, object> MapToProperties(TEntity entity);

        DataRow MapToDataRow(TEntity entity, DataRow row);
    }
}
