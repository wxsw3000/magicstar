package builder.windows.components
{
	import flash.display.Sprite;
	
	public class Grid extends Sprite
	{
		public function Grid(tileWidth:Number,tileHeight:Number)
		{
			this.mouseEnabled = false;
			
			this.graphics.beginFill(0xFFFFFF,0);
			this.graphics.drawRect(0,0,tileWidth,40);
			this.graphics.endFill();
			
			this.graphics.lineStyle(1,0x0000FF);
			this.graphics.moveTo(0,0);
			this.graphics.lineTo(tileWidth,0);
			this.graphics.lineTo(tileWidth,tileHeight);
			this.graphics.lineTo(0,tileHeight);
			this.graphics.lineTo(0,0);
		}
	}
}