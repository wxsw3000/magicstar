package magicstar.sys.conf
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import magicstar.sys.flow.conf.MagicStarSectionDB;
	import magicstar.sys.logger.MagicStarLogger;
	import magicstar.sys.res.conf.MagicStarURLDB;
	
	/**
	 * 
	 * 巫星引擎，配置内容库。存储了所有配置文件内容。同时在此处完成了URL库的加载。需要修改。
	 * 
	 */
	public class MagicStarConfigDB extends EventDispatcher
	{
		
		private static var instance:MagicStarConfigDB;
		private var loader:URLLoader;//用于加载配置文件的加载器
		private var configNameArray:Array;//配置库中的所有配置名称
		private var currentLoadConfigName:String;//当前加载的配置的名称
		private var _configDic:Dictionary;//存储所有配置文件内容的结构
		public var configCompleteFunc:Function;//配置完成，进行下一步回调的句柄
		
		public static function getInstance():MagicStarConfigDB{
			if(!instance){
				instance = new MagicStarConfigDB(new ConfigLoaderPrivate);
			}
			return instance;
		}
		
		public function MagicStarConfigDB(param:ConfigLoaderPrivate)
		{
			this.loader = new URLLoader;
			this._configDic = new Dictionary;
		}
		
		
		/**
		 * 加载配置库配置文件config
		 */
		public function loadConfigStore():void{
			MagicStarLogger.getInstance().showLog("系统【MagicStarConfigDB】：开始加载配置列表文件config");
			this.loader.addEventListener(Event.COMPLETE,readConfigXML);
			loader.load(new URLRequest(MagicStarURLDB.getInstance().getURL("config")));//【20180607】从资源url管理文件中读出名为config的配置文件注册文件。此文件中注册了所有的配置文件资源，是配置文件资源的名称列表。
		}
		
		/**
		 * 读取配置库配置文件
		 */
		public function readConfigXML(event:Event):void{
			loader.removeEventListener(Event.COMPLETE,readConfigXML);//【20180607】将配置文件列表信息读取出来，存入数组this.configNameArray.
			var xml:XML = new XML(event.currentTarget.data);
			this.configNameArray = new Array;
			for(var i:int = 0;i < xml.config.length();i++){
				var configName:String = xml.config[i].@src;
				this.configNameArray.push(configName);
			}
			MagicStarLogger.getInstance().showLog("系统【MagicStarConfigDB】：通过config文件，确定所有配置的文件列表");
			MagicStarLogger.getInstance().showLog("系统【MagicStarConfigDB】：开始加载配置文件列表中的每一个配置文件");
			this.loadEveryConfigXML();//【20180607】开始对每一个配置文件进行加载，具体在方法内使用了递归。
		}
		/**
		 * 加载配置库中的每一个配置文件
		 */
		public function loadEveryConfigXML():void{
			if(this.configNameArray.length>0){
				this.currentLoadConfigName = this.configNameArray.shift();
				MagicStarLogger.getInstance().showLog("系统【MagicStarConfigDB】：开始加载文件"+this.currentLoadConfigName);
				this.loader.addEventListener(Event.COMPLETE,this.setConfigData);
				loader.load(new URLRequest(MagicStarURLDB.getInstance().getURL(this.currentLoadConfigName)));
			}else{
				this.createSysConfigManagers();
			}
		}
		/**
		 * 将每个配置文件数据存入库中
		 */ 
		public function setConfigData(event:Event):void{
			loader.removeEventListener(Event.COMPLETE,setConfigData);
			var xml:XML = new XML(event.currentTarget.data);
			this._configDic[this.currentLoadConfigName] = xml;
			MagicStarLogger.getInstance().showLog("系统【MagicStarConfigDB】：完成加载文件"+this.currentLoadConfigName);
			this.loadEveryConfigXML();//递归遍历
		}
		
		/**
		 * 对系统配置文件进行加载和配置
		 */
		public function createSysConfigManagers():void{
			MagicStarLogger.getInstance().showLog("系统【MagicStarConfigDB】：config文件中配置的所有配置文件加载完毕，开始初始化");
			MagicStarSectionDB.getInstance().setXML(this.configDic[MagicStarSectionDB.getInstance().configName]);
			MagicStarLogger.getInstance().showLog("系统【MagicStarConfigDB】：系统配置文件初始化完毕");
			if(configCompleteFunc!=null){
				this.configCompleteFunc();
			}
		}
		/**
		 * 只读/only read
		 */
		public function get configDic():Dictionary
		{
			return _configDic;
		}
		
		
	}
}
class ConfigLoaderPrivate{}