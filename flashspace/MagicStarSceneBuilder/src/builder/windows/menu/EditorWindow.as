package builder.windows.menu
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import builder.windows.editlayer.map.BackGroundLayer;
	import builder.windows.editlayer.map.ForeGroundLayer;
	import builder.windows.editlayer.struct.GridLayer;
	import builder.windows.editlayer.struct.MarkLayer;
	
	import fl.controls.ScrollBar;
	import fl.controls.ScrollBarDirection;
	

	public class EditorWindow extends Sprite
	{
		private static var instance:EditorWindow;
		public var scrollBarH:ScrollBar;
		public var scrollBarV:ScrollBar;
		public var contentSprite:Sprite;
		public var viewScaleX:Number = 1.0;
		public var viewScaleY:Number = 1.0;
		public var oneScreen:Sprite;
		
		public var tileWidth:Number = 80;
		public var tileHeight:Number = 80;
		
		
		public static function getInstance():EditorWindow{
			if(!instance){
				instance = new EditorWindow(new EditorWindowPrivate);
			}
			return instance;
		}
		
		
		public function EditorWindow(param:EditorWindowPrivate)
		{
			this.contentSprite = new Sprite;
			this.addChild(this.contentSprite);
			
			
			this.contentSprite.addChild(BackGroundLayer.getInstance());//背景层
			this.contentSprite.addChild(ForeGroundLayer.getInstance());//前景层
			this.contentSprite.addChild(GridLayer.getInstance());//网格层。感觉仅仅就是用于显示的网格
			this.contentSprite.addChild(MarkLayer.getInstance());//应该和网格的结构差不多，但是可以设置tile的阻挡属性。当然也包括显示阻挡的属性。
			
			/*this.contentSprite.scrollRect = new Rectangle(0,0,1440,790);*/
			
			
			//横
			this.scrollBarH = new ScrollBar;
			this.scrollBarH.direction = ScrollBarDirection.HORIZONTAL;
			this.scrollBarH.y = 800-10;
			
			
			this.scrollBarH.width = 1450-10;
			
			//竖
			this.scrollBarV = new ScrollBar;
			this.scrollBarV.direction = ScrollBarDirection.VERTICAL;
			this.scrollBarV.x = 1450-10;
			this.scrollBarV.height = 800-10;
				
				
			
			
			this.addChild(this.scrollBarH);
			this.addChild(this.scrollBarV);
			
		}
		
		/**
		 * 
		 * 首先要设置地图的尺寸。这个尺寸是行列的规格，不是像素大小哈
		 * 
		 */
		public function setMapSize(cols:int, rows:int):void
		{
			this.contentSprite.graphics.beginFill(0xFFFFFF,1);
			this.contentSprite.graphics.drawRect(0,0,cols*40,rows*40);
			
			BackGroundLayer.getInstance().setMapSize(cols,rows);
			ForeGroundLayer.getInstance().setMapSize(cols,rows);
			

			
			this.contentSprite.addEventListener(MouseEvent.MOUSE_WHEEL,onMouseWheelHandler);//应该是用于缩放地图的事件
			this.contentSprite.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN,startDragLayer);//应该是用于启动拖拽地图的事件
			this.contentSprite.addEventListener(MouseEvent.RIGHT_MOUSE_UP,stopDragLayer);//应该是用于停止拖拽地图的事件
			this.contentSprite.addEventListener(MouseEvent.MOUSE_MOVE,showMouseXY);//编辑器嘛，随时显示当前鼠标的位置
			
			
			trace("cols="+cols+"  rows="+rows);
			
			GridLayer.getInstance().setGridSize(cols,rows);//网格也在此初始化，为什么不能有个统一的设定、修改接口呢。这样会导致业务分离情况下的不一致性
			MarkLayer.getInstance().setMarkSize(cols,rows);//阻挡显示层，也在此初始化
			
			
		}
		
		/**
		 * 
		 * 显示鼠标在地图中的像素位置和所在格子
		 * 
		 */
		public function showMouseXY(e:MouseEvent):void
		{
			var currentPos:String = "X位置："+this.contentSprite.mouseX + "\r" + "Y位置：" + this.contentSprite.mouseY +
				"\r" + "Y" + (int(this.contentSprite.mouseY / 40)) + "格    X" + (int(this.contentSprite.mouseX / 40)) + "格";
			trace(currentPos);
		}
		/**
		 * 
		 *像其他所有图形编辑工具一样，滚动滚轮缩放地图 
		 * 
		 */
		private function onMouseWheelHandler(e:MouseEvent):void
		{
			trace("onMouseWheelHandler");
			if(BackGroundLayer.getInstance().mapResources){//mapResources是什么，需要我进一步探索
				return;
			}
			
			if(ForeGroundLayer.getInstance().mapResources){//mapResources是什么，需要我进一步探索
				return;
			}
			trace("delta");
			
			/**
			 * 
			 * 具体的缩放代码
			 * 
			 */
			if(e.delta > 0){
				this.contentSprite.scaleX = viewScaleX + viewScaleX / 100 * e.delta;
				this.contentSprite.scaleY = viewScaleY + viewScaleY / 100 * e.delta;//缩放的是整个maplayer
				
				viewScaleX = this.contentSprite.scaleX;
				viewScaleY = this.contentSprite.scaleY;
			}else{
				this.contentSprite.scaleX = viewScaleX - viewScaleX / 100 * -(e.delta);
				this.contentSprite.scaleY = viewScaleY - viewScaleY / 100 * -(e.delta);//缩放的是整个maplayer
				
				viewScaleX = this.contentSprite.scaleX;
				viewScaleY = this.contentSprite.scaleY;
			}
		}
		/**
		 * 
		 * 还原场景的大小
		 * 
		 */
		public function onReturnSize():void{
			
			viewScaleX = 1;
			viewScaleY = 1;
			
			this.contentSprite.scaleX = viewScaleX;
			this.contentSprite.scaleY = viewScaleY;
		}
		
		/**
		 * 
		 * 开始拖动地图
		 * 
		 */
		private function startDragLayer(e:MouseEvent):void
		{
			trace("startDragLayerstartDragLayer");
			
			if(!BackGroundLayer.getInstance().mapResources && !ForeGroundLayer.getInstance().mapResources){
				this.contentSprite.startDrag(false);
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
			this.contentSprite.stopDrag();
		}
		
		
		/**
		 * 
		 * 显示一屏幕的大小
		 * 
		 */
		public function showOneScreen():void{
			if(!this.oneScreen){
				
				var oneScreenWidth:Number = 1280;
				var oneScreenHeight:Number = 720;
				
				this.oneScreen = new Sprite;
				this.oneScreen.mouseEnabled = false;
				this.oneScreen.mouseChildren = false;
				this.oneScreen.graphics.drawRect(0,0,1280,720);
				this.oneScreen.graphics.endFill();
				this.oneScreen.graphics.lineStyle(10,0x000000);
				this.oneScreen.graphics.moveTo(0,0);
				this.oneScreen.graphics.lineTo(1280,0);
				this.oneScreen.graphics.lineTo(1280,720);
				this.oneScreen.graphics.lineTo(0,720);
				this.oneScreen.graphics.lineTo(0,0);
			}
			if(this.oneScreen.parent){
				this.oneScreen.parent.removeChild(this.oneScreen);
			}else{
				this.contentSprite.addChild(this.oneScreen);
			}
		}
		
		
		
	}
}
class EditorWindowPrivate{}