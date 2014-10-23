package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.SharedObject;
	import src.Game;
	import src.GUI.Button;
	import src.GUI.Score;
	/**
	 * ...
	 * @author Daan Ruiter
	 */
	public class Main extends MovieClip
	{
		private var game:Game = new Game();
		private var logo:ART_logo = new ART_logo();
		private var menu:MovieClip = new MovieClip();
		
		private var startButton:Button = new Button(new BUTTON_start(), new BUTTON_start_hover(), Button.START);
		private var optionsButton:Button = new Button(new BUTTON_options(), new BUTTON_options_hover(), Button.OPTIONS);
		private var creditsButton:Button = new Button(new BUTTON_credits(), new BUTTON_credits_hover(), Button.CREDITS);
		
		private var highscore:Score = new Score(true);
		
		public function Main() 
		{
			game.soundManager.playSound(game.soundManager.musicSound, true);
			
			addChild(menu);
			
			var _bg:Sprite;
			_bg = new Sprite();
			_bg.graphics.beginFill(0x4999F5, 1);
			_bg.graphics.drawRect(0, 0, 1024, 768);
			_bg.graphics.endFill();
			menu.addChild(_bg);			
			
			highscore.x = 80;
			highscore.y = stage.stageHeight - 120;
			menu.addChild(highscore);
			
			menu.addChild(logo);
			logo.x = stage.stageWidth / 2 - logo.width / 2 + 20;
			logo.y = 70;
			logo.scaleX = 1.3;
			logo.scaleY = logo.scaleX;
			
			menu.addChild(startButton);
			startButton.x = 80;
			startButton.y = 250 + 75;
			startButton.scaleX = 0.8;
			startButton.scaleY = startButton.scaleX;
			startButton.addEventListener(Button.CLICKED, start);
			
			game.addEventListener(Game.GAME_OVER, startMenu);
		}
		
		private function startMenu(e:Event):void 
		{
			removeChild(game);
			addChild(menu);
		}
		
		private function start(e:Event):void 
		{
			removeChild(menu);
			addChild(game);
		}
		
	}

}