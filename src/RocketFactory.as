package src 
{
	import src.Objects.Rocket;
	/**
	 * ...
	 * @author Daan Ruiter
	 */
	public class RocketFactory 
	{
		public static const ROCKET_DEFAULT : String = "rocket_default";
		
		public function makeRocket(type : String, stageWidth:Number):Rocket
		{
			if (type == ROCKET_DEFAULT)
			{
				var rocket = new Rocket();
				rocket.setStartPos(rocket.x, rocket.y);
				rocket.x = Math.random() * stageWidth;
				rocket.y = Math.random() * - 600;
				return rocket;
			}
			return null;
		}
		
	}

}