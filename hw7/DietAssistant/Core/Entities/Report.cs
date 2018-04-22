using System;
using System.Collections.Generic;

namespace Core.Entities
{
    public class Report : BaseEntity
    {
        public DateTime Date { get; set; }

        public virtual User User { get; set; }

        public virtual ICollection<Dish> Dishes { get; set; }
    }
}
