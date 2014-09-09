package src.Objects 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import src.Globals;
	/**
	 * ...
	 * @author Daan Ruiter
	 */
	public class Gun extends GameObject
	{
		private var base:MovieClip = new ART_gun_base;
		private var gun:MovieClip = new ART_gun_cannon;
		public function Gun() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addChild(base);
			addChild(gun);
			gun.y = 10;
		}
		
		override public function update(e:Event):void
		{
			super.update(e);
			lookAtMouse(gun);
		}
		
		private function lookAtMouse(obj:MovieClip):void
		{
			var dir = Math.atan2(obj.y - mouseY, obj. x - mouseX);
			obj.rotation = dir * 180/Math.PI + 180;
		}
		
		public function returnGunRotation():Number
		{
			return this.gun.rotation;
		}
		
	}

}