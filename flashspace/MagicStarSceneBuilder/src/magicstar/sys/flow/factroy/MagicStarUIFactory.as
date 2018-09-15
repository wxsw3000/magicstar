package magicstar.sys.flow.factroy
{
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	
	import magicstar.sys.flow.conf.vo.MagicStarSectionConfigVo;
	import magicstar.sys.flow.conf.vo.MagicStarUIConfigVo;
	import magicstar.sys.flow.conf.MagicStarSectionDB;
	import magicstar.sys.res.MagicStarSrcStorage;
	import magicstar.sys.flow.MagicStarSectionProcessor;

    //巫星引擎，UI工厂。管理UI对象的生命周期。存储UI对象。
	public class MagicStarUIFactory extends EventDispatcher
	{
		
		private var uiStore:Dictionary;
		private static var instance:MagicStarUIFactory;
		public var registerUI:Function;
		
		public static function getInstance():MagicStarUIFactory{
			if(!instance){
				instance = new MagicStarUIFactory(new MagicUIManagerPrivate);
			}
			return instance;
		}
		
		public function MagicStarUIFactory(magicUIManagerPrivate:MagicUIManagerPrivate)
		{
			this.uiStore = new Dictionary;
			if(registerUI!=null){
				this.registerUI();
			}
		}
		/**
		 * 
		 * 模块对UI的建立流程进行检查和创建(为获取UI)
		 * 
		 */ 
		public function doUIObtainProcess():void{
			if(!MagicStarSectionProcessor.getInstance().getCurrentSectionState()){
				this.loadUISrc();
			}else{
				MagicStarControllerFactory.getInstance().doControllerObtainProcess();//ui已经创建，进行控制器创建
			}
		}
		
		
		/**
		 * 
		 * 通过流程标志控制ui资源加载
		 * 
		 */ 
		private function loadUISrc():void{
			
			trace("ProcessManager.getInstance().Section="+MagicStarSectionProcessor.getInstance().Section);
			var currentSectionConfig:MagicStarSectionConfigVo = MagicStarSectionDB.getInstance().sectionConfigDic[MagicStarSectionProcessor.getInstance().Section] as MagicStarSectionConfigVo;
			trace("currentSectionConfig.srcConfigArray.length="+currentSectionConfig.srcConfigArray.length);
			if(currentSectionConfig.srcConfigArray.length > 0){
				MagicStarSrcStorage.getInstance().addEventListener("TASK_LOAD_COMPLETE",loadUISrcComplete);
				MagicStarSrcStorage.getInstance().loadQue(currentSectionConfig.srcConfigArray);
			}else{//模块可能没有需要加载的资源
				this.loadUISrcComplete(null);
			}
			
		}
		
		/**
		 * 
		 * UI资源加载完成并创建本流程所需UI
		 * 
		 */ 
		private function loadUISrcComplete(event:Event=null):void{
			MagicStarSrcStorage.getInstance().removeEventListener("TASK_LOAD_COMPLETE",loadUISrcComplete);
			var currentSectionConfig:MagicStarSectionConfigVo = MagicStarSectionDB.getInstance().sectionConfigDic[MagicStarSectionProcessor.getInstance().Section] as MagicStarSectionConfigVo;
			for(var i:int = 0;i < currentSectionConfig.uiConfigArray.length;i++){
				var uiConfig:MagicStarUIConfigVo = currentSectionConfig.uiConfigArray[i] as MagicStarUIConfigVo;
				this.createUI(uiConfig.uiName,uiConfig.classRef);
			}
			MagicStarControllerFactory.getInstance().doControllerObtainProcess();//ui创建完毕，进行控制器创建
		}
		
		/**
		 * 
		 * 创建UI
		 * 
		 */ 
		private function createUI(uiName:String,classRef:String):void{
			if(!this.getUI(uiName)){
				trace("classRef="+classRef);
				var refClass:Class = getDefinitionByName(classRef) as Class;
				this.uiStore[uiName] = new refClass;
			}
		}
		
		/**
		 * 
		 * 通过UI名称获取UI
		 * 
		 */ 
		public function getUI(uiName:String):*{
			return this.uiStore[uiName];
		}
		
		
		
	}
}
class MagicUIManagerPrivate{}