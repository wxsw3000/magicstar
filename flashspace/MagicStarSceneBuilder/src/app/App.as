package app
{
	import flash.events.Event;
	
	import builder.MagicStarEditorStage;
	import builder.res.MagicStarMaterialManager;
	
	import magicstar.sys.app.MagicStarApplication;
	
	import builder.windows.ui.SrcController;

	public class App
	{
		private static var instance:App;
		
		
		public static function getInstance():App{
			if(!instance){
				instance = new App(new AppPrivate);
			}
			return instance;
		}
		
		public function App(param:AppPrivate)
		{
			
		}
		
		
		
		
		
		public function appStart():void{
			
			
			
			MagicStarMaterialManager.getInstance().addEventListener("INIT_EDITOR",onStartEditor);
			
			//初始化导入UI。然后通过用户操作ui中的按钮进行资源加载，再进行下一步
			SrcController.getInstance().startSrcManager();
			MagicStarApplication.getInstance().CurrentStage.addChild(SrcController.getInstance().srcUI);
			
		}
		
		
		
		
		/**
		 * 
		 * 用户操作后，资源加载完毕，开始初始化编辑器
		 * 
		 */
		public function onStartEditor(event:Event):void{
			if(SrcController.getInstance().srcUI.parent){
				SrcController.getInstance().srcUI.parent.removeChild(SrcController.getInstance().srcUI);
			}
			//MagicStarEditorStage.getInstance().currentStage = MagicStarApplication.getInstance().CurrentStage;//再set舞台的时候，就将各种编辑层，工具栏都一股脑初始化。张二娃没有学到mvc的精髓啊，即可修~~~
		}
		
	}
}
class AppPrivate{}