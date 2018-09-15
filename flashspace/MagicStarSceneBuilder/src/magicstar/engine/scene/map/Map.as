package magicstar.engine.scene.map
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.system.System;
	import flash.utils.Dictionary;
	import magicstar.engine.core.TaskManager;
	import magicstar.engine.core.executor.Task;
	import magicstar.engine.scene.vo.BackGroundInfo;
	import magicstar.engine.scene.vo.OutLookInfo;
	import magicstar.sys.app.MagicStarApplication;
	import magicstar.sys.logger.MagicStarLogger;
	import magicstar.sys.res.MagicStarSrcStorage;
	

	public class Map extends Sprite
	{
		
		public var mapModel:MapModel;//地图的数据
		public var mapRows:int;
		public var mapCols:int;
		public var tileWidth:Number;
		public var tileHeight:Number;
		public var frontSprite:Sprite;
		public var groundSprite:Sprite;
		public var groundBitmapData:BitmapData;//用于优化地图的，静态地图底层的底图对象
		public var effectLayer:Sprite;
		public var mapWidth:int;
		public var mapHeight:int;
		public var viewWidth:Number;
		public var viewHeight:Number;
		public var mapObjList:Array;
		private var task:Task;
		public var bigMap:Bitmap;
		
		
		public function Map(url:String)
		{
			MagicStarLogger.getInstance().showLog("系统：[MAP]调用MAP的构造函数，创建MAP")
				
			this.mapModel = new MapModel;
			
			this.mapModel.addEventListener(MapLoaderEvent.INIT_COMPLETE,loadMapElements);
			this.mapModel.loadMap(url);
			
			this.mapObjList = new Array;//地图中物件存放的列表
			
			/**
			 * 
			 * 初始化执行单元
			 * 
			 */
			this.task = new Task;
			this.task.execute = this.sortDeep;
			
		}
		/**
		 * 
		 * 判断是否要加载地图元素，在加载完地图资源后准备创建地图
		 * 
		 */
		public function loadMapElements(event:Event):void{
			MagicStarLogger.getInstance().showLog("系统：[MAP]准备加载地图元素（相关美术资源）")
			MagicStarSrcStorage.getInstance().removeEventListener("TASK_LOAD_COMPLETE",loadMapElements);
			if(!MagicStarSrcStorage.getInstance().isLoading){//如果当前资源库正没有其他任务，则计算出需要加载的地图资源
				var unLoadedArray:Array = this.getMapUnLoadedElementsArray();
				if(unLoadedArray.length>0){//如果由需要加载地图资源，则将资源加入加载队列，加载完毕侯创建地图
					MagicStarSrcStorage.getInstance().addEventListener("TASK_LOAD_COMPLETE",createMap);
					MagicStarSrcStorage.getInstance().loadQue(unLoadedArray);
				}else{//没有需要加载的地图资源，直接创建地图
					this.createMap();
				}
			}else{//如果当前资源库正在加载其他任务，则等待其他任务加载完毕再进行当前加载任务
				MagicStarSrcStorage.getInstance().addEventListener("TASK_LOAD_COMPLETE",loadMapElements);
			}
		}

		
		
		
		/**
		 * 
		 * 这个方法是找出没有加载的元素么？我自己在【20180721】提问
		 * 
		 */
		public function getMapUnLoadedElementsArray():Array{
			var unLoadedArray:Array = new Array;
			
			var filterDic:Dictionary = new Dictionary;
			
			/**
			 * 
			 * 对背景层资源进行判断，判断是否需要加载
			 * 
			 */
			for(var i:int = 0;i < this.mapModel.backArray.length;i++){//[20180724]仿佛之前并没有实现清除的任务，当前待观察。每次绘制地图，将所有地图所需资源重新加载,并在绘制好后景层后清除（后景层为统一整图）
				var backGroundInfo:BackGroundInfo = this.mapModel.backArray[i];
				if(!MagicStarSrcStorage.getInstance().isLoaded(backGroundInfo.url)&&!filterDic[backGroundInfo.url]){//背景所需资源需要满足还未加载且不再过滤库中（为了解决一张地图中复用的资源重复加载），才能被放入待加载队列中
					filterDic[backGroundInfo.url] = true;
					unLoadedArray.push(backGroundInfo.url);
				}
			}
			
			/**
			 * 
			 * 对前景层资源进行判断，判断是否需要加载
			 * 
			 */
			for(var n:int = 0;n < this.mapModel.outLookArray.length;n++){
				var outLookInfo:OutLookInfo = this.mapModel.outLookArray[n];
				if(!MagicStarSrcStorage.getInstance().isLoaded(outLookInfo.url)&&!filterDic[outLookInfo.url]){
					filterDic[outLookInfo.url] = true;
					unLoadedArray.push(outLookInfo.url);
				}
			}
			
			/**
			 * 
			 * 返回当前地图还需要加载的资源
			 * 
			 */
			return unLoadedArray;
		}
		/**
		 * 
		 * 创建地图
		 * 
		 */
		public function createMap(event:Event=null):void{
			MagicStarSrcStorage.getInstance().removeEventListener("TASK_LOAD_COMPLETE",createMap);
			this.mapRows = this.mapModel.rowsNum;
			this.mapCols = this.mapModel.colsNum;
			this.tileWidth = 80;
			this.tileHeight = 80;
			this.groundSprite = new Sprite;//底层容器
			this.frontSprite = new Sprite;//前层容器
			this.effectLayer = new Sprite;//特效层
			this.mapWidth = this.mapCols*this.tileWidth;//地图横向宽度
			this.mapHeight = this.mapRows*this.tileHeight;//地图纵向高度
			MagicStarLogger.getInstance().showLog("系统：[Map]绘制地图之前"+System.privateMemory/1024/1024+"mb");
			this.draw();//此为内存增长大户
			MagicStarLogger.getInstance().showLog("系统：[Map]绘制地图之后"+System.privateMemory/1024/1024+"mb");
		}
		/**
		 * 
		 * 画地图（拼接地图）。【20180721】仿佛是先把地图拼起来，然后再绘制成一张大的图。最终使用的时候是用的大图
		 * 
		 */ 
		public function draw():void{
			MagicStarLogger.getInstance().showLog("系统：[Map]开始绘制地图");
			
			
			MagicStarLogger.getInstance().showLog("系统：[Map]开始绘制底层，先绘制到一个临时层上，再将临时层转换成一张静态底图");
			var groundSpriteTemp:Sprite = new Sprite;//一个临时的背景层
			for(var i:int=0;i < this.mapModel.backArray.length;i++){
				var backInfo:BackGroundInfo = this.mapModel.backArray[i];
				if(backInfo.type==1){//1 bitmap 2 mc 3 animation。【20180724】之前在此说明了type1是图片，type2是movieclip，type3是自己的animation。不过当前只用到了前两项，而且还不具备动画。type2的mc我记得主要是为了将原件的锚点确定在其底盘中心位置。
					var backBitmap:Bitmap = new Bitmap(MagicStarSrcStorage.getInstance().getData(backInfo.url));
					backBitmap.x = backInfo.posX;
					backBitmap.y = backInfo.posY;
					if(backInfo.opposide){
						backBitmap.scaleX = -1;
					}
					groundSpriteTemp.addChild(backBitmap);
				}else if(backInfo.type==2){
					trace("backInfo.url="+backInfo.url);
					var backMC:MovieClip = MagicStarSrcStorage.getInstance().getMC(backInfo.url);
					backMC.x = backInfo.posX;
					backMC.y = backInfo.posY;
					if(backInfo.opposide){
						backMC.scaleX = -1;
					}
					groundSpriteTemp.addChild(backMC);
				}
				/**
				 * 
				 * 【20180724】对于我注释掉以下代码的解释：我既然是要将底层绘制成一张静态的图片，动画是不应该存在的。我得找时间把type2都处理掉。
				 * 
				 */
				/*else if(backInfo.type==3){
					var backBC:MagicStarBitmapClip = new MagicStarBitmapClip(MagicStarClipManager.getInstance().getClipData(backInfo.url));
					backBC.x = backInfo.posX;
					backBC.y = backInfo.posY;
					if(backInfo.opposide){
						backBC.scaleX = -1;
					}
					groundSpriteTemp.addChild(backBC);
				}*/
			}
			
			if(groundBitmapData){
				this.groundBitmapData.dispose();
				this.groundBitmapData = null;
			}
			
			this.groundBitmapData = new BitmapData(this.mapWidth,this.mapHeight);
			this.groundBitmapData.draw(groundSpriteTemp);
			this.groundSprite.addChild(new Bitmap(this.groundBitmapData));
			MagicStarLogger.getInstance().showLog("系统：[Map]后层绘制完毕"+System.privateMemory/1024/1024+"mb");
			
			
			MagicStarLogger.getInstance().showLog("系统：[Map]开始绘制前层");
			
			
			for(var n:int=0;n < this.mapModel.outLookArray.length;n++){
				var outInfo:OutLookInfo = this.mapModel.outLookArray[n];
				
				if(outInfo.type==1){//1 bitmap 2 mc 3 animation。对第一种地图可视元素-图片的绘制
					var outBitmap:Bitmap = new Bitmap(MagicStarSrcStorage.getInstance().getData(outInfo.url));
					outBitmap.x = outInfo.posX;
					outBitmap.y = outInfo.posY;
					if(outInfo.opposide){
						outBitmap.scaleX = -1;
					}
					this.frontSprite.addChild(outBitmap);
				}else if(outInfo.type==2){//对第二种地图元素-mc的绘制。再次强调，mc只是为了摆锚点而已。
					var outMC:MovieClip = MagicStarSrcStorage.getInstance().getMC(outInfo.url);
					outMC.x = outInfo.posX;
					outMC.y = outInfo.posY;
					if(outInfo.opposide){
						outMC.scaleX = -1;
					}
					this.frontSprite.addChild(outMC);
				}
				/**
				 * 
				 * 【20180724】当前暂时没有第三种地图元素。和底层不一样的是，前层的确由一些由动画组成的地图元素。在此是需要的，再以后的规划中再决定是否使用把。
				 * 
				 */
				/*else if(outInfo.type==3){
					var outBC:MagicStarBitmapClip = new MagicStarBitmapClip(MagicStarClipManager.getInstance().getClipData(outInfo.url));
					outBC.x = outInfo.posX;
					outBC.y = outInfo.posY;
					if(outInfo.opposide){
						outBC.scaleX = -1;
					}
					outBC.gotoAndPlay(outInfo.url);
					this.frontSprite.addChild(outBC);
				}*/
			}
			
			MagicStarLogger.getInstance().showLog("系统：[Map]初始化地图联通性结构数据中的tile位置信息");
			/**
			 * 
			 * 【20180724】此工作也许可以在更好的地方实现
			 * 
			 */
			for(var kk:int=0;kk<this.mapRows;kk++){
				for(var ll:int=0;ll<this.mapCols;ll++){
					var frontTile:Tile = this.mapModel.frontTileArray[kk*this.mapCols+ll];
					frontTile.registPoint = new Point(ll*this.tileWidth,kk*this.tileHeight);
				}
			}
			this.addChildAt(this.groundSprite,0);
			this.addChildAt(this.frontSprite,1);
			this.addChildAt(this.effectLayer,2);
			
			MagicStarLogger.getInstance().showLog("系统：[Map]地图绘制完成");
			dispatchEvent(new MapLoaderEvent(MapLoaderEvent.DRAW_COMPLETE));
		}
		
		
		public function onMouseMove(event:Event):void{
			var tile:Tile = this.getTileByPosition(this.mouseX,this.mouseY);
			MagicStarApplication.getInstance().currentCol = tile.cols;
			MagicStarApplication.getInstance().currentRow = tile.row;
		}
		
		
		/////////////////////
		
		
		
		public function isTileWalkable(row:int,cols:int):Boolean{
		//	trace("row="+row);
		//	trace("cols="+cols);
			var tile:Tile = this.getFrontTile(row,cols);
			if(tile){
				return tile.isWalkble;
			}
			
			return true;
		}
		
		
		
		public function addActor(obj:TileBaseObject,position:Point):void{
			if(this.frontSprite){
				obj.map = this;
				this.frontSprite.addChild(obj);
				
				trace("position.x="+position.x);
				trace("position.y="+position.y);
				
				var col:int =  Math.floor(position.x/this.tileWidth);
				var row:int =  Math.floor(position.y/this.tileHeight);
				
				trace("position.y="+position.y);
				trace("this.tileHeight="+this.tileHeight);
				
				trace("row="+row);
				trace("col="+col);
				
				trace("this.mapModel.rowsNum="+this.mapModel.rowsNum);
				trace("this.mapModel.colsNum="+this.mapModel.colsNum);
				
				//actor当前所在的tile
				obj.CurrentTile = this.getFrontTile(row,col);
				obj.setCoordinate(position.x,position.y);
				this.mapObjList.push(obj);
			}
			
		}
		
		/**
		 * 
		 * 通过位置获得tile
		 * 
		 */
		public function getTileByPosition(targetX:Number,targetY:Number):Tile{
			var rowNum:int = Math.floor(targetY/this.tileHeight);
			var colNum:int = Math.floor(targetX/this.tileWidth);
			return this.mapModel.getFrontTile(rowNum,colNum);
		}
		/**
		 * 
		 * 通过行列获得地图tile
		 * 
		 */ 
		public function getFrontTile(row:int,cols:int):Tile{
			if(!this.mapModel){
				return null;
			}
			return this.mapModel.getFrontTile(row,cols);
		}
		/**
		 * 
		 * 显示地图，并开启深度排序算法
		 * 
		 */
		public function show():void{
			MagicStarApplication.getInstance().seneceLayer.addChild(this);
			this.startDeepSort();
		}
		/**
		 * 
		 * 启动深度排序算法
		 * 
		 */
		private function startDeepSort():void{
			if(task){
				TaskManager.getInstance().addTask(this.task,15);
			}
		}
		/**
		 * 
		 * 停止深度排序算法
		 * 
		 */
		private function stopDeepSort():void{
			if(task){
				TaskManager.getInstance().removeTask(this.task);
			}
		}
		
		/**
		 * 
		 * 深度排序
		 * 
		 */ 
		private function sortDeep():void{
			for( var i:int = 0 ; i < this.frontSprite.numChildren; i++ ){
				for( var f:int = 1 ; f < this.frontSprite.numChildren; f++ ){
					
					var tempObjI:DisplayObject = this.frontSprite.getChildAt(i);
					var tempObjF:DisplayObject = this.frontSprite.getChildAt(f);
					
					
					var userY_1:int = tempObjI.y;
					var userY_2:int = tempObjF.y;
					
					if( userY_1 < userY_2 && i > f ){
						this.frontSprite.setChildIndex(tempObjI,f);
						this.frontSprite.setChildIndex(tempObjF,i);
					}else if(userY_1 > userY_2 && i < f){
						this.frontSprite.setChildIndex(tempObjI,f);
						this.frontSprite.setChildIndex(tempObjF,i);
					}
				}
			}
		}
		
		
		/**
		 * 
		 * 终止地图生命周期
		 * 
		 */
		public function dispose():void{
			this.stopDeepSort();
			if(this.parent){
				this.parent.removeChild(this);
			}
			
			if(this.bigMap){
				if(this.bigMap.parent){
					this.bigMap.parent.removeChild(this.bigMap);
				}
				this.bigMap.bitmapData.dispose();
				this.bigMap = null;
			}

			
			this.clearMap();
			
			mapModel=null;
			frontSprite=null;
			groundSprite=null;
			mapObjList=null;
			task=null;
			
			
		}
		/**
		 * 
		 * 清理地图
		 * 
		 */
		public function clearMap():void{
			var size:Number = 0;
			
			if(mapModel){
				for(var i:int = 0;i < this.mapModel.backArray.length;i++){
					var backInfo:BackGroundInfo = this.mapModel.backArray[i];
					size += MagicStarSrcStorage.getInstance().disposeData(backInfo.url);
				}
				
				for(var n:int = 0;n < this.mapModel.outLookArray.length;n++){
					var outLookInfo:OutLookInfo = this.mapModel.outLookArray[n];
					size += MagicStarSrcStorage.getInstance().disposeData(outLookInfo.url);
				}
			}
			
			if(this.groundBitmapData){
				this.groundBitmapData.dispose();
				this.groundBitmapData = null;
			}
		}
		
		

		/**
		 * 
		 * 以下是之前想玩地图震动的代码
		 * 
		 */
		public var mapX:Number;
		public var mapY:Number;
		public var shakeIndex:int = 0;
		public var shakeTask:Task = new Task;
		public function startShake():void{
			this.mapX = this.x;
			this.mapY = this.y;
			this.shakeTask.execute = this.shake;
			this.shakeIndex = 0;
			TaskManager.getInstance().addTask(this.shakeTask);
		}
		/**
		 * 
		 * 【20180724】当年想玩地图震动，仿佛都没用上过。不过对于整个地图的特效来说，还是由用的先留着。
		 * 
		 */
		public function shake():void{
			var offset:int = Math.random()*20+5;
			this.x = this.mapX+offset;
			this.y = this.mapY+offset;
			this.shakeIndex++;
			if(this.shakeIndex >= 30){
				TaskManager.getInstance().removeTask(this.shakeTask);
				this.shakeIndex = 0;
				this.x = this.mapX;
				this.y = this.mapY;
			}
		}
		
		/**
		 * 
		 * 以下是地图缩放的代码
		 * 
		 */
		private var _magicScale:Number;
		
		
		public function get magicScale():Number
		{
			return _magicScale;
		}
		
		public function set magicScale(value:Number):void
		{
			_magicScale = value;
			this.scaleX = _magicScale;
		}
	}
}