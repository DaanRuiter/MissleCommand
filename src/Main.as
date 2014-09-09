package src 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * ...
	 * @author Daan Ruiter
	 */
	public class Main extends MovieClip
	{
		private var game:Game = new Game();
		public function Main() 
		{
			addChild(game);
		}
		
	}

}