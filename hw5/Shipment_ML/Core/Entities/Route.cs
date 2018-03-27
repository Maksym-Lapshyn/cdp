namespace Core.Entities
{
	public class Route : BaseEntity
	{
		public int OriginId { get; set; }
		
		public int DestinationId { get; set; }

		public int Distance { get; set; }
	}
}
