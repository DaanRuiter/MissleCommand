package src.Objects 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Daan Ruiter
	 */
	public class Rocket extends GameObject
	{
		//private var line:Particle = new Particle();
		public function Rocket() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			sprite = new ART_rocket();
			addChild(sprite);
			affectedByGravity = true;
			testCollision = true;
			collisionTarget = "ground";
			//addChild(line);
		}
		
		public override function update(e:Event):void
		{
			super.update(e);
			//line.updatePos(x,y);
		}
		
	}

}