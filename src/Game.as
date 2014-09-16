package src 
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import src.Objects.Explosion;
	import src.Objects.GameObject;
	import src.Objects.Gun;
	import src.Objects.PlayerRocket;
	import src.Objects.Rocket;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Shape;
	/**
	 * ...
	 * @author Daan Ruiter
	 */
	public class Game extends MovieClip
	{
		private var platform:MovieClip = new ART_platform();
		private var rocketFactory:RocketFactory = new RocketFactory();
		private var lineFactory:LineFactory = new LineFactory();
		private var gameObjectsInStage:Array = new Array();
		private var enemyRockets:Array = new Array();
		private var explosions:Array = [];
		private var guns:Array = new Array();
		private var lines:Array = new Array();
		public function Game() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addChild(new ART_background());		
			spawnRockets(6);
			addChild(platform);
			platform.y = 640;
			
			for (var i:int = 0; i < 3; i++)
			{
				var gun:Gun = new Gun();
				addChild(gun);
				gun.x = 450 * i;
				gun.y = 640;
				guns.push(gun);
			}	
			addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, shoot);
		}
		
		private function shoot(e:MouseEvent):void 
		{
			var rocket:PlayerRocket = new PlayerRocket();
			gameObjectsInStage.push(rocket);
			addChild(rocket);
			var cannonPos:Point = new Point();
			var chosencannon:int;
			if (mouseX < 200)
			{
				chosencannon = 0;
			}else if (mouseX > 200 && mouseX < 600) {
				chosencannon = 1;
			}else if (mouseX > 600) {
				chosencannon = 2;
			}
			cannonPos.x = guns[chosencannon].x;
			cannonPos.y = guns[chosencannon].y;
			rocket.x = cannonPos.x;
			rocket.y = cannonPos.y;
			rocket.rotation = guns[chosencannon].returnGunRotation();
			rocket.giveDestination(mouseX, mouseY, guns[chosencannon].x);
		}
		
		private function update(e:Event):void 
		{
			testCollision();
			testWaveSize();
			updateLines();
		}
		
		private function spawnRockets(num:int):void
		{
			for (var i:int = 0; i < num; i++) 
			{
				var rocket = rocketFactory.makeRocket(RocketFactory.ROCKET_DEFAULT, stage.stageWidth);
				enemyRockets.push(rocket);
				var line = lineFactory.makeLine(rocket);
				addChild(line);
				addChild(rocket);
				lines.push(line);
				Globals.rocketsInWave++;
			}
		}
		
		private function testWaveSize():void
		{
			if (Globals.rocketsInWave <= 0)
			{
				Globals.wavesCompleted++;
				spawnRockets(6 + 3 * Globals.wavesCompleted);
			}
		}
		
		private function testCollision():void
		{
			for (var i:int = 0; i < gameObjectsInStage.length; i++)
			{
				if (gameObjectsInStage[i].testsCollision())
				{
					if (gameObjectsInStage[i].hitTestObject(platform))
					{
						gameObjectsInStage[i].setRemovable();
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
						gameObjectsInStage.splice(j, 1);
						removeChild(obj);
					}
				}
			}
			for each(var explosion in explosions)
			{
				for (var i:int = 0; i < enemyRockets.length; i++)
				{
					if (enemyRockets[i].hitTestObject(explosion))
					{
						explode(enemyRockets[i].x, enemyRockets[i].y);
						removeEnemyRocket(enemyRockets[i]);
					}
				}
			}
		}
		
		private function updateLines():void
		{
			for (var i:int = 0; i < lines.length; i++)
			{
				lines[i].graphics.lineTo(enemyRockets[i].x, enemyRockets[i].y);
			}
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
		}
		
		private function explode(_x:Number, _y:Number):void
		{
			var explosion:Explosion = new Explosion(_x, _y);
			addChild(explosion);
			explosions.push(explosion);
			explosion.setRemovable();
			explosion.addEventListener(Explosion.EXPLOSION_END, removeEplosion);
		}
		
		private function removeEplosion(e:Event):void 
		{
			for each(var expl:GameObject in explosions)
			{
				if (expl.isRemovable())
				{
					var index:int = explosions.indexOf(expl);
					explosions.splice(index, 1);
					removeChild(expl);
				}
			}
		}
		
	}

}