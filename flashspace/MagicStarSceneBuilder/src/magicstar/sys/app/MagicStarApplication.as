
package magicstar.sys.app
{
	
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import flash.net.LocalConnection;
	import flash.system.Capabilities;
	import flash.system.System;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	import magicstar.sys.logger.MagicStarLogger;
	import magicstar.sys.res.MagicStarSrcStorage;

	//【20180721】此对象需要进行改造。
    //巫星引擎，应用实体。包括：舞台，应用级别的接口方法。总显示舞台。通过舞台缩放等，适配不同设备的显示屏幕。
	public class MagicStarApplication
	{
		
		private static var instance:MagicStarApplication;
		private var currentStage:Stage;
		public var rootStage:DisplayObjectContainer;
		
		
		public var viewWidth:Number = 1280;
		public var viewHeight:Number = 720;
		
		//【20180607】退出句柄
		public var onQuiteApp:Function;
		
		public var seneceLayer:Sprite;
		public var uiLayer:Sprite;
		public var systemLayer:Sprite;
		
		//是否自动适配屏幕
		public var isAutoDisplay:Boolean = false;
		
		
		//【20180607】当前角色所在的行和列？为什么在这儿？当年是怎么考虑的？
		public var currentCol:int;
		public var currentRow:int;
		
		
		//【20180607】测试模式标识
		public var flagTest:Boolean = false;
		
		//【20180607】解压所需要的时间由此字段记录
		public var zipTime:uint=0;
		
		public static function getInstance():MagicStarApplication{
			if(!instance){
				instance = new MagicStarApplication(new WebApplicationPrivate);
			}
			return instance;
		}
		
		//【20180607】构造函数，直接创建游戏显示体系。其中包括三层，最终这个显示列表体系将被加载到舞台上。
		public function MagicStarApplication(param:WebApplicationPrivate)
		{
			this.rootStage = new Sprite;
			
			this.seneceLayer = new Sprite;
			this.uiLayer = new Sprite;
			this.systemLayer = new Sprite;
			
			this.rootStage.addChildAt(this.seneceLayer,0);
			this.rootStage.addChildAt(this.uiLayer,1);
			this.rootStage.addChildAt(this.systemLayer,2);
			
	     //【20180607】这是当时考虑的垃圾回收机制。为什么废弃了呢？
		//	this.timer.addEventListener(TimerEvent.TIMER,this.gc);
		//	this.timer.start();
			MagicStarLogger.getInstance().showLog("系统【MagicStarApplication】：应用实体创建成功");
		} 
		
		
		
		
		public function get CurrentStage():Stage
		{
			return currentStage;
		}
		
		public function set CurrentStage(value:Stage):void
		{
			MagicStarLogger.getInstance().showLog("系统【MagicStarApplication】：初始化舞台");
			currentStage = value;
			currentStage.addChild(this.rootStage);
			this.addBrowserListener();
			//【20180607】在此监听手机退出按钮事件。
			this.currentStage.addEventListener(KeyboardEvent.KEY_DOWN,onKey);
		}
		
		private function onKey(event:KeyboardEvent):void{
			if(event.keyCode == Keyboard.BACK){
				if(this.onQuiteApp!=null){
					this.onQuiteApp();//退出应用
				}
				
			}
		}
		
		
		private function addBrowserListener():void{
			this.currentStage.addEventListener(Event.RESIZE,onResize);
		}
		
		
		
		public var magicStarScaleX:Number = 1;
		public var magicStarScaleY:Number = 1;
		
		
		
		private function onResize(event:Event):void{
			
			magicStarScaleX = 1;
			magicStarScaleY = 1;
			
			
			//trace("Capabilities.screenResolutionX="+Capabilities.screenResolutionX);
			//trace("Capabilities.screenResolutionY="+Capabilities.screenResolutionY);
			
			
			/*var screenWidth:Number = 2048;
			var screenHeight:Number = 1536;*/
			
			/*var screenWidth:Number = 960;
			var screenHeight:Number = 640;*/
			
			/*var screenWidth:Number = 800;
			var screenHeight:Number = 480;*/
			
			
			/*var screenWidth:Number = 1280;
			var screenHeight:Number = 720;*/
			
			
			/*var screenWidth:Number = 1136;
			var screenHeight:Number = 640;*/
			
			var screenWidth:Number;
			var screenHeight:Number;
			
			
			if(this.isAutoDisplay){
				screenWidth = Capabilities.screenResolutionX;
				screenHeight = Capabilities.screenResolutionY;
			}else{
				screenWidth = 1280;
				screenHeight = 720;
			}
			
			
			
			if(screenHeight > screenWidth){
				var temp:Number = screenHeight;
				screenHeight = screenWidth;
				screenWidth = temp;
			}
			
			
			//this.currentStage.color = 0x000000;
			
			magicStarScaleX = screenWidth/this.viewWidth;
			magicStarScaleY = screenHeight/this.viewHeight;	
			
			if(magicStarScaleY<magicStarScaleX){
				magicStarScaleX = magicStarScaleY;
				this.rootStage.x = (screenWidth-viewWidth*magicStarScaleX)/2; 
				this.rootStage.y = 0;
			}else{
				magicStarScaleY = magicStarScaleX;
				this.rootStage.y = (screenHeight-viewHeight*magicStarScaleY)/2; 
				this.rootStage.x = 0;
			}
			
			
			//无论舞台内容由多大，都以此大小为视口，这是很显示的关键代码。
			this.rootStage.scrollRect = new Rectangle(0,0,this.viewWidth,this.viewHeight);
				
			
			this.rootStage.scaleX = magicStarScaleX;
			this.rootStage.scaleY = magicStarScaleY;
			
			
			
		
		}
		
		public function onFullScreen(event:Event=null):void{
			this.currentStage.displayState=StageDisplayState.FULL_SCREEN; 
		}
		
		public function onNormalScreen(event:Event=null):void{
			this.currentStage.displayState=StageDisplayState.NORMAL; 
		}
		
		
		public var timer:Timer = new Timer(10000);
		
		public var srcSize:Number;
		
		public var clipSize:Number;
		
		public function gc(event:Event=null):void{
			
			
		//	MagicStarClipManager.getInstance().clearClipPool();
			
			srcSize = MagicStarSrcStorage.getInstance().getDicSize();
			MagicStarLogger.getInstance().showLog("系统【MagicStarApplication】：调用垃圾处理机制");
			try{ 
				System.gc();
				new LocalConnection ().connect ( "gc" ); new LocalConnection ().connect ( "gc" ); 
			}catch(e:Error){
			}
		}
		
		
		
		
		
		
	}
}

class WebApplicationPrivate{}