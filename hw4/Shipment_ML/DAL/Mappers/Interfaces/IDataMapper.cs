using Core.Entities;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace DAL.Mappers.Interfaces
{
    public interface IDataMapper<TEntity> where TEntity : BaseEntity
    {
        TEntity MapToEntity(SqlDataReader reader);

        IEnumerable<TEntity> MapToEntityList(SqlDataReader reader);

        Dictionary<string, object> MapToProperties(TEntity entity);
    }
}
