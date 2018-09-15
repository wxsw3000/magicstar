package magicstar.engine.scene.map
{
	import flash.events.Event;
	

	public class MapLoaderEvent extends Event
	{
		public static const LOADER_COMPLETE:String = "LOADER_COMPLETE";
		public static const INIT_COMPLETE:String = "INIT_COMPLETE";
		public static const DRAW_COMPLETE:String = "DRAW_COMPLETE";
		public static const CREATE_COMPLETE:String = "CREATE_COMPLETE";
		
		
		public function MapLoaderEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=true)
		{
			super(type, bubbles, cancelable);
		}
	}
}