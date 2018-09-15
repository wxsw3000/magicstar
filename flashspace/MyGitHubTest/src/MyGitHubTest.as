package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	public class MyGitHubTest extends Sprite
	{
		public function MyGitHubTest()
		{
			super();
			
			// 支持 autoOrient
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			
			var bigOne:Sprite = new Sprite;
			bigOne.graphics.beginFill(0x00aacc,1);
			bigOne.graphics.drawRect(0,0,100,100);
			bigOne.graphics.endFill();
			
			
			var smallOne:Sprite = new Sprite;
			smallOne.graphics.beginFill(0xaaccbb,1);
			smallOne.graphics.drawRect(0,0,50,50);
			smallOne.graphics.endFill();
			
			
			bigOne.x = 50;
			bigOne.y = 50;
			
			smallOne.x = 200;
			smallOne.y = 200;
			
			
			this.addChild(smallOne);
			
			this.addChild(bigOne);
			
		}
	}
}