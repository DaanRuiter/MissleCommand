package src 
{
	import src.Objects.Explosion;
	/**
	 * ...
	 * @author Daan Ruiter
	 */
	public class ExplosionFactory 
	{
		
		public function makeExplosion(_x:Number, _y:Number):Explosion 
		{
			var explosion:Explosion = new Explosion(_x, _y);
			explosion.setRemovable();
			return explosion;
		}
		
	}

}