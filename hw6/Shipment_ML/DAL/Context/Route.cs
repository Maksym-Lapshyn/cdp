using Core.Entities;
using System.ComponentModel.DataAnnotations.Schema;

namespace DAL.Context
{
	[Table("Route")]
    public class Route : BaseEntity
    {
        public int? OriginId { get; set; }

        public int? DestinationId { get; set; }

        public int Distance { get; set; }

        public virtual Warehouse Warehouse { get; set; }
    }
}
