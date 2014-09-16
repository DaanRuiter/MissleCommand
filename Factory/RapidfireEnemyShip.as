package  
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Daan Ruiter
	 */
	public class RapidfireEnemyShip extends EnemyShip
	{
		private var	cooldown : Number;
		public function RapidfireEnemyShip() 
		{
			cooldown = 5;
			shipName = "RapidFireShip";
			damage = 5;
			addEventListener(Event.ENTER_FRAME, tick);
		}
		
		private function tick(e:Event):void 
		{
			if (cooldown > 0) {
				cooldown -= 0.05;				
			}else {
				shoot();
				cooldown = 5;
			}
		}
		
	}

}