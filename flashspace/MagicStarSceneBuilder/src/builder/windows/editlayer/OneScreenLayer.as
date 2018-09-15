package builder.windows.editlayer
{
	import flash.display.Sprite;
	
	public class OneScreenLayer extends Sprite
	{
		public function OneScreenLayer()
		{
			this.x = 100;
			this.y = 100;
			
			this.mouseEnabled = false;
			this.mouseChildren = false;
			
			this.graphics.drawRect(0,0,1280,720);
			this.graphics.endFill();
			
			this.graphics.lineStyle(10,0x000000);
			this.graphics.moveTo(0,0);
			this.graphics.lineTo(1280,0);
			this.graphics.lineTo(1280,720);
			this.graphics.lineTo(0,720);
			this.graphics.lineTo(0,0);
		}
	}
}