package builder.style
{
	import flash.filters.GlowFilter;

	public class TextFiltersManager
	{
		private static var instance:TextFiltersManager;
		
		public static function getInstance():TextFiltersManager
		{
			if(!instance){
				instance = new TextFiltersManager;
			}
			return instance;
		}
		
		public var whiteFilters:GlowFilter;
		public var blackFilters:GlowFilter;
		public function TextFiltersManager()
		{
			whiteFilters = new GlowFilter(0xFFFFFF,1,5,5,10);
			
			blackFilters = new GlowFilter(0x000000,1,5,5,10);
		}
	}
}