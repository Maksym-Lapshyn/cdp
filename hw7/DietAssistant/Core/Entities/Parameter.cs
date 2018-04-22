using System.Collections.Generic;

namespace Core.Entities
{
    public class Parameter : BaseEntity
    {
        public string Name { get; set; }

        public virtual Dish Dish { get; set; }

        public virtual ICollection<Preference> Preferences { get; set; }
    }
}
