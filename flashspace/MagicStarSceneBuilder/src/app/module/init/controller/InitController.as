package app.module.init.controller
{
	
	import flash.events.Event;
	
	import builder.res.MagicStarMaterialManager;
	import builder.windows.MagicStarBuilderWindow;
	
	import logo.MagicStar;
	
	import magicstar.sys.app.MagicStarApplication;
	import magicstar.sys.flow.promiser.AbstractController;
	
	
	
	

	public class InitController extends AbstractController
	{
		
		
		public function InitController()
		{
		}
		
		//本模块入口函数
		override public function startController():void{
			trace("对应用进行加载和初始化");
			
			MagicStar.getInstance().show();
			
			MagicStarMaterialManager.getInstance().addEventListener("INIT_EDITOR",initEditor);
			MagicStarMaterialManager.getInstance().readLocal();//从本地安装文件夹下读取资源库
			
		}
		

		public function initEditor(event:Event):void{
			
			MagicStar.getInstance().hide();
			
			MagicStarApplication.getInstance().CurrentStage.addChild(MagicStarBuilderWindow.getInstance());
			//显示编辑区域。当前任务主要改进编辑区域。
			
			/*MagicStarEditorStage.getInstance().x = 300;
			MagicStarEditorStage.getInstance().y = 300;*/
			
			//MagicStarEditorStage.getInstance().show();
		}
		
		
		
		//本模块终结函数
		override public function terminateController():void{
			
		}
		
	}
}