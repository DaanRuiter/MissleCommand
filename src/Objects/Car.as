package src.Objects 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Daan Ruiter
	 */
	public class Car extends GameObject
	{
		private var side:int = 1;
		private var speed:int = 3;
		public function Car() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init)
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			sprite = new ART_car();
			addChild(sprite);
			scaleX = -1;
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function loop(e:Event):void 
		{
			x += side * speed;
			if (x > stage.stageWidth)
			{
				side = -1;
				scaleX = 1;
			}else if (x < 0)
			{
				side = 1;
				scaleX = -1;
			}
		}
		
	}

}