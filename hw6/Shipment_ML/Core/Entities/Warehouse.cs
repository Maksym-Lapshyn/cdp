using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Core.Entities
{
    [Table("Warehouse")]
    public class Warehouse : BaseEntity
    {
        [Required]
        [StringLength(50)]
        public string City { get; set; }

        [Required]
        [StringLength(50)]
        public string State { get; set; }

        [Timestamp]
        public byte[] RowVersion { get; set; }
    }
}
