namespace Core.Entities
{
    public class Preference : BaseEntity
    {
        public int Min { get; set; }

        public int Max { get; set; }

        public virtual User User { get; set; }

        public virtual Parameter Parameter { get; set; }
    }
}
