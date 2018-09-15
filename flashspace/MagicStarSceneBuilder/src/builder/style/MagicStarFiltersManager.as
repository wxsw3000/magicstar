package builder.style
{
	import flash.filters.GlowFilter;
	import flash.utils.Dictionary;

	public class MagicStarFiltersManager
	{
		private static var instance:MagicStarFiltersManager;
		public var dic:Dictionary;
		public static function getInstance():MagicStarFiltersManager
		{
			if(!instance){
				instance = new MagicStarFiltersManager(new MagicStarFiltersManagerPrivate);
			}
			return instance;
		}
		/**
		 * 白色描边
		 */
		public var whiteFilters:GlowFilter;
		/**
		 * 黑色描边
		 */
		public var blackFilters:GlowFilter;
		
		
		/**
		 * 黑色描边 bold
		 */
		public var blackBoldFilters:GlowFilter;
		/**
		 *绿色描边 
		 */		
		public var greenFilter:GlowFilter;
		/**
		 *蓝色描边 
		 */		
		public var blueFilter:GlowFilter;
		/**
		 *紫色描边 
		 */		
		public var purpleFilter:GlowFilter;
		/**
		 *黄色描边 
		 */		
		public var yellowFilter:GlowFilter;
		public function MagicStarFiltersManager(param:MagicStarFiltersManagerPrivate)
		{
			this.whiteFilters = new GlowFilter(0xFFFFFF,3,3,3,5,1);
			
			this.blackFilters = new GlowFilter(0x000000,1,5,5,5,1);
			
			this.blackBoldFilters = new GlowFilter(0x000000,1,8,8,5,1);
			
			this.greenFilter=new GlowFilter(0x50F64A,1,8,8,5,1);
			this.blueFilter=new GlowFilter(0x2CA8F3,1,8,8,5,1);
			this.purpleFilter=new GlowFilter(0xE575E8,1,8,8,5,1);
			this.yellowFilter=new GlowFilter(0xFFB618,1,8,8,5,1);
			
			dic=new Dictionary;
			dic[1]=this.greenFilter;
			dic[2]=this.blueFilter;
			dic[3]=this.purpleFilter;
			dic[4]=this.yellowFilter;
		}
	}
}
class MagicStarFiltersManagerPrivate{}