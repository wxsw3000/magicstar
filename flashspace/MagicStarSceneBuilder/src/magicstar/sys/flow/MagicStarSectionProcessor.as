package magicstar.sys.flow
{
	
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import magicstar.sys.flow.conf.vo.MagicStarControllerConfigVo;
	import magicstar.sys.flow.conf.vo.MagicStarSectionConfigVo;
	import magicstar.sys.flow.promiser.AbstractController;
	import magicstar.sys.flow.conf.MagicStarSectionDB;
	import magicstar.sys.flow.factroy.MagicStarControllerFactory;
	import magicstar.sys.flow.factroy.MagicStarUIFactory;
    //流程处理器，处理流程的开始，结束，切换等
	public class MagicStarSectionProcessor extends EventDispatcher
	{
		//【20180610】，此类是管理应用的不同状态的。包括状态之间的切换处理，每个状态需要加载哪些资源，没个状态需要初始化哪些控制器或ui，都由本类管理。
		private var stage:DisplayObjectContainer;
		private var section:String;
		private static var instance:MagicStarSectionProcessor;
		private var sectionState:Dictionary;
		public var startProcessFunc:Function;
		
		
		
		public static function getInstance():MagicStarSectionProcessor{
			if(!instance){
				instance = new MagicStarSectionProcessor(new MagicStarSectionManagerPrivate);
			}
			return instance;
		}
		
		
		public function MagicStarSectionProcessor(processManager:MagicStarSectionManagerPrivate)
		{			
			this.sectionState = new Dictionary;
			/*this.section = "INIT";
			this.sectionState[this.section] = true;*/
	
		}
		/**
		 * 
		 * 执行流程
		 * 
		 */ 
		public function execute():void{
			MagicStarUIFactory.getInstance().doUIObtainProcess();
		}
		/**
		 * 
		 * 流程模块建立完毕
		 * 
		 */ 
		public function processCreateComplete():void{
			this.sectionState[this.section] = true;
			this.moduleBegin();
		}
		/**
		 * 
		 * 模块启动
		 * 
		 */ 
		public function moduleBegin():void{
			var currentSectionConfig:MagicStarSectionConfigVo = MagicStarSectionDB.getInstance().sectionConfigDic[this.section];
			for(var i:int=0;i < currentSectionConfig.controllerConfigArray.length;i++){
				var controllerConfig:MagicStarControllerConfigVo = currentSectionConfig.controllerConfigArray[i] as MagicStarControllerConfigVo;
				if(MagicStarControllerFactory.getInstance().getController(controllerConfig.controllerName)){
					(MagicStarControllerFactory.getInstance().getController(controllerConfig.controllerName) as AbstractController).startController();
				}
			}
		}
		
		/**
		 * 
		 * 模块终止
		 * 
		 */ 
		public function moduleTerminate():void{
			//【20180610】，取出当前模块信息。
			var currentSectionConfig:MagicStarSectionConfigVo = MagicStarSectionDB.getInstance().sectionConfigDic[this.section];
			for(var i:int=0;i < currentSectionConfig.controllerConfigArray.length;i++){
				var controllerConfig:MagicStarControllerConfigVo = currentSectionConfig.controllerConfigArray[i] as MagicStarControllerConfigVo;
				if(MagicStarControllerFactory.getInstance().getController(controllerConfig.controllerName)){
					(MagicStarControllerFactory.getInstance().getController(controllerConfig.controllerName) as AbstractController).terminateController();
				}
			}
		}
		
		public function getCurrentSectionState():Boolean{
			return this.sectionState[this.section];
		}
		
		public function get Section():String
		{
			return section;
		}
		
		public function set Section(value:String):void
		{
			section = value;
			if(this.section != "INIT"){
				this.moduleTerminate();
			}
			trace("进入"+section+"流程");
			this.execute();
		}
		
	}
}
class MagicStarSectionManagerPrivate{}