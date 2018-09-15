package
{
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	
	import magicstar.sys.MagicStarProcessManager;
	import magicstar.sys.app.MagicStarApplication;
	import magicstar.sys.init.ReflectionRegister;

	
	public class MagicStarSceneBuilder extends Sprite
	{
		public function MagicStarSceneBuilder()
		{stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			stage.frameRate = 30;
			MagicStarApplication.getInstance().CurrentStage = this.stage;
			
			
			
			ReflectionRegister.getInstance().initReflectionManager();
			MagicStarProcessManager .getInstance().systemBegin();
			
		}
		
		
	}
}