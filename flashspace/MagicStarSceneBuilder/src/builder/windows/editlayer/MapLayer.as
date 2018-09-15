package builder.windows.editlayer
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import builder.windows.toolbar.BtnLayer;
	import builder.windows.editlayer.map.BackGroundLayer;
	import builder.windows.editlayer.map.ForeGroundLayer;
	import builder.windows.editlayer.struct.GridLayer;
	import builder.windows.editlayer.struct.MarkLayer;
	
    //地图编辑区域
	public class MapLayer extends Sprite
	{
		private static var instance:MapLayer;
		public var viewScaleX:Number = 1.0;
		public var viewScaleY:Number = 1.0;
		public var oneScreen:OneScreenLayer;
		
		public static function getInstance():MapLayer
		{
			if(!instance){
				instance = new MapLayer(new MapLayerPrivate);
			}
			return instance;
		}
		
		
		/**
		 * 
		 * maplayer是一个可视区域。是编辑地图的区域。可以对这个区域进行缩放，拖动，还需要获取当前鼠标所在编辑区域的位置。
		 * 
		 * 拖动、缩放
		 * 
		 */
		public function MapLayer(param:MapLayerPrivate)
		{
			//this.initMapLayer();
		}
		
		/**
		 * 
		 * 初始化mapLayer
		 * 
		 */
		public function initMapLayer():void{
			this.addChild(BackGroundLayer.getInstance());//背景层
			this.addChild(ForeGroundLayer.getInstance());//前景层
			this.addChild(GridLayer.getInstance());//网格层。感觉仅仅就是用于显示的网格
			this.addChild(MarkLayer.getInstance());//应该和网格的结构差不多，但是可以设置tile的阻挡属性。当然也包括显示阻挡的属性。
		}
		
		/**
		 * 
		 * 首先要设置地图的尺寸。这个尺寸是行列的规格，不是像素大小哈
		 * 
		 */
		public function setMapSize(mapWidth:int, mapHeight:int):void
		{
			this.graphics.beginFill(0xFFFFFF,1);
			this.graphics.drawRect(0,0,mapWidth*40,mapHeight*40);
			
			BackGroundLayer.getInstance().setMapSize(mapWidth,mapHeight);
			ForeGroundLayer.getInstance().setMapSize(mapWidth,mapHeight);
			
			this.addEventListener(MouseEvent.MOUSE_WHEEL,onMouseWheelHandler);//应该是用于缩放地图的事件
			this.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN,startDragLayer);//应该是用于启动拖拽地图的事件
			this.addEventListener(MouseEvent.RIGHT_MOUSE_UP,stopDragLayer);//应该是用于停止拖拽地图的事件
			this.addEventListener(MouseEvent.MOUSE_MOVE,showMouseXY);//编辑器嘛，随时显示当前鼠标的位置
		}
		
		/**
		 * 
		 * 显示鼠标在地图中的像素位置和所在格子
		 * 
		 */
		public function showMouseXY(e:MouseEvent):void
		{
			BtnLayer.getInstance().currentXY.htmlText = "X位置："+this.mouseX + "\r" + "Y位置：" + this.mouseY +
				"\r" + "Y" + (int(this.mouseY / 40)) + "格    X" + (int(this.mouseX / 40)) + "格";
		}
		/**
		 * 
		 *像其他所有图形编辑工具一样，滚动滚轮缩放地图 
		 * 
		 */
		private function onMouseWheelHandler(e:MouseEvent):void
		{
			if(BackGroundLayer.getInstance().mapResources){//mapResources是什么，需要我进一步探索
				return;
			}
			
			if(ForeGroundLayer.getInstance().mapResources){//mapResources是什么，需要我进一步探索
				return;
			}
			
			/**
			 * 
			 * 具体的缩放代码
			 * 
			 */
			if(e.delta > 0){
				this.scaleX = viewScaleX + viewScaleX / 100 * e.delta;
				this.scaleY = viewScaleY + viewScaleY / 100 * e.delta;//缩放的是整个maplayer
				
				viewScaleX = this.scaleX;
				viewScaleY = this.scaleY;
			}else{
				this.scaleX = viewScaleX - viewScaleX / 100 * -(e.delta);
				this.scaleY = viewScaleY - viewScaleY / 100 * -(e.delta);//缩放的是整个maplayer
				
				viewScaleX = this.scaleX;
				viewScaleY = this.scaleY;
			}
		}
		/**
		 * 
		 * 开始拖动地图
		 * 
		 */
		private function startDragLayer(e:MouseEvent):void
		{
			if(!BackGroundLayer.getInstance().mapResources && !ForeGroundLayer.getInstance().mapResources){
				this.startDrag(false);
			}else{
				if(BackGroundLayer.getInstance().mapResources){
					BackGroundLayer.getInstance().clearMapResources();
				}
				
				if(ForeGroundLayer.getInstance().mapResources){
					ForeGroundLayer.getInstance().clearMapResources();
				}
			}
		}
		/**
		 * 
		 * 停止拖动地图
		 * 
		 */
		private function stopDragLayer(e:MouseEvent):void
		{
			this.stopDrag();
		}
	}
}
class MapLayerPrivate{}