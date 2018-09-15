package magicstar.sys.flow.factroy
{
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	
	import magicstar.sys.flow.conf.vo.MagicStarControllerConfigVo;
	import magicstar.sys.flow.conf.vo.MagicStarSectionConfigVo;
	import magicstar.sys.flow.conf.MagicStarSectionDB;
	import magicstar.sys.flow.MagicStarSectionProcessor;

	//巫星引擎，控制器工厂。管理controller对象的生命周期。存储controller对象。
	public class MagicStarControllerFactory
	{
		public var controllerStore:Dictionary;
		private static var instance:MagicStarControllerFactory;
		public var registerController:Function;
		
		public static function getInstance():MagicStarControllerFactory{
			if(!instance){
				instance = new MagicStarControllerFactory(new ControllerManagerPrivate);
			}
			return instance;
		}
		
		public function MagicStarControllerFactory(controllerManagerPrivate:ControllerManagerPrivate)
		{
			this.controllerStore = new Dictionary;
			if(registerController!=null){
				this.registerController();
			}
		}
		
		/**
		 * 
		 * 模块对控制器的建立流程进行检查和创建（为获取控制器）
		 * 
		 */ 
		public function doControllerObtainProcess():void{
			trace("ProcessManager.getInstance().getCurrentSectionState()="+MagicStarSectionProcessor.getInstance().getCurrentSectionState());
			if(!MagicStarSectionProcessor.getInstance().getCurrentSectionState()){
				this.createSectionControllers();
			}else{//控制器已经创建好，直接进入模块启动
				MagicStarSectionProcessor.getInstance().processCreateComplete();
			}
		}
		
		/**
		 * 
		 * 本流程各控制器创建
		 * 
		 */ 
		public function createSectionControllers():void{
			
			//创建控制器
			var currentSectionConfig:MagicStarSectionConfigVo = MagicStarSectionDB.getInstance().sectionConfigDic[MagicStarSectionProcessor.getInstance().Section];
			for(var i:int = 0;i < currentSectionConfig.controllerConfigArray.length;i++){
				var controllerConfig:MagicStarControllerConfigVo = currentSectionConfig.controllerConfigArray[i] as MagicStarControllerConfigVo;
				this.createController(controllerConfig.controllerName,controllerConfig.classRef);
			}
			MagicStarSectionProcessor.getInstance().processCreateComplete();
		}
		
		/**
		 * 
		 * 
		 * 创建单个控制器
		 * 
		 */ 
		public function createController(cName:String,classRef:String):void{
			trace("cName="+cName);
			trace("classRef="+classRef);
			if(!this.getController(cName)){
				var refClass:Class = getDefinitionByName(classRef) as Class;
				this.controllerStore[cName] = new refClass;
			}
		}
		
		public function getController(controllerName:String):*{
				return this.controllerStore[controllerName];
		}
	}
}
class ControllerManagerPrivate{}