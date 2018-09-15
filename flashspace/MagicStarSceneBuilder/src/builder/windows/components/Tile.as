package builder.windows.components
{
	import flash.display.Sprite;

	public class Tile extends Sprite
	{
		public var isMove:Boolean;
		public var showSpr:Sprite;
		public function Tile(type:int,tileWidth:Number,tileHeight:Number)
		{
			this.graphics.beginFill(0x001001,0.1);
			this.graphics.drawRect(0,0,tileWidth,tileHeight);
			this.graphics.endFill();
			
			this.graphics.lineStyle(1);
			this.graphics.moveTo(0,0);
			this.graphics.lineTo(tileWidth,0);
			this.graphics.lineTo(tileWidth,tileHeight);
			this.graphics.lineTo(0,tileHeight);
			this.graphics.lineTo(0,0);
			
			showSpr = new Sprite;
			showSpr.graphics.beginFill(0x000000,0.5);
			showSpr.graphics.drawRect(0,0,tileWidth,tileHeight);
			showSpr.mouseChildren = false;
			this.addChild(showSpr);
			
			if(type == 0){
				isMove = true;
				showSpr.visible = false;
			}else{
				isMove = false;
				showSpr.visible = true;
			}
		}
	}
}