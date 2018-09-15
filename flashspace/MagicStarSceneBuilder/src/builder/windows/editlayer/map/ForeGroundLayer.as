package builder.windows.editlayer.map
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import builder.windows.menu.MenuOperator;
	import builder.windows.respanel.vo.GroundType;
	import builder.windows.components.MapResources;
	
	public class ForeGroundLayer extends Sprite
	{
		private static var instance:ForeGroundLayer;
		
		public static function getInstance():ForeGroundLayer
		{
			if(!instance){
				instance = new ForeGroundLayer(new ForeGroundLayerPrivate);
			}
			return instance;
		}
		
		public var mapResources:MapResources;
		public function ForeGroundLayer(param:ForeGroundLayerPrivate)
		{
			this.visible = false;
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
				this.addEventListener(MouseEvent.CLICK,overSetresources);
			}
		}
		/**
		 * 资源拉出背景层
		 */
		public function outSet(event:MouseEvent):void
		{
			this.removeEventListener(MouseEvent.MOUSE_OUT,outSet);
			this.removeEventListener(MouseEvent.MOUSE_MOVE,onMove);
			this.removeEventListener(MouseEvent.CLICK,overSetresources);
			
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
		public function overSetresources(e:MouseEvent):void
		{
			if(mapResources){
				var resources:MapResources = new MapResources(mapResources.url,mapResources.type,GroundType.foreGround);
				resources.x = int(mapResources.x);
				resources.y = int(mapResources.y);
				this.addChild(resources);
				
				resources.addEventListener(MouseEvent.CLICK,clickResources);
			}
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
		 * 清理当前资源
		 */
		public function clearMapResources():void
		{
			this.removeEventListener(MouseEvent.MOUSE_OUT,outSet);
			this.removeEventListener(MouseEvent.MOUSE_MOVE,onMove);
			this.removeEventListener(MouseEvent.CLICK,overSetresources);
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
class ForeGroundLayerPrivate{}