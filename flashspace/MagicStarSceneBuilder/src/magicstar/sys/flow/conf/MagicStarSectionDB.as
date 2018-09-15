package magicstar.sys.flow.conf
{
	import flash.utils.Dictionary;
	
	import magicstar.sys.flow.conf.vo.MagicStarControllerConfigVo;
	import magicstar.sys.flow.conf.vo.MagicStarSectionConfigVo;
	import magicstar.sys.flow.conf.vo.MagicStarUIConfigVo;
	import magicstar.sys.logger.MagicStarLogger;

    /**
	 * 
	 * 业务流程配置库
	 * 
	 */
	public class MagicStarSectionDB
	{
		private static var instance:MagicStarSectionDB;
		
		private var _sectionConfigDic:Dictionary;
		public var configName:String = "sections";

		public static function getInstance():MagicStarSectionDB{
			if(!instance){
				instance = new MagicStarSectionDB(new MagicStarSectionConfigManagerPrivate);
			}
			return instance;
		}
		
		public function MagicStarSectionDB(param:MagicStarSectionConfigManagerPrivate)
		{
			this._sectionConfigDic = new Dictionary;
		}
		
		
		public function setXML(xml:XML):void{
			
			MagicStarLogger.getInstance().showLog("系统【MagicStarSectionDB】：初始化业务流程配置库");
			
			for(var i:int = 0; i < xml.flow.section.length();i++){
				var sectionConfig:MagicStarSectionConfigVo = new MagicStarSectionConfigVo;
				sectionConfig.sectionName = xml.flow.section[i].@sectionName;//流程名称
				for(var j:int = 0; j < xml.flow.section[i].ui.length();j++){
					var uiConfig:MagicStarUIConfigVo = new MagicStarUIConfigVo;
					uiConfig.uiName = xml.flow.section[i].ui[j].@uiName;
					uiConfig.classRef = xml.flow.section[i].ui[j].@classRef;
					sectionConfig.uiConfigArray.push(uiConfig);
				}
				
				for(var k:int = 0; k < xml.flow.section[i].controller.length();k++){
					
					var controllerConfig:MagicStarControllerConfigVo = new MagicStarControllerConfigVo;
					controllerConfig.controllerName = xml.flow.section[i].controller[k].@cName;
					controllerConfig.classRef = xml.flow.section[i].controller[k].@classRef;
					sectionConfig.controllerConfigArray.push(controllerConfig);
				}
				for(var n:int = 0; n < xml.flow.section[i].src.length();n++){
					var srcName:String = xml.flow.section[i].src[n].@srcName;
					sectionConfig.srcConfigArray.push(srcName);
				}
				this._sectionConfigDic[sectionConfig.sectionName] = sectionConfig;//将sectionconfig放进字典
				MagicStarLogger.getInstance().showLog("系统【MagicStarSectionDB】：初始化业务流程"+sectionConfig.sectionName);
			}
			MagicStarLogger.getInstance().showLog("系统【MagicStarSectionDB】：初始化业务流程配置库完成");
		}
		
		/**
		 * 只读/only read
		 */
		public function get sectionConfigDic():Dictionary
		{
			return _sectionConfigDic;
		}
		
	}
}
class MagicStarSectionConfigManagerPrivate{}