using Core.Entities;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DAL.Context
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

        public virtual ICollection<Route> Routes { get; set; }
    }
}
