package src.Objects 
{
	import flash.events.Event;
	import src.Globals;
	/**
	 * ...
	 * @author Daan Ruiter
	 */
	public class Explosion extends GameObject
	{
		private var lifeTime:Number;
		public static const EXPLOSION_END:String = "explosion_end";
		public function Explosion(_x:Number, _y:Number) 
		{
			this.x = _x;
			this.y = _y;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			this.sprite = new ART_Explosion();
			addChild(sprite);
			lifeTime = this.sprite.totalFrames;
			addEventListener(Event.ENTER_FRAME, tick);
		}
		
		private function tick(e:Event):void 
		{
			if (this.sprite.currentFrame >= lifeTime)
			{
				removeEventListener(Event.ENTER_FRAME, tick);
				removeChild(sprite);
				dispatchEvent(new Event(EXPLOSION_END));
			}
		}
		
	}

}