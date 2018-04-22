using System.Collections.Generic;

namespace Core.Entities
{
    public class Dish : BaseEntity
    {
        public string Name { get; set; }

        public virtual ICollection<Parameter> Parameters { get; set; }
    }
}
