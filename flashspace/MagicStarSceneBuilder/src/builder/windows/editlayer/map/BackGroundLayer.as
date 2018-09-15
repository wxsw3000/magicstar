package builder.windows.editlayer.map
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import builder.windows.menu.MenuOperator;
	import builder.windows.respanel.vo.GroundType;
	import builder.windows.components.MapResources;
	
	/**
	 * 
	 * 此乃背景层
	 * 
	 */
	public class BackGroundLayer extends Sprite
	{
		private static var instance:BackGroundLayer;
		
		public static function getInstance():BackGroundLayer
		{
			if(!instance){
				instance = new BackGroundLayer(new BackGroundLayerPrivate);
			}
			return instance;
		}
		
		public var mapResources:MapResources;
		public var startX:int;
		public var startY:int;
		public function BackGroundLayer(param:BackGroundLayerPrivate)
		{
		}
		/**
		 * 设置背景层大小
		 * @param w 宽
		 * @param h 高
		 */
		public function setMapSize(w:int, h:int):void
		{
			this.graphics.beginFill(0xFFFFFF,0.001);
			this.graphics.drawRect(0,0,w*40,h*40);
			this.graphics.endFill();
		}
		/**
		 * 设置资源信息
		 * @param url 资源url
		 * @param type 资源类型
		 */
		public function setMapResources(url:String, type:int):void
		{
			if(mapResources && mapResources.parent){
				mapResources.parent.removeChild(mapResources);
			}
			
			mapResources = null;
			
			mapResources = new MapResources(url,type);
			mapResources.mouseChildren = false;
			mapResources.mouseEnabled = false;
			
			trace("this.addEventListener(MouseEvent.MOUSE_OVER,onSet)");
			this.addEventListener(MouseEvent.MOUSE_OVER,onSet);
		}
		/**
		 * 资源进入背景层
		 */
		public function onSet(event:MouseEvent=null):void
		{
			this.removeEventListener(MouseEvent.MOUSE_OVER,onSet);
			
			if(mapResources){
				this.mapResources.x = this.mouseX;
				this.mapResources.y = this.mouseY;
				mapResources.mouseChildren = false;
				mapResources.mouseEnabled = false;
				this.addChild(mapResources);
				
				this.addEventListener(MouseEvent.MOUSE_OUT,outSet);
				this.addEventListener(MouseEvent.MOUSE_MOVE,onMove);
//				this.addEventListener(MouseEvent.CLICK,overSetresources);
				this.addEventListener(MouseEvent.MOUSE_DOWN,downSet);
			}
		}
		/**
		 * 资源拉出背景层
		 */
		public function outSet(event:MouseEvent):void
		{
			this.removeEventListener(MouseEvent.MOUSE_OUT,outSet);
			this.removeEventListener(MouseEvent.MOUSE_MOVE,onMove);
//			this.removeEventListener(MouseEvent.CLICK,overSetresources);
			
			if(mapResources){
				this.setMapResources(mapResources.url,mapResources.type);
			}
		}
		/**
		 * 资源移动
		 */
		public function onMove(event:MouseEvent):void
		{
			if(mapResources){
				this.mapResources.x = this.mouseX;
				this.mapResources.y = this.mouseY;
				mapResources.mouseChildren = false;
				mapResources.mouseEnabled = false;
			}
		}
		/**
		 * 点击放下资源
		 */
		public function overSetresources(event:MouseEvent):void
		{
			if(mapResources){
				var resources:MapResources = new MapResources(mapResources.url,mapResources.type,GroundType.backGround);
				resources.x = int(mapResources.x);
				resources.y = int(mapResources.y);
				this.addChild(resources);
				
				resources.addEventListener(MouseEvent.CLICK,clickResources);
			}
		}
		public function downSet(event:MouseEvent):void
		{
			this.removeEventListener(MouseEvent.MOUSE_DOWN,downSet);
//			this.removeEventListener(MouseEvent.CLICK,overSetresources);
			
			startX = int(this.mouseX);
			startY = int(this.mouseY);
			
			this.addEventListener(MouseEvent.MOUSE_UP,upSet);
		}
		public function upSet(event:MouseEvent):void
		{
			
			trace("upSet~~~~~~~~~");
			
			var mapNum:int;
			var sprWidth:int;
			var sprHeight:int;
			
			if(mapResources){
				if(this.mouseX > startX && this.mouseY > startY){
					sprWidth = int(int(this.mouseX - startX) / mapResources.width);
					sprHeight = int(int(this.mouseY - startY) / mapResources.height);
					
					if(sprWidth > 5 && sprHeight > 5){
						mapNum = sprWidth * sprHeight;
						var index:int = 0;
						for(var i:int = 0;i < mapNum;i++){
							var mapRes:MapResources = new MapResources(mapResources.url,mapResources.type,0);
							this.addChild(mapRes);
							
							mapRes.addEventListener(MouseEvent.CLICK,clickResources);
							
							if(index == sprWidth){
								index = 0;
							}
							
							mapRes.x = startX + mapRes.width * index;
							mapRes.y = startY + mapRes.height * int(i / sprWidth);
							index++;
						}
					}
				}else{
					var resources:MapResources = new MapResources(mapResources.url,mapResources.type,GroundType.backGround);
					resources.x = int(mapResources.x);
					resources.y = int(mapResources.y);
					this.addChild(resources);
					
					resources.addEventListener(MouseEvent.CLICK,clickResources);
				}
			}
			
//			this.addEventListener(MouseEvent.CLICK,overSetresources);
			this.removeEventListener(MouseEvent.MOUSE_UP,upSet);
		}
		/**
		 * 选中资源
		 */
		public function clickResources(event:MouseEvent):void
		{
			var resources:MapResources = event.currentTarget as MapResources;
			
			if(!mapResources && MenuOperator.getInstance().isDelete){
				
				if(resources && resources.parent){
					resources.parent.removeChild(resources);
					resources = null;
				}
			}else{
				MenuOperator.getInstance().currentMc = resources as MapResources;
			}
		}
		/**
		 * 改变鼠标状态，清除当前选中的铺设资源
		 */
		public function clearMapResources():void
		{
			this.removeEventListener(MouseEvent.MOUSE_OUT,outSet);
			this.removeEventListener(MouseEvent.MOUSE_MOVE,onMove);
//			this.removeEventListener(MouseEvent.CLICK,overSetresources);
			this.removeEventListener(MouseEvent.MOUSE_OVER,onSet);
			
			if(mapResources && mapResources.parent){
				mapResources.parent.removeChild(mapResources);
			}
			
			mapResources = null;
		}
		
		public function sweepChilendDown(map:MapResources):void
		{
			var indexTarget:int = map.parent.getChildIndex(map);
			if(indexTarget>0){
				map.parent.swapChildrenAt(indexTarget,indexTarget-1);
			}
		}
		
		public function sweepChilendDownFive(map:MapResources):void
		{
			var indexTarget:int = map.parent.getChildIndex(map);
			var index:int;
			if(indexTarget>0){
				if(indexTarget>6){
					index = 5;
					while(index>0)
					{
						map.parent.swapChildrenAt(indexTarget,indexTarget-1);
						indexTarget--;
						index--;
					}
				}else{
					index = indexTarget;
					while(index>0)
					{
						map.parent.swapChildrenAt(indexTarget,indexTarget-1);
						indexTarget--;
						index--;
					}
				}
			}
		}
		
		public function sweepChildUp(map:MapResources):void
		{
			var indexTarget:int = map.parent.getChildIndex(map);
			if(indexTarget<map.parent.numChildren-1){
				map.parent.swapChildrenAt(indexTarget,indexTarget+1);
			}
		}
		
		public function setForward(map:MapResources):void{
			map.parent.addChild(map);
		}
		
		public function setBack(map:MapResources):void{
			map.parent.addChildAt(map,0);
		}
		
		
		public function sweepChilendUpFive(map:MapResources):void
		{
			
			var indexTarget:int = map.parent.getChildIndex(map);
			var index:int;
			if(indexTarget<map.parent.numChildren-1){
				if(indexTarget<map.parent.numChildren-5){
					index = 5;
					while(index>0)
					{
						map.parent.swapChildrenAt(indexTarget,indexTarget+1);
						indexTarget++;
						index--;
					}
				}else{
					index = map.parent.numChildren-indexTarget;
					while(index>0)
					{
						map.parent.swapChildrenAt(indexTarget,indexTarget+1);
						indexTarget++;
						index--;
					}
				}
			}
		}
	}
}
class BackGroundLayerPrivate{}