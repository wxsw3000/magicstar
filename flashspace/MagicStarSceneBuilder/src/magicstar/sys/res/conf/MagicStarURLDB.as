package magicstar.sys.res.conf
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.sampler.getSize;
	import flash.utils.Dictionary;
	
	import magicstar.sys.logger.MagicStarLogger;
	import magicstar.sys.res.conf.vo.MagicStarLoaderConfigVo;

	/**
	 * 
	 * 巫星引擎，url路径管理
	 * 
	 */
	public class MagicStarURLDB
	{
		
		private static var instance:MagicStarURLDB;
		private var loader:URLLoader;//用于加载loadconfig的加载器
		public var srcConfigDic:Dictionary;
		public var rootURL:String = "../assets";
		public var createComplete:Function;//创建url库完成
		
		
		public static function getInstance():MagicStarURLDB{
			if(!instance){
				instance = new MagicStarURLDB(new MagicStarURLManagerPrivate);
			}
			return instance;
		}
		
		public function MagicStarURLDB(param:MagicStarURLManagerPrivate)
		{
			this.loader = new URLLoader;
			this.srcConfigDic = new Dictionary;
		}
		
		
		
		/**
		 * 加载资源加载列表文件loadconfig，这个文件是包含了所有资源的url，并使用资源的文件名来寻址。所有文件名不能重复。
		 */
		public function loadLoadURLStore():void{
			MagicStarLogger.getInstance().showLog("系统【MagicStarURLDB】：开始加载总资源URL列表文件loadconfig");
			loader.addEventListener(Event.COMPLETE,readRootXML);
			loader.load(new URLRequest(this.rootURL+"/loadconfig.xml"));
		}
		
		/**
		 * 读取资源加载列表文件loadconfig
		 */
		public function readRootXML(event:Event):void{
			
			loader.removeEventListener(Event.COMPLETE,readRootXML);
			var xml:XML = new XML(event.currentTarget.data);
			MagicStarLogger.getInstance().showLog("系统【MagicStarURLDB】：loadconfig加载完成");
			this.setXML(xml);//【20180607】资源URL管理器初始化，并将资源URL管理文件中的配置信息读入。
			
			if(createComplete!=null){
				this.createComplete();
			}
		}
		public function setXML(xml:XML):void
		{
			MagicStarLogger.getInstance().showLog("系统：loadconfig信息占用内存"+getSize(xml)/1024/1024+"mb");
			
			for(var i:int = 0;i < xml.loadInfo.length();i++){
				var srcConfigVo:MagicStarLoaderConfigVo = new MagicStarLoaderConfigVo;
				srcConfigVo.loadName = xml.loadInfo[i].@name;
				var url:String = xml.loadInfo[i].@url;
				srcConfigVo.loadURL = this.rootURL + url.split("\\").join("/");
				this.srcConfigDic[srcConfigVo.loadName] = srcConfigVo;
			}
			MagicStarLogger.getInstance().showLog("系统【MagicStarURLDB】：初始化URL路径库完成");
		}
		
		public function getURL(urlName:String):String{
			var srcConfigVo:MagicStarLoaderConfigVo = this.srcConfigDic[urlName];
			if(srcConfigVo){
				return srcConfigVo.loadURL;
			}else{
				MagicStarLogger.getInstance().showLog(urlName+"的url等于null");
				return null;
			}
		}
	} 
}
class MagicStarURLManagerPrivate{}