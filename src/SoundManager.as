package src 
{
	import flash.media.Sound;
	/**
	 * ...
	 * @author ...
	 */
	public class SoundManager 
	{
		public var explosionSound:Sound = new SOUND_explosion();
		public var swoopSound:Sound = new SOUND_swoop();
		public var musicSound:Sound = new SOUND_music();

		public function playSound(sound:Sound, loop:Boolean):void
		{
			if (loop)
			{
			sound.play(1, 9999);	
			}else{
				sound.play();
			}
		}
		
		
	}

}