package src
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import src.GUI.Score;
	import src.Objects.Car;
	import src.Objects.GameObject;
	
	/**
	 * ...
	 * @author Daan Ruiter
	 */
	public class Game extends MovieClip
	{
		//consts
		public static const GAME_OVER:String = "game_over";
		
		//art
		private var platform:MovieClip = new ART_platform();
		
		//UI
		private var score:Score = new Score(false);
		
		//factories
		private var rocketFactory:RocketFactory = new RocketFactory();
		private var lineFactory:LineFactory = new LineFactory();
		private var cannonFactory:CannonFactory = new CannonFactory();
		private var explosionFactory:ExplosionFactory = new ExplosionFactory();
		
		//arrays
		private var gameObjectsInStage:Array = new Array();
		private var playerRocketLines:Array = new Array();
		private var enemyRockets:Array = new Array();
		private var explosions:Array = new Array();
		private var guns:Array = new Array();
		private var cities:Array = new Array();
		private var lines:Array = new Array();
		
		//vars
		public var soundManager:SoundManager = new SoundManager();
		
		public function Game()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addChild(new ART_background());
			addChild(platform);
			platform.y = 640;
			addChildAt(score, 2);
			score.x = 20;
			score.y = 20;
			
			for (var i:int = 0; i < 3; i++)
			{
				var j:Number = 0.1 + i;
				var gun = cannonFactory.makeCannon();
				addChild(gun);
				gun.x = 450 * j;
				gun.y = 640;
				guns.push(gun);
			}
			
			spawnCities();
			spawnRockets(6);			
			spawnCars(12);
			
			addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, shoot);
		}
		
		private function shoot(e:MouseEvent):void
		{
			var chosencannon:int;
			if (mouseX < 200)
			{
				chosencannon = 0;
			}
			else if (mouseX > 200 && mouseX < 600)
			{
				chosencannon = 1;
			}
			else if (mouseX > 600)
			{
				chosencannon = 2;
			}
			var rocket = rocketFactory.makePlayerRocket(guns[chosencannon]);
			var line = lineFactory.makePlayerLine(rocket, LineFactory.COLOR_BLUE);
			addChildAt(line, 1);
			playerRocketLines.push(line);
			gameObjectsInStage.push(rocket);
			addChildAt(rocket, 1);
			soundManager.playSound(soundManager.explosionSound, false);
		}
		
		private function update(e:Event):void
		{
			if (!Globals.gameOver)
			{
				testCollision();
				testWaveSize();
				updateLines();
			}else {
				score.shared.flush();
				dispatchEvent(new Event(GAME_OVER));
			}
		}
		
		private function spawnRockets(num:int):void
		{
			for (var i:int = 0; i < num; i++)
			{
				var xP:int = Math.floor(Math.random() * cities.length);
				var xR:int = Math.floor(Math.random() * 35);
				var xS:int = Math.floor(Math.random() * 1);
				if (xS == 0)
				{
					var rocket = rocketFactory.makeRocket(cities[xP].x - xR);
				}
				if (xS == 1)
				{
					var rocket = rocketFactory.makeRocket(cities[xP].x + xR);
				}
				enemyRockets.push(rocket);
				var line = lineFactory.makeLine(rocket, LineFactory.COLOR_RED);
				addChildAt(line, 1);
				addChildAt(rocket, 1);
				lines.push(line);
				Globals.rocketsInWave++;
			}
		}
		
		private function testWaveSize():void
		{
			if (Globals.rocketsInWave <= 0)
			{
				Globals.wavesCompleted++;
				spawnCities();
				spawnRockets(6 + 3 * Globals.wavesCompleted);
			}
		}
		
		private function testCollision():void
		{
			for (var i:int = 0; i < enemyRockets.length; i++)
			{
				if (enemyRockets[i].testsCollision())
				{
					for (var l:int = 0; l < cities.length; l++)
					{
						if (enemyRockets[i].hitTestObject(cities[l]))
						{
							removeCity(l);
							explode(enemyRockets[i].x, enemyRockets[i].y);
							enemyRockets[i].setRemovable();
							if (cities.length <= 0)
							{
								Globals.gameOver = true;
							}
						}
					}
				}
				if (enemyRockets[i] != null)
				{
					if (enemyRockets[i].y > 630)
					{
						removeEnemyRocket(enemyRockets[i]);
					}
				}
			}
			for (var j:int = 0; j < gameObjectsInStage.length; j++)
			{
				var obj = gameObjectsInStage[j];
				if (obj.isRemovable())
				{
					if (!obj.isObjectRocket())
					{
						removeEnemyRocket(obj);
						Globals.rocketsInWave--;
					}
					else
					{
						explode(obj.x, obj.y);
						removeChild(playerRocketLines[j]);
						playerRocketLines.splice(j, 1);
						gameObjectsInStage.splice(j, 1);
						removeChild(obj);
					}
				}
			}
			for each (var explosion in explosions)
			{
				for (var k:int = 0; k < enemyRockets.length; k++)
				{
					if (enemyRockets[k].hitTestObject(explosion))
					{
						explode(enemyRockets[k].x, enemyRockets[k].y);
						removeEnemyRocket(enemyRockets[k]);
					}
				}
			}
			for each (var expl:GameObject in explosions)
			{
				if (expl.isRemovable())
				{
					var index:int = explosions.indexOf(expl);
					explosions.splice(index, 1);
					removeChild(expl);
				}
			}
		}
		
		private function updateLines():void
		{
			for (var i:int = 0; i < lines.length; i++)
			{
				lines[i].graphics.lineTo(enemyRockets[i].x, enemyRockets[i].y);
			}
			for (var j:int = 0; j < gameObjectsInStage.length; j++)
			{
				playerRocketLines[j].graphics.lineTo(gameObjectsInStage[j].x, gameObjectsInStage[j].y);
			}
		}
		
		private function spawnCars(amount:int):void
		{
			for (var i:int = 0; i < amount; i++)
			{
				var car:MovieClip = new Car();
				var r:int = Math.floor(Math.random() * stage.stageWidth);
				var r2:int = Math.floor(Math.random() * 50) + 680;
				car.x = r;
				car.y = r2;
				addChild(car);
			}
		}
		
		private function spawnCities():void
		{
			for (var l:int = cities.length - 1 ; l >= 0 ; l--)
			{
				removeCity(l);
			}
			trace(cities.length);
			
			for (var k:int = 0; k < 5; k++)
			{
				var city:MovieClip = new ART_city();
				addChild(city);
				city.y = 650;
				city.scaleX = 0.60;
				city.scaleY = city.scaleX;
				cities.push(city);
			}
			
			cities[0].x = 200;
			cities[1].x = 330;
			cities[2].x = 600;
			cities[3].x = 720;
			cities[4].x = 870;
		}
		
		private function removeCity(i:int)
		{
			removeChild(cities[i]);
			cities.splice(i, 1);
			soundManager.playSound(soundManager.swoopSound, false);
		}
		
		private function removeEnemyRocket(rocket:GameObject):void
		{
			var index = enemyRockets.indexOf(rocket);
			enemyRockets.splice(index, 1);
			rocket.removeEventListener(Event.ENTER_FRAME, rocket.update);
			removeChild(rocket);
			removeChild(lines[index]);
			lines.splice(index, 1);
			Globals.rocketsInWave--;
			score.updateScore(Globals.scorePerRocket);
		}
		
		private function explode(_x:Number, _y:Number):void
		{
			var explosion = explosionFactory.makeExplosion(_x, _y);
			addChildAt(explosion, 1);
			explosions.push(explosion);
		}
	}
}