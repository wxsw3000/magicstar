package magicstar.engine.display
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import magicstar.engine.core.TaskManager;
	import magicstar.engine.core.executor.Task;
	import magicstar.engine.scene.map.Point3D;
	
	public class MagicStarObject extends Sprite
	{
		private var task:Task;
		
		public var speedX:Number=0;
		public var speedY:Number=0;
		public var speedZ:Number=0;
		
		public var coordinate:Point3D = new Point3D;
		
		
		public var elastic:Number = 0.8;//弹性系数
		public var resistance:Number = -2;//-1为在地面上不能运动的type，-2在地面上可以运动的种类
		public var gravity:Number = -0.98;
		
		public var isChange:Boolean = false;
		
		public var targetX:int;
		public var targetY:int;
		public var isMoveTarget:Boolean = false;
		
		public var dir:int = 0;//0右 1上 2左 3下
		
		
		public function get speed():Number
		{
			return _speed;
		}

		public function set speed(value:Number):void
		{
			_speed = value;
			if(_speed==0){
				this.speedX = 0;
				this.speedY = 0;
			}
			this.dispatchEvent(new Event("SPEED_CHANGE"));
		}

		public var onCamera:Function;
		
		
		
		public var dirAngle:Number;
		
		private var _speed:Number;
		
		
	//	public var modelStr:String;
		
		//////////////////
		
		
		
		
		
		public function MagicStarObject()
		{
			this.task = new Task;
			this.task.execute = this.move;
		}
		
		public function setCoordinate(x:Number,y:Number,z:Number=0):void{
			this.coordinate.x = x;
			this.coordinate.y = y;
			this.coordinate.z = z;
			var point:Point = this.coordinate.switchTo2D();
			this.setXY(point);
			if(this.coordinate.z > 0){
				this.speedZ = this.gravity;
			}
		}
		
		
		public function startMove():void{
			TaskManager.getInstance().addTask(this.task);
		}
		
		public function stopMove():void{
			TaskManager.getInstance().removeTask(this.task);
		}
		
		/////////////////////////////////////////////////////
		
		
		/**
		 * 
		 * 到达目标点处理
		 * 
		 */ 
		public function reachPoint():void{
			var dx:Number = Math.abs(this.coordinate.x - this.targetX);
			var dy:Number = Math.abs(this.coordinate.y - this.targetY);
			if(dx<Math.abs(this.speedX)){//如果两点间的最短距离还不及移动单元 那就直接移动到目标位置
				this.coordinate.x = this.targetX;
				this.isChange = true;
			}
			if(dy<Math.abs(this.speedY)){
				this.coordinate.y = this.targetY;
				this.isChange = true;
			}
			
			
			if(this.coordinate.x == this.targetX&&this.coordinate.y == this.targetY){
				this.stopMove();
				this.isMoveTarget = false;
				this.dispatchEvent(new Event("MOVE_TO_NEXT_TILE"));
			}
		}
		
		/**
		 *鼠标移动  
		 *
		 *
		 */
		public function moveTo(targetX:Number,targetY:Number):void{
			
			
			this.stopMove();
			this.dir = this.getDir(this.coordinate.x,this.coordinate.y,targetX,targetY);
			
			this.switchDir();
			
			this.speedX = 0;
			this.speedY = 0;
			this.speedZ = 0;
			this.targetX = targetX;
			this.targetY = targetY;
			this.setSpeed(this.coordinate.x,this.coordinate.y,targetX,targetY);
			
			
			this.isMoveTarget = true;
			this.startMove();
			
		}
		
		public function switchDir():void{
			
		}
		
		
		//////////////////////////////
		
		
		/**
		 * 
		 * 物理运动
		 * 
		 */ 
		
		protected function move():void{
			
			//trace("movemovemovemove");
			
			/*if(this.speedZ != 0){
				this.speedZ += this.gravity;
				this.coordinate.z += this.speedZ;
				if(this.coordinate.z <= 0){//如果已经落地，则修正，并将z轴速度置为0
					this.coordinate.z = 0;
					this.speedZ = 0;
				}
				this.isChange = true;
			}*/
			
			
			if(this.speedZ != 0){
				this.speedZ += this.gravity;
				this.coordinate.z += this.speedZ;
				if(this.coordinate.z <= 0){//如果已经落地，则修正，并将z轴速度置为0
					//this.coordinate.z = 0;
					this.speedZ = -this.speedZ*this.elastic;
					//trace("弹："+this.speedZ);
					if(Math.abs(this.speedZ)<=0.5){
						//trace("speedz over");
						this.coordinate.z = 0;
						this.speedZ = 0;
					}
				}
				this.isChange = true;
			}
			
			
			if(this.coordinate.z == 0){//如果已经落地
				
				
				if(this.resistance == -1){//不滑动并且停止
					this.speedX = 0;
					this.speedY = 0;
				}else if(this.resistance == -2){//运动
					if(this.speedX != 0){
						this.coordinate.x += this.speedX;
						this.isChange = true;
					}
					if(this.speedY != 0){
						this.coordinate.y += this.speedY;
						this.isChange = true;
					}
				}else{//滑动并摩擦
					var sum:int = this.speedX+this.speedY;
					if(this.speedX != 0){
						var resistanceX:int = (this.speedX/sum)*this.resistance;
						this.speedX -= resistanceX;
						this.coordinate.x += this.speedX;
						this.isChange = true;
					}
					if(this.speedY != 0){
						var resistanceY:int = (this.speedY/sum)*this.resistance;
						this.speedY -= resistanceY;
						this.coordinate.y += this.speedY;
						this.isChange = true;
					}
				}
				
				
			}else{//空中运动
				
				
				if(this.speedX != 0){
					this.coordinate.x += this.speedX;
					this.isChange = true;
				}
				if(this.speedY != 0){
					this.coordinate.y += this.speedY;
					this.isChange = true;
				}
				
				
			}
			
			this.setPosition();
		}
		
		public function setXY(point:Point):void{
			
			
			this.x = point.x;
			this.y = point.y;
			
			
			if(this.onCamera!=null){
				this.onCamera();
			}
			
		}
		
		
		public function setPosition():void{
			
			if(this.isMoveTarget){
				this.reachPoint();
			}
			
			
			if(this.isChange){//如果坐标改变则赋值
				var point:Point = this.coordinate.switchTo2D();
				this.setXY(point);
				this.isChange = false;
			}
			this.setOtherAction();
		}
		
		protected function setOtherAction():void{
			
		}
		
		
		/**
		 * 
		 * 获取方向
		 * 
		 */ 
		public function getDir(x0:Number,y0:Number,x1:Number,y1:Number):int
		{
			var currentAgl:Number = getAngle(x0,y0,x1,y1); //当前角度
			var averageAgl:Number  = 180/4; //平均角度，因为是  360/素材图片拥有方向数*2
			if (currentAgl<averageAgl || currentAgl>=(360-averageAgl)) return 0; //当前角度在x正轴方向顺时平均角度和逆时平均角度之内
			for(var i:int=1;i<4;i++)
			{
				if(currentAgl>=averageAgl*(2*i-1) && currentAgl<averageAgl*(2*i+1)){//取得对应的行数
					return i;
				} 
			}
			return 0; //如果是原地不动
		}
		
		/**
		 * 
		 * 设定速度
		 * 
		 */ 
		public function setSpeed(x0:Number,y0:Number,x1:Number,y1:Number):void{
			
			var dx:Number = x1-x0;
			var dy:Number = y1-y0;
			
			var distance:Number = Math.sqrt(dx*dx+dy*dy);
			if(distance == 0){
				return;
			}
			
			this.speedX = this.speed*(dx/distance);
			this.speedY = this.speed*(dy/distance);
			
		}
		
		
		/**
		 * 
		 *计算角度
		 *
		 */
		public function getAngle(x0:int,y0:int,x1:int,y1:int):Number
		{
			var x:int = x1-x0;
			var y:int = y0-y1;
			
			var _angle:Number = Math.atan(y/x)*(180/Math.PI);
			if(x<0){//以当前位置为 原点  目标位置处于第二第三象限
				return _angle + 180;
			}
			else if(y<0){//处于第四象限
				return _angle + 360;
			}
			return _angle;
			
		}
		
		
		
	}
}