package magicstar.sys.res
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.sampler.getSize;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.Endian;
	
	
	import magicstar.sys.res.conf.MagicStarURLDB;
	import magicstar.sys.res.matter.SrcInfo;
	import magicstar.sys.until.Common;
	
	//巫星引擎，资源管理器
	public class MagicStarSrcStorage extends EventDispatcher
	{
		
		
		/**灰色滤镜**/
		private static var colorFilter:ColorMatrixFilter = new ColorMatrixFilter([ 0.5,0.5,0.082,0,0,0.5,0.5,0.082,0,0,0.5,0.5,0.082,0,0,0,0,0,1,0 ]);
		
		
		private var loader:Loader;//加载器
		private static var instance:MagicStarSrcStorage;
		public var loadQueArray:Array;
		public var srcStore:Dictionary;
		
		public var blankBitmap:Bitmap = new Bitmap;
		public var isLoading:Boolean = false;
		
		
		public var dataDic:Dictionary;
		
		
		public static function getInstance():MagicStarSrcStorage{
			if(!instance){
				instance = new MagicStarSrcStorage(new AvatarLoaderPrivate);
			}
			return instance;
		}
		
		public function MagicStarSrcStorage(avatarLoaderPrivate:AvatarLoaderPrivate)
		{
			this.srcStore = new Dictionary;
			
			this.dataDic = new Dictionary;
			
			this.loadQueArray = new Array;
			
		//	this.srcDataStore = new Dictionary;
		}
		
		
		
		/*******************************静态资源加载**********************************/
		
		public function loadQue(arr:Array):void{
			
			for(var i:int=0;i < arr.length;i++){
				this.loadQueArray.push(arr[i]);
			}
			if(!this.isLoading){
				this.loadConfig(this.loadQueArray.shift() as String);
			}
		}
		
		public function loadConfig(srcName:String):void{
			if(!srcName){
				trace("srcConfig null");
			}
			trace("srcName="+srcName);
			this.loadStatic(MagicStarURLDB.getInstance().getURL(srcName));
		}
		

		
		/**
		 * 
		 * 加载UI资源
		 * 
		 */ 
		private function loadStatic(url:String):void{
			this.isLoading = true;
			
		//	trace("load"+url+"前"+System.privateMemory/1024/1024+"  mb");
			this.loader = new Loader;
			this.loader.load(new URLRequest(url));
			this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,setData);
		}
		
		
		/**
		 * 
		 * 读取加载获得的资源
		 * 
		 */ 
		private function setData(event:Event):void{
			this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,setData);
			
			
		//	trace("load"+this.loader.contentLoaderInfo.url+"后"+System.privateMemory/1024/1024+"  mb");
			var bytes:ByteArray = event.currentTarget.bytes;
			

			
			var classRefArray:Array = this.analyseSWF(bytes);	
			
			
			for(var i:int = 0; i < classRefArray.length; i++){
				var className:String = classRefArray[i] as String;
				var RefClass:Class = this.loader.contentLoaderInfo.applicationDomain.getDefinition(className) as Class;
				var srcInfo:SrcInfo = new SrcInfo;
				srcInfo.srcName = className;
				srcInfo.refClass = RefClass;
				this.srcStore[srcInfo.srcName] = srcInfo;
			}
			this.loader.unload();
			this.loader = null;
			//MagicStarApplication.getInstance().gc();
			
			
		//	trace("清除后"+System.privateMemory/1024/1024+"  mb");
			if(this.loadQueArray.length > 0){
				this.loadConfig(this.loadQueArray.shift() as String);
			}else{
				this.isLoading = false;
				dispatchEvent(new Event("TASK_LOAD_COMPLETE"));
			}
		}
		
		

		
		
		
		/*******************************静态资源加载**********************************/
		
		
		
		
		
	
		
		
		public function disposeData(dataURL:String):Number{
			var data:BitmapData = this.dataDic[dataURL];
			var size:Number = 0;
			if(data){
				size = getSize(data);
			//	trace("size1="+size);
				data.dispose();
				//trace("size2="+getSize(data));
				delete this.dataDic[dataURL];
				data=null;
			}
			return size;
		}
		
		///////获取接口
		
		public function getData(dataURL:String):BitmapData{
			if(dataURL&&dataURL!="null"){
				//trace("dataURL="+dataURL);
				var data:BitmapData = this.dataDic[dataURL];
				//trace("data="+data);
				if(!data){
					var srcInfo:SrcInfo = this.srcStore[dataURL];
					data = (new srcInfo.refClass as BitmapData);
					this.dataDic[dataURL] = data;
					//return (new srcInfo.refClass as BitmapData);//(new (this.srcStore[dataURL] as Class) as BitmapData);
				}
				return data;
			}else{
				return this.blankBitmap.bitmapData;
			}
		}
		
		
		public function getOppsiteData(dataURL:String):BitmapData{
			if(dataURL&&dataURL!="null"){
				var data:BitmapData = this.dataDic[dataURL];
				if(!data){
					var srcInfo:SrcInfo = this.srcStore[dataURL];
					data = (new srcInfo.refClass as BitmapData);
					this.dataDic[dataURL] = data;
					//return (new srcInfo.refClass as BitmapData);//(new (this.srcStore[dataURL] as Class) as BitmapData);
				}
				return Common.getOppsite(data);
			}else{
				return this.blankBitmap.bitmapData;
			}
			
		}
		
		
		
		public function getMC(mcURL:String):MovieClip{
			var srcInfo:SrcInfo = this.srcStore[mcURL];
			if(srcInfo){
				return (new srcInfo.refClass as MovieClip);//(new (this.srcStore[mcURL] as Class) as MovieClip);
			}else{
				return null;
			}
		}
		
		public function getSrcInfo(srcName:String):SrcInfo{
			return this.srcStore[srcName];
		}
		
		/**
		 * 
		 * 取出带黑白滤镜的资源
		 * 
		 */
		public function getBlackWhiteData(dataURL:String):BitmapData{
			var data:BitmapData = this.getData(dataURL);
			var grayData:BitmapData = new BitmapData(data.width,data.height);
			grayData.applyFilter(data,new Rectangle(0,0,data.width,data.height),new Point(0,0),colorFilter);
			return grayData;
		}
		
		public function getDicSize():Number{
			var size:int;
			for each(var srcInfo:SrcInfo in this.srcStore){
				size += getSize(srcInfo);
				size += getSize(srcInfo.refClass);
				if(srcInfo.data){
					size += getSize(srcInfo.data);
				}
			}
			return (size/1024)/1024;
		}
		
		/**
		 * 
		 * 自动分析swf中包含的具体资源名称链接
		 * 
		 */
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
		
		
		/**
		 * 
		 * 判断url指向的资源是否已经加载
		 * 
		 */
		public function isLoaded(dataURL:String):Boolean{
			if(this.srcStore[dataURL]){
				return true;
			}
			return false;
		}
		
		
		
		
		
		
		
		
		
		
	}
}
class AvatarLoaderPrivate{}