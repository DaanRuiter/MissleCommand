package src.GUI 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author ...
	 */
	 
	public class Button extends MovieClip
	{
		public static const START:String = "start";
		public static const OPTIONS:String = "options";
		public static const CREDITS:String = "credits";
		
		public static const CLICKED:String = "clicked";
		
		private var defaultSprite:MovieClip;
		private var hoverSprite:MovieClip;
		
		private var onClickFunction:String;
		
		public function Button(def:MovieClip, hov:MovieClip, func:String) 
		{
			defaultSprite = def;
			hoverSprite = hov;
			onClickFunction = func;
			addChild(defaultSprite);
			addChild(hoverSprite);
			hoverSprite.visible = false;
			hoverSprite.useHandCursor = true;
			addEventListener(MouseEvent.MOUSE_OVER, hover);
			addEventListener(MouseEvent.MOUSE_OUT, unHover);
			addEventListener(MouseEvent.MOUSE_UP, click);
		}
		
		private function click(e:MouseEvent):void 
		{
			dispatchEvent(new Event(CLICKED));
		}
		
		private function hover(e:MouseEvent):void 
		{
			defaultSprite.visible = false;
			hoverSprite.visible = true;
		}	
		
		private function unHover(e:MouseEvent):void 
		{
			defaultSprite.visible = true;
			hoverSprite.visible = false;
		}
		
	}

}