using System.Collections.Generic;

namespace Core.Entities
{
    public class User : BaseEntity
    {
        public string FirstName { get; set; }

        public string LastName { get; set; }

        public virtual ICollection<Preference> Preferences { get; set; }

        public virtual ICollection<Report> Reports { get; set; }
    }
}
