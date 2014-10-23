package src
{
	import src.Objects.Gun;
	/**
	 * ...
	 * @author Daan Ruiter
	 */
	public class CannonFactory 
	{
		public function makeCannon():Gun 
		{
			var gun:Gun = new Gun();
			return gun;
		}
		
	}

}