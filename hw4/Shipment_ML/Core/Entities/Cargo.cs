namespace Core.Entities
{
    public class Cargo : BaseEntity
    {
        public double Weight { get; set; }

        public double Volume { get; set; }

        public int SenderId { get; set; }

        public int RecipientId { get; set; }

        public int ShipmentId { get; set; }
    }
}
