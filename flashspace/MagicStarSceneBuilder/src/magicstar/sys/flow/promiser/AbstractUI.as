package magicstar.sys.flow.promiser
{
	import flash.display.Sprite;
	
	import magicstar.sys.app.MagicStarApplication;
	//对具体UI控制器的约束父类型
	public class AbstractUI extends Sprite
	{
		public function AbstractUI()
		{
		}
		
		/**
		 * 
		 * 显示UI
		 * 
		 */ 
		public function show():void{
			MagicStarApplication.getInstance().uiLayer.addChild(this);
		}
		/**
		 * 
		 * UI从舞台上删除
		 * 
		 */ 
		public function dispose():void{
			//MagicStarApplication.getInstance().uiLayer.removeChild(this);
			if(this.parent){
				this.parent.removeChild(this);
			}
		}
		
	}
}