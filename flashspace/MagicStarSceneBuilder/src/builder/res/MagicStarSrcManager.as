package builder.res
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.Endian;
	import builder.windows.data.VersionVo;

	public class MagicStarSrcManager extends EventDispatcher
	{
		
		private static var instance:MagicStarSrcManager;
		public var loader:Loader;
		public var loadArray:Array;
		
		public var currentVersionVo:VersionVo;
		
		
		public var srcStore:Dictionary;
		
		
		
		public var blankBitmap:Bitmap = new Bitmap;
		
		
		public static function getInstance():MagicStarSrcManager{
			if(!instance){
				instance = new MagicStarSrcManager(new MapBuilderSrcManagerPrivate);
			}
			return instance;
		}
		/**
		 * 
		 * 用于加载存储库资源
		 * 
		 */
		public function MagicStarSrcManager(param:MapBuilderSrcManagerPrivate)
		{
			this.loader = new Loader;
			this.srcStore = new Dictionary;
		}
		
		/**
		 * 
		 * 生成加载队列，并进行加载
		 * 
		 */
		public function initLoadQue(array:Array):void{
			loadArray = array;
			this.loadStore();
		}
		/**
		 * 
		 * 加载
		 * 
		 */
		public function loadStore():void{
			if(this.loadArray.length>0){//对文件一个一个加载
				this.currentVersionVo = this.loadArray.shift();
				this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,setData);
				this.loader.load(new URLRequest(this.currentVersionVo.fileURL));
			}else{
				dispatchEvent(new Event("TASK_LOAD_COMPLETE"));//加载完毕
			}
		}
		/**
		 * 
		 * 将加载到的资源存储入库
		 * 
		 */
		public function setData(event:Event):void{
			this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,setData);
			
			
			var bytes:ByteArray = event.currentTarget.bytes;
			var classRefArray:Array = this.analyseSWF(bytes);//分析swf中有多少具体资源对象
			
			
			
			for(var i:int = 0; i < classRefArray.length; i++){
				var className:String = classRefArray[i] as String;
				var RefClass:Class = this.loader.contentLoaderInfo.applicationDomain.getDefinition(className) as Class;
				this.srcStore[className] = RefClass;
			}
			
			this.loadStore();//将所有资源递归加载完
			
		}
		
		
		
		private function analyseSWF(bytes:ByteArray):Array{
			
			var classRefArray:Array = new Array; 
			
			var id:int;
			var head:int;
			var size:int;
			var i:int;
			var name:String;
			var len:int;
			var lastPosition:int;
			var num:int;
			var type:int;
			bytes.endian = Endian.LITTLE_ENDIAN;
			bytes.position = Math.ceil(((bytes[8]>>1)+5)/8)+12;
			while(bytes.bytesAvailable>0)//字节数组剩余可读数据长度大于2个字节
			{
				head = bytes.readUnsignedShort();//读取tag类型
				size = head&63;//判断低6位的值是否是63，如果是，这个tag的长度就是下面的32位整数，否则就是head的低6位
				if (size == 63)size=bytes.readInt();
				type = head>>6;
				if(type != 76)
				{
					bytes.position += size;
				}
				else
				{
					num = bytes.readShort();
					for(i=0; i<num; i++)
					{
						id = bytes.readShort();//读取tag ID
						lastPosition = bytes.position;
						while(bytes.readByte() != 0){
							//读到字符串的结束标志
						}
						len = bytes.position - lastPosition;
						bytes.position = lastPosition;
						name = bytes.readUTFBytes(len).toString();
						classRefArray.push(name);
						//trace("连接名："+name);
					}
				}
			}
			return classRefArray;
		}
		
		
		public function getData(dataURL:String):BitmapData{
			if(dataURL&&dataURL!="null"){
				return (new (this.srcStore[dataURL] as Class) as BitmapData);
			}else{
				return this.blankBitmap.bitmapData;
			}
		}
		
		public function getMC(mcURL:String):MovieClip{
			return (new (this.srcStore[mcURL] as Class) as MovieClip);
		}
		
		
		
	}
}
class MapBuilderSrcManagerPrivate{}