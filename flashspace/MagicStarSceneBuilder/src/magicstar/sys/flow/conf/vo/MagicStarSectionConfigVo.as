package magicstar.sys.flow.conf.vo
{
	public class MagicStarSectionConfigVo
	{
		public var sectionName:String;
		public var uiConfigArray:Array;
		public var controllerConfigArray:Array;
		public var srcConfigArray:Array;
		
		public function MagicStarSectionConfigVo()
		{
			this.uiConfigArray = new Array;
			this.controllerConfigArray = new Array;
			this.srcConfigArray = new Array;
		}
	}
}