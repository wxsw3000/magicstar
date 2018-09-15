package builder.windows.components
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import builder.res.MagicStarSrcManager;
	
	public class MapResources extends Sprite
	{
		public var url:String;
		public var type:int;
		public var groundType:int;
		
		public function MapResources(url:String, type:int, groundType:int=2)
		{
			this.url = url;
			this.type = type;
			this.groundType = groundType;
			
			if(type == 1){
				var sourceBitmap:Bitmap = new Bitmap(MagicStarSrcManager.getInstance().getData(url));
				this.addChild(sourceBitmap);
			}else{
				var sourceMc:MovieClip = MagicStarSrcManager.getInstance().getMC(url) as MovieClip;
				sourceMc.mouseChildren = false;
				sourceMc.mouseEnabled = false;
				sourceMc.stop();
				this.addChild(sourceMc);
			}
		}
	}
}