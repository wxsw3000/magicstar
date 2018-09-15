package builder.windows.menu
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	
	import builder.windows.components.MapResources;
	import builder.windows.components.Tile;
	import builder.windows.data.CurrentMapData;
	import builder.windows.editlayer.map.BackGroundLayer;
	import builder.windows.editlayer.map.ForeGroundLayer;
	import builder.windows.editlayer.struct.GridLayer;
	import builder.windows.editlayer.struct.MarkLayer;
	import builder.windows.menu.components.MenuPanel;
	import builder.windows.respanel.XMLBuilder;
	import builder.windows.respanel.vo.GroundType;
	
	import org.aswing.event.AWEvent;
	

	public class MenuOperator
	{
		private static var instance:MenuOperator;
		
		public static function getInstance():MenuOperator{
			if(!instance){
				instance = new MenuOperator(new MenuOperatorPrivate);
			}
			return instance;
		}
		
		public function MenuOperator(param:MenuOperatorPrivate)
		{
		}
		
		
		
		
		
		
		
		
		/*******************FILE菜单操作**********************/
		
		
		/**
		 * 
		 * 保存场景
		 * 
		 */
		public function clickSave(event:AWEvent):void
		{
			XMLBuilder.getInstance().builderXml();
		}
		
		
		/**
		 * 
		 * 新建场景
		 * 
		 */
		public function onNewScene(event:AWEvent):void{
			MenuPanel.getInstance().hide();
			CreateSceneUI.getInstance().show();
		}
		
		/**
		 * 
		 * 导入场景
		 * 
		 */
		private var loadXml:FileReference;
		public function onImportScene(event:AWEvent):void{
			loadXml = new FileReference;
			loadXml.addEventListener(Event.SELECT,startLoad);
			loadXml.browse([new FileFilter("xml","*.xml;*.XML;*.Xml")]);
		}
		
		/*******************FILE菜单操作**********************/
		
		
		/*******************EDIT菜单操作**********************/
		
		/**
		 * 
		 * 删除元素
		 * 
		 */
		
		private var _isDelete:Boolean;
		public function get isDelete():Boolean
		{
			return _isDelete;
		}
		
		public function set isDelete(value:Boolean):void
		{
			_isDelete = value;
			
			if(_isDelete){
				//deleteBtn.label = "取消删除";
				
				BackGroundLayer.getInstance().clearMapResources();
			}else{
				//deleteBtn.label = "删除";
			}
		}
		
		public function clickDelete(event:AWEvent):void
		{
			if(isDelete){
				isDelete = false;
			}else{
				isDelete = true;
			}
		}
		
		/**
		 * 
		 * 回退一步
		 * 
		 */
		public function regressesOneStep(event:AWEvent):void{
			
		}
		
		
		//得考虑点击事件相关业务的最好构建方式。
		public var currentMc:MapResources;//当前资源。接下来要将这个当前资源提到公共部分，可以共用。
		
		
		/**
		 * 
		 * 置为最前
		 * 
		 */
		public function onBringForward(event:AWEvent):void{
			if(currentMc){
				if(currentMc.groundType == GroundType.backGround){
					BackGroundLayer.getInstance().setForward(currentMc)
				}else if(currentMc.groundType == GroundType.foreGround){
					ForeGroundLayer.getInstance().setForward(currentMc)
				}
			}
		}
		/**
		 * 
		 * 前移一层
		 * 
		 */
		public function onForwardOne(event:AWEvent):void{
			if(currentMc){
				if(currentMc.groundType == GroundType.backGround){
					BackGroundLayer.getInstance().sweepChildUp(currentMc)
				}else if(currentMc.groundType == GroundType.foreGround){
					ForeGroundLayer.getInstance().sweepChildUp(currentMc)
				}
			}
		}
		
		/**
		 * 
		 * 置为最后
		 * 
		 */
		public function onSendBack(event:AWEvent):void
		{
			if(currentMc){
				if(currentMc.groundType == GroundType.backGround){
					BackGroundLayer.getInstance().setBack(currentMc)
				}else if(currentMc.groundType == GroundType.foreGround){
					ForeGroundLayer.getInstance().setBack(currentMc)
				}
			}
		}
		
		/**
		 * 
		 * 后移一层
		 * 
		 */
		public function onBackOne(event:AWEvent):void
		{
			if(currentMc){
				if(currentMc.groundType == GroundType.backGround){
					BackGroundLayer.getInstance().sweepChilendDown(currentMc);
				}else if(currentMc.groundType == GroundType.foreGround){
					ForeGroundLayer.getInstance().sweepChilendDown(currentMc);
				}
			}
		}
		
		/**
		 * 
		 * 当前地图原件镜面转逆
		 * 
		 */
		public function onMirror(event:AWEvent):void
		{
			if(currentMc){
				if(currentMc.scaleX == 1){
					currentMc.scaleX = -1;
				}else{
					currentMc.scaleX = 1;
				}
			}
		}
	    /**
		 * 
		 * 召唤设置阻挡状态
		 * 
		 */
		public function onSetBlock(event:AWEvent):void
		{
			//BackGroundLayer.getInstance().clearMapResources();
			
			if(!MarkLayer.getInstance().visible){
				MarkLayer.getInstance().visible = true;
			}else{
				MarkLayer.getInstance().visible = false;
			}
		}
		
		
		/*******************EDIT菜单操作**********************/
		
		/*******************VIEW菜单操作**********************/
		
		
		public var currentGround:int = GroundType.backGround;
		
		/**
		 * 
		 * 显示前景层
		 * 
		 */
		public function onDisplayForeLayer(event:AWEvent):void
		{
			currentGround = GroundType.foreGround;
			BackGroundLayer.getInstance().visible = true;
			BackGroundLayer.getInstance().mouseEnabled = false;
			BackGroundLayer.getInstance().mouseChildren = false;
			ForeGroundLayer.getInstance().visible = true;
			ForeGroundLayer.getInstance().mouseEnabled = true;
			ForeGroundLayer.getInstance().mouseChildren = true;
		}
		/**
		 * 
		 * 显示背景层
		 * 
		 */
		public function onDisplayBackLayer(event:AWEvent):void
		{
			currentGround = GroundType.backGround;
			BackGroundLayer.getInstance().visible = true;
			BackGroundLayer.getInstance().mouseEnabled = true;
			BackGroundLayer.getInstance().mouseChildren = true;
			ForeGroundLayer.getInstance().visible = false;
		}
		/**
		 * 
		 * 显示所有层
		 * 
		 */
		public function onDisplayAllLayer(event:AWEvent):void
		{
			currentGround = GroundType.backGround;
			BackGroundLayer.getInstance().visible = true;
			BackGroundLayer.getInstance().mouseEnabled = true;
			BackGroundLayer.getInstance().mouseChildren = true;
			ForeGroundLayer.getInstance().visible = true;
			ForeGroundLayer.getInstance().mouseEnabled = false;
			ForeGroundLayer.getInstance().mouseChildren = false;
		}
		/**
		 * 
		 * 显示网格
		 * 
		 */
		public function onShowGrid(event:AWEvent):void
		{
			BackGroundLayer.getInstance().clearMapResources();
			
			if(!GridLayer.getInstance().visible){
				GridLayer.getInstance().visible = true;
			}else{
				GridLayer.getInstance().visible = false;
			}
		}
		/**
		 * 
		 * 还原被缩放后的大小
		 * 
		 */
		public function onReturnSize(event:AWEvent):void
		{
			EditorWindow.getInstance().onReturnSize();
		}
		/**
		 * 
		 * 显示一屏的大小
		 * 
		 */
		public function onOneScreen(event:AWEvent):void
		{
			EditorWindow.getInstance().showOneScreen();
		}
		
		/*******************VIEW菜单操作**********************/
		
		
		
		
		private function startLoad(e:Event):void
		{
			loadXml.removeEventListener(Event.SELECT,startLoad);
			loadXml.addEventListener(Event.COMPLETE,xmlLoadOk);
			loadXml.load();
		}
		
		private function xmlLoadOk(e:Event):void
		{
			loadXml.removeEventListener(Event.COMPLETE,xmlLoadOk);
			
			var xml:XML = new XML(e.currentTarget.data);
			
			var backGroundArr:Array = new Array;
			var outLookArr:Array = new Array;
			var markArr:Array = new Array;
			
			CurrentMapData.getInstance().cols = xml.colNum;
			CurrentMapData.getInstance().rows = xml.rowNum;
			CurrentMapData.getInstance().mapID = xml.Id;
			
			/*MapLayer.getInstance().setMapSize(xml.colNum,xml.rowNum);
			GridLayer.getInstance().setGridSize(xml.colNum,xml.rowNum);
			MarkLayer.getInstance().setMarkSize(xml.colNum,xml.rowNum);*/
			
			EditorWindow.getInstance().setMapSize(CurrentMapData.getInstance().cols,CurrentMapData.getInstance().rows);
			
			if(xml.BackGrounds){
				for(var i:int = 0;i < xml.BackGrounds.BackGround.length();i++){
					var source:MapResources = new MapResources(xml.BackGrounds.BackGround[i].@name,xml.BackGrounds.BackGround[i].@type,0);
					if(xml.BackGrounds.BackGround[i].@opposide == "true"){
						source.scaleX = -1;
					}
					source.x = int(xml.BackGrounds.BackGround[i].@x);
					source.y = int(xml.BackGrounds.BackGround[i].@y);
					BackGroundLayer.getInstance().addChild(source);
					source.addEventListener(MouseEvent.CLICK,BackGroundLayer.getInstance().clickResources);
				}
			}
			
			if(xml.OutLooks){
				for(var o:int = 0;o < xml.OutLooks.OutLook.length();o++){
					var mc:MapResources = new MapResources(xml.OutLooks.OutLook[o].@name,xml.OutLooks.OutLook[o].@type,1);
					if(xml.OutLooks.OutLook[o].@opposide == "true"){
						mc.scaleX = -1;
					}
					mc.x = int(xml.OutLooks.OutLook[o].@x);
					mc.y = int(xml.OutLooks.OutLook[o].@y);
					ForeGroundLayer.getInstance().addChild(mc);
					mc.addEventListener(MouseEvent.CLICK,ForeGroundLayer.getInstance().clickResources);
				}
			}
			
			if(MarkLayer.getInstance().isFirst){
				MarkLayer.getInstance().clear();
				
				var newTile:Array = new Array;
				var index:int;
				var str:String = xml.mark;
				var w:int = xml.colNum;
				var h:int;
				
				for(var q:int = 0;q < str.length;q++){
					if(str.charAt(q) != ","){
						var tile:Tile = new Tile(int(str.charAt(q)),EditorWindow.getInstance().tileWidth,EditorWindow.getInstance().tileHeight);
						
						if(index == w){
							index = 0;
						}
						
						tile.x = EditorWindow.getInstance().tileWidth * index;
						tile.y = EditorWindow.getInstance().tileHeight * int(h / w);
						MarkLayer.getInstance().addChild(tile);
						newTile.push(tile);
						tile.addEventListener(MouseEvent.CLICK,MarkLayer.getInstance().clickTile);
						index++;
						h++;
					}
				}
				
				MarkLayer.getInstance().tileArr = newTile;
			}
			
			MenuPanel.getInstance().hide();
		}
		
		
		
		public function clickUpBtn():void
		{
			if(currentMc){
				currentMc.y--;
			}
		}
		
		public function clickDownBtn():void
		{
			if(currentMc){
				currentMc.y++;
			}
		}
		
		public function clickLeftBtn():void
		{
			if(currentMc){
				currentMc.x--;
			}
		}
		
		public function clickRightBtn():void
		{
			if(currentMc){
				currentMc.x++;
			}
		}

		
		
	}
}
class MenuOperatorPrivate{}