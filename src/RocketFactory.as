package src
{
	import flash.display.Sprite;
	import src.Objects.Gun;
	import src.Objects.PlayerRocket;
	import src.Objects.Rocket;
	/**
	 * ...
	 * @author Daan Ruiter
	 */
	public class RocketFactory extends Sprite
	{		
		public function makeRocket(_x:Number):Rocket
		{
			var rocket:Rocket = new Rocket();
			rocket.setStartPos(rocket.x, rocket.y);
			rocket.x = _x;
			rocket.y = Math.random() * - 600;
			return rocket;
		}
		
		public function makePlayerRocket(gun:Gun):PlayerRocket
		{
			var rocket:PlayerRocket = new PlayerRocket();
			rocket.x = gun.x;
			rocket.y = gun.y;
			rocket.rotation = gun.returnGunRotation();
			rocket.giveDestination(mouseX, mouseY, gun.x);
			return rocket;
		}
		
	}

}