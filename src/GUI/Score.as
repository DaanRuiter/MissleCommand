package src.GUI 
{
	import flash.display.MovieClip;
	import flash.filters.GlowFilter;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.filters.BitmapFilterQuality;
	import flash.net.SharedObject;
	import src.Globals;
	/**
	 * ...
	 * @author Daan Ruiter
	 */
	public class Score extends MovieClip
	{
		private var scoreText:TextField;
		private var highscoreText:TextField;
		public var score:uint;
		public var highscore:uint;
		public var scoreMultiplier:int;
		private var outline:GlowFilter = new GlowFilter(0x000000, 1, 2, 2, 10);
		
		public var shared:SharedObject = SharedObject.getLocal('highscore');
		
		private var greenColor:uint = 0x22FF22;
		private var redColor:uint = 0xFF2222;
		
		public function Score(highOnly:Boolean)
		{
			var textFormat:TextFormat = new TextFormat();
			textFormat.size = 35;
			var font:Font = new FONT_8bit();
			textFormat.font = font.fontName;
			
			outline.quality = BitmapFilterQuality.MEDIUM;
			
			if (!highOnly)
			{
				scoreText = new TextField();
				scoreText.defaultTextFormat = textFormat;
				scoreText.embedFonts = true;
				scoreText.text = "Score: 0";
				scoreText.textColor = 0xFFFFFF;
				scoreText.width = 600;
				scoreText.y = 45;
				scoreText.filters = [outline];
				addChild(scoreText);
			}
			
			scoreMultiplier = 1;
			highscore = shared.data.highscore;
			
			highscoreText = new TextField();
			highscoreText.defaultTextFormat = textFormat;
			highscoreText.embedFonts = true;
			highscoreText.text = "Highscore: " + highscore;
			highscoreText.textColor = redColor;
			highscoreText.width = 600;
			highscoreText.filters = [outline];
			addChild(highscoreText);
		}
		
		public function updateScore(_score:int):void
		{
			scoreMultiplier = Globals.wavesCompleted / 2;
			score += _score + _score * scoreMultiplier;
			scoreText.text = "Score: " + score;
			if (score > highscore)
			{
				highscore = score;
				highscoreText.textColor = greenColor;
				highscoreText.text = "Highscore: " + highscore;
				shared.data.highscore = highscore;
			}
		}
		
	}

}