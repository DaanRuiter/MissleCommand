package {
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * @author berendweij
	 */
	public class EnemyShipFactory extends Sprite{
		
		public static const UFO_ENEMY_SHIP : String		=	"ufoEnemyShip";
		public static const ROCKET_ENEMY_SHIP : String	=	"rocketEnemyShip";
		public static const RAPIDFIRE_ENEMY_SHIP : String = "rapidfireEnemyShip";
		public static const BIGBOSS_ENEMY_SHIP : String	=	"bigBossEnemyShip";
		
		private var buildingShip:String;
		private var progress:int;
		private var buildPower:Number;
		private var buildTime:Number;
		private var isBuilding:Boolean;
		
		private function EnemyShipFactory()
		{
			buildPower = 4;
			buildTime = 4;
			addEventListener(Event.ENTER_FRAME, tick);
		}
		
		private function tick(e:Event):void 
		{
			if (buildingShip != null)
			{
				if (buildTime > 0)
				{
					buildTime -= 0.2;
				}else {
					progress += buildPower;
				}
				if (progress == 100) 
				{
					finishEnemyShip(buildingShip);
					buildingShip = null;
				}
			}
		}
		
		public function makeEnemyShip( type : String ) : EnemyShip
		{
			buildingShip = type;
		}
		
		public function finishEnemyShip(type : String):EnemyShip
		{
			// lokale variabele waar de het nieuwe ruimteschip in opslaan
			var enemy : EnemyShip;
			
			if(type == UFO_ENEMY_SHIP)
			{
				enemy = new UFOEnemyShip();
			}
			else if(type == ROCKET_ENEMY_SHIP)
			{
				enemy = new RocketEnemyShip();
			} 
			else if(type == RAPIDFIRE_ENEMY_SHIP)
			{
				enemy = new RapidfireEnemyShip();
			}	
			else
			{
				enemy = new BigBossEnemyShip();
			}
			
			// we kunnen het ruimteschip nog wat basisinstellingen meegeven
			// het voordeel dat we het hier doen is dat je het niet door je hele applicatie hebt staan
			enemy.rotation = 10;
			
			return enemy;
		}
		
		public function CheckIfBuilding():Boolean
		{
			return isBuilding;
		}
		
	}
}
