package src 
{
	import flash.display.Shape;
	import src.Objects.PlayerRocket;
	import src.Objects.Rocket;
	/**
	 * ...
	 * @author Daan Ruiter
	 */
	public class LineFactory 
	{
		public static const COLOR_BLUE:String = "color_blue";
		public static const COLOR_RED:String = "color_red";
		public function makeLine(rocket:Rocket, color:String):Shape 
		{
			if (color == COLOR_BLUE)
			{
				var line = new Shape();
				line.graphics.lineStyle(2, 0x0000FF, 1);
				line.graphics.beginFill(0x0000FF);
				line.graphics.endFill();
				line.graphics.moveTo(rocket.x, rocket.y); 
				line.graphics.lineTo(rocket.x, rocket.y);
				return line;
			}
			if (color == COLOR_RED)
			{
				var line = new Shape();
				line.graphics.lineStyle(2, 0xFF0000, 1);
				line.graphics.beginFill(0xFF0000);
				line.graphics.endFill();
				line.graphics.moveTo(rocket.x, rocket.y); 
				line.graphics.lineTo(rocket.x, rocket.y);
				return line;
			}
			return null;
		}
		public function makePlayerLine(rocket:PlayerRocket, color:String):Shape 
		{
			if (color == COLOR_BLUE)
			{
				var line = new Shape();
				line.graphics.lineStyle(2, 0x0000FF, 1);
				line.graphics.beginFill(0x0000FF);
				line.graphics.endFill();
				line.graphics.moveTo(rocket.x, rocket.y); 
				line.graphics.lineTo(rocket.x, rocket.y);
				return line;
			}
			if (color == COLOR_RED)
			{
				var line = new Shape();
				line.graphics.lineStyle(2, 0xFF0000, 1);
				line.graphics.beginFill(0xFF0000);
				line.graphics.endFill();
				line.graphics.moveTo(rocket.x, rocket.y); 
				line.graphics.lineTo(rocket.x, rocket.y);
				return line;
			}
			return null;
		}
	}

}