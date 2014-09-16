package src 
{
	import flash.display.Shape;
	import src.Objects.Rocket;
	/**
	 * ...
	 * @author Daan Ruiter
	 */
	public class LineFactory 
	{
		public function makeLine(rocket:Rocket):Shape 
		{
			var line = new Shape();
			line.graphics.lineStyle(2, 0xFF0000, 1);
			line.graphics.beginFill(0xFF0000);
			line.graphics.endFill();
			line.graphics.moveTo(rocket.x, rocket.y); 
			line.graphics.lineTo(rocket.x, rocket.y);
			return line;
		}
		
	}

}