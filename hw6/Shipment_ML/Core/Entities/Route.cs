using System.ComponentModel.DataAnnotations.Schema;

namespace Core.Entities
{
	[Table("Route")]
    public class Route : BaseEntity
    {
        public int? OriginId { get; set; }

        public int? DestinationId { get; set; }

        public int Distance { get; set; }
    }
}
