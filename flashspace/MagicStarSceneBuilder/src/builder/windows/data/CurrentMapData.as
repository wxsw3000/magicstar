package builder.windows.data
{
	public class CurrentMapData
	{
		private static var instance:CurrentMapData;
		
		public static function getInstance():CurrentMapData
		{
			if(!instance){
				instance = new CurrentMapData;
			}
			return instance;
		}
		
		public var cols:int;
		public var rows:int;
		public var mapID:String;
		public function CurrentMapData()
		{
			
		}
	}
}