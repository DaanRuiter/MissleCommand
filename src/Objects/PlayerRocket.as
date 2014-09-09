package src.Objects 
{
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import src.Game;
	import src.Globals;
	/**
	 * ...
	 * @author Daan Ruiter
	 */
	public class PlayerRocket extends GameObject
	{
		private var destination:Point;
		private var xReached:Boolean;
		private var yReached:Boolean;
		private var startSide:Boolean;
		
		public function PlayerRocket() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init)
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			sprite = new ART_playerRocket();
			addChild(sprite);
			destination = new Point();
			_isRocket = true;
		}
		
		public function giveDestination(_x:Number, _y:Number, _cX:Number):void
		{
			destination.x = _x;
			destination.y = _y;
			if (mouseX > _cX)
			{
				startSide = true;
			}
		}
		
		public override function update(e:Event):void
		{
			xVelocity = Math.cos(this.rotation * Math.PI / 180) * 8;
			yVelocity = Math.sin(this.rotation * Math.PI / 180) * 8;
			
			this.x += xVelocity;
			this.y += yVelocity;
			
			if (startSide)
			{
				if (this.x >= destination.x)
				{
					xReached = true;
				}
			}else{
				if (this.x <= destination.x)
				{
					xReached = true;
				}
			}
			if (this.y <= destination.y)
			{
				yReached = true;
			}
			if (xReached && yReached)
			{
				this.removeEventListener(Event.ENTER_FRAME, update);
				this.removable = true;
			}
		}
		
		//public function getInfo()
		
	}

}