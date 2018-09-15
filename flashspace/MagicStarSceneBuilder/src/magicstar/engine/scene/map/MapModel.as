package magicstar.engine.scene.map
{
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import magicstar.engine.scene.vo.BackGroundInfo;
	import magicstar.engine.scene.vo.OutLookInfo;
	import magicstar.sys.logger.MagicStarLogger;
	
	
	
	
	
	public class MapModel extends Sprite
	{	


		public var frontTileArray:Vector.<Tile>;
		
		
		public var rowsNum:int;
		public var colsNum:int;
		
		public var backArray:Array;
		public var outLookArray:Array;
		public var spaceArray:Array;
		
		public var fileLoader:URLLoader;
		
		public function MapModel()
		{
			MagicStarLogger.getInstance().showLog("系统：[MapModel]创建地图数据对象MapModel")
		}
		/**
		 * 
		 * 加载地图结构文件
		 * 
		 */
		public function loadMap(mapURL:String):void{
			MagicStarLogger.getInstance().showLog("系统：[MapModel]加载地图结构文件"+mapURL);
			var fileRequest:URLRequest = new URLRequest(mapURL);
			fileLoader = new URLLoader;
			fileLoader.dataFormat = URLLoaderDataFormat.TEXT;
			fileLoader.addEventListener(Event.COMPLETE,loadMapInfo);
			fileLoader.load(fileRequest);
		}
		
		
		/**
		 * 
		 * 地图结构文件加载完毕
		 * 
		 */
		public function loadMapInfo(event:Event):void{
			MagicStarLogger.getInstance().showLog("系统：[MapModel]加载地图结构文件完成，开始分析地图文件");
			fileLoader.removeEventListener(Event.COMPLETE,loadMapInfo);
			var xml:XML = new XML(event.target.data);
			this.colsNum = parseInt(xml.colNum);//取得地图列数
			this.rowsNum = parseInt(xml.rowNum);//取得地图行数
			var mapSpace:String = xml.mark;//地图的连通性（可通行性）矩阵
			this.spaceArray = mapSpace.split(",");//获得地图连通性的数据，保存在数组中，用于执行时判断是否可通行
			
			/**
			 * 
			 * 创建背景层地图的所有可视单元（图片或动画）。name可以找到具体资源。可视单元在地图中的具体位置。type有三种：1.普通图片。2.movieclip。
			 * 
			 */
			MagicStarLogger.getInstance().showLog("系统：[MapModel]解析地图背景层信息");
			this.backArray = new Array;
			for(var i:int=0;i < xml.BackGrounds.BackGround.length();i++){
				var backGroundInfo:BackGroundInfo = new BackGroundInfo;
				backGroundInfo.url = xml.BackGrounds.BackGround[i].@name;
				backGroundInfo.type = xml.BackGrounds.BackGround[i].@type;
				backGroundInfo.posX = xml.BackGrounds.BackGround[i].@x;
				backGroundInfo.posY = xml.BackGrounds.BackGround[i].@y;
				var opposideBack:String = xml.BackGrounds.BackGround[i].@opposide;
				if(opposideBack=="true"){
					backGroundInfo.opposide = true;
				}else{
					backGroundInfo.opposide = false;
				}
				this.backArray.push(backGroundInfo);
			}
			
			/**
			 * 
			 * 创建前景层的所有可视单元。同上
			 * 
			 */
			MagicStarLogger.getInstance().showLog("系统：[MapModel]解析地图前景层信息");
			this.outLookArray = new Array;
			
			for(var n:int=0;n < xml.OutLooks.OutLook.length();n++){
				var outLookInfo:OutLookInfo = new OutLookInfo;
				outLookInfo.url = xml.OutLooks.OutLook[n].@name;
				outLookInfo.type = xml.OutLooks.OutLook[n].@type;
				outLookInfo.posX = xml.OutLooks.OutLook[n].@x;
				outLookInfo.posY = xml.OutLooks.OutLook[n].@y;
				var opposideOut:String = xml.OutLooks.OutLook[n].@opposide;
				if(opposideOut=="true"){
					outLookInfo.opposide = true;
				}else{
					outLookInfo.opposide = false;
				}
				this.outLookArray.push(outLookInfo);
			}
			
			
			
			/**
			 * 
			 * 初始化地图数据model
			 * 
			 */
			this.initMapModel();
		}
		
		
		
		
		
		
		
		
		/**
		 * 
		 * 初始化地图tilebase的结构数据
		 * 
		 */ 
		public function initMapModel(event:Event=null):void{
			
			MagicStarLogger.getInstance().showLog("系统：[MapModel]开始初始化地图数据");
			
			/**
			 * 
			 * 创建tile。
			 * 
			 */
			MagicStarLogger.getInstance().showLog("系统：[MapModel]开始创建tilebase的tile数组");
			this.frontTileArray = new Vector.<Tile>;
			for(var i:int = 0;i < this.spaceArray.length;i++){
				
				var frontMapTile:Tile = new Tile(this.spaceArray[i]);
				frontMapTile.row = Math.floor(i/this.colsNum);
				frontMapTile.cols = Math.floor(i%this.colsNum);
				this.frontTileArray.push(frontMapTile);
				
			}
			
			MagicStarLogger.getInstance().showLog("系统：[MapModel]开始初始化地图完成，产生INIT_COMPLETE事件")
			dispatchEvent(new MapLoaderEvent(MapLoaderEvent.INIT_COMPLETE));
		}
		
		
		/**
		 * 
		 * 通过行和列获得地图tile
		 * 
		 */ 
		public function getFrontTile(row:int,cols:int):Tile{
			return (this.frontTileArray[row*this.colsNum+cols] as Tile);
		}
	}
}