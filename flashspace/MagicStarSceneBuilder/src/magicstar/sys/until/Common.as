package magicstar.sys.until
{
	import flash.display.BitmapData;

	public class Common
	{
		public function Common()
		{
		}
		
		/**
		 * 
		 * 位图镜像转置
		 * 
		 */ 
		
		public static function getOppsite(data:BitmapData):BitmapData{
			
			var oppsiteData:BitmapData = new BitmapData(data.width, data.height, true, 0x00000000);
			for (var x:int=data.width; x>=0; x--) {
				for (var y:int=0; y<data.height; y++) {
					oppsiteData.setPixel32(x,y,data.getPixel32(data.width-x,y));
				}
			}
			return oppsiteData;
		}
		
	}
}