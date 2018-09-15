package builder.windows.components
{
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import builder.windows.menu.EditorWindow;
	
	
	public class ScrollSpr extends Sprite
	{
		private var _placeSpr:Sprite;//放置块
		public var viewWidth:int;//显示宽度
		public var viewHeight:int;//显示高度
		public var startY:Number = 0;//开始拖动位置X
		public var speed:Number = 0;//滑动速度
		public var currentScrollX:Number = 0;//当前位置X
		public var currentScrollY:Number = 0;//当前位置Y
		private var _isMove:Boolean;
		private var _clearFun:Function;
		public var xyPoint:Point;
		public function ScrollSpr(w:int, h:int)
		{
			this.clearFun = this.clear;
			this.viewWidth = w;
			this.viewHeight = h;
			
			this.graphics.beginFill(0x000000,0.001);
			this.graphics.drawRect(0,0,w,h);
			this.scrollRect = new Rectangle(0,0,w,h);
			
			this._placeSpr = new Sprite;
			this.addChild(_placeSpr);
			
			xyPoint = new Point;
			xyPoint.x = 0;
			xyPoint.y = 0;
			
			this.addEventListener(MouseEvent.MOUSE_DOWN,startMove);
			this.addEventListener(MouseEvent.MOUSE_UP,overMove);
//			this.addEventListener(MouseEvent.MOUSE_OUT,overMove);
			this.addEventListener(MouseEvent.MOUSE_WHEEL,mouseWheelTo);
		}
		
		public function clear():void
		{
			if(_placeSpr && _placeSpr.parent){
				_placeSpr.parent.removeChild(_placeSpr);
				_placeSpr = null;
			}
			
			this._placeSpr = new Sprite;
			this.addChild(_placeSpr);
		}
		/**
		 * 开始拖动
		 **/
		public function startMove(e:MouseEvent):void
		{
			//startY = MagicStarEditorStage.getInstance().mouseY;
			startY = EditorWindow.getInstance().mouseY;
			this.addEventListener(MouseEvent.MOUSE_MOVE,DragMove);
		}
		/**
		 * 结束拖动
		 **/
		public function overMove(e:MouseEvent):void
		{
			startY = EditorWindow.getInstance().mouseY;
			this.removeEventListener(MouseEvent.MOUSE_MOVE,DragMove);
		}
		/**
		 * 拖动中
		 **/
		public function DragMove(e:MouseEvent):void
		{
			speed = this.startY - EditorWindow.getInstance().mouseY;
			
			if((this.currentScrollY + speed) < 0 || (this.currentScrollY + speed) > _placeSpr.height - viewHeight){
				speed = 0;
			}
			
			currentScrollY += speed;
			
			this.changePointXY();
			
			_isMove = true;
			
			startY = EditorWindow.getInstance().mouseY;
		}
		
		
		public function mouseWheelTo(e:MouseEvent):void
		{
			this.speed = -(e.delta * 10);
			
			if((this.currentScrollY + speed) < 0 || (this.currentScrollY + speed) > _placeSpr.height - viewHeight){
				speed = 0;
			}
			
			this.currentScrollY += speed;
			
			this.scrollRect = new Rectangle(0,currentScrollY,viewWidth,viewHeight);
		}
		
		public function changePointXY():void
		{
			TweenLite.to(xyPoint,0.5,{y:currentScrollY,onUpdate:changePointY});
		}
		
		public function changePointY():void
		{
			this.scrollRect = new Rectangle(0,xyPoint.y,viewWidth,viewHeight);
		}

		public function get placeSpr():Sprite
		{
			return _placeSpr;
		}

		public function set placeSpr(value:Sprite):void
		{
			_placeSpr = value;
		}
		
		public function setScrollUp():void
		{
			if(_placeSpr.height > viewHeight){
				this.currentScrollY = 0;
				this.scrollRect = new Rectangle(0,currentScrollY,viewWidth,viewHeight);
			}
		}

		public function get isMove():Boolean
		{
			return _isMove;
		}

		public function set isMove(value:Boolean):void
		{
			_isMove = value;
		}

		public function get clearFun():Function
		{
			return _clearFun;
		}

		public function set clearFun(value:Function):void
		{
			_clearFun = value;
		}
	}
}