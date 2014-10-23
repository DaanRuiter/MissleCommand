package src.Objects 
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Point;
	import src.Globals;
	/**
	 * ...
	 * @author Daan Ruiter
	 */
	public class GameObject extends MovieClip
	{
		protected var affectedByGravity:Boolean = false; 
		protected var testCollision:Boolean = false;
		protected var removable:Boolean = false;
		protected var collisionTarget:String = "none";
		protected var sprite:MovieClip;
		protected var xVelocity:Number;
		protected var yVelocity:Number;
		protected var _isRocket:Boolean;
		protected var startPos:Point = new Point();
		protected var line:Shape;
		public function GameObject() 
		{
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		public function update(e:Event):void
		{
			if (Globals.gameOver)
			{
				removeEventListener(Event.ENTER_FRAME, update);
			}
			if (affectedByGravity)
			{
				this.y += Globals.gravityStrength;
			}
		}
		
		public function testsCollision():Boolean
		{
			return testCollision;
		}
		
		public function setRemovable():void
		{
			removable = true;
		}
		
		public function isRemovable():Boolean
		{
			return removable;
		}
		
		public function isObjectRocket():Boolean 
		{
			return _isRocket;
		}
		
		public function setStartPos(_x:Number, _y:Number):void
		{
			this.startPos.x = _x;
			this.startPos.y = _y;
		}
		
		public function getStartPos():Point
		{
			var point = new Point();
			point.x = this.x;
			point.y = this.y;
			return point;
		}
		
	}

}