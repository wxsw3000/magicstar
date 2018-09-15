package magicstar.engine.scene.map
{
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import magicstar.engine.display.MagicStarObject;
	
	
	
	public class TileBaseObject extends MagicStarObject
	{
		
		//自我状态
		private var _direction:String;
		public var canUpLeft:Boolean;
		public var canUpRight:Boolean;
		public var canDownLeft:Boolean;
		public var canDownRight:Boolean;
		public var isMoving:Boolean = false;
		public var xTile:int;
		public var yTile:int;
		private var currentTile:Tile;
		//成员
		public var blockBlock:Sprite;
		public var blur:BlurFilter;
		
		
		//外来句柄
		public var map:Map;
		public var isViewHost:Boolean = false;
		
		
	

		public function get direction():String
		{
			return _direction;
		}

		public function set direction(value:String):void
		{
			_direction = value;
			trace("set direction");
			this.dispatchEvent(new Event("DIR_CHANGE"));
		}

		public var doMove:Function;
		
		
		//////////////////////
		
		public var blockW:Number = 40;
		public var blockH:Number = 4;
		
		
		
		public function TileBaseObject()
		{
			this.blockBlock = new Sprite;
			this.addChild(this.blockBlock);
		}
		
		
		public function createBlock():void{
			
			this.blockBlock.graphics.beginFill(0xffffff,0);//1 脚下块
			this.blockBlock.graphics.drawRect(0,0,this.blockW,this.blockH);
			this.blockBlock.graphics.endFill();
			this.blockBlock.x =  - this.blockW/2;
			this.blockBlock.y =  - this.blockH/2;
			
			
		}
		
		public function setModel(model:int):void{
			if(model == 0){
				this.doMove = this.dirMove;
			}else if(model == 1){
				this.doMove = super.move;
			}
		}
		
		
		override protected function move():void{//覆盖了之后父类放入任务列表的是此方法
			this.doMove();//此种写法既是将父类的方法加上子类的方法重新拼装并使用
			this.changeTile();
		}
		
		
		
		
		public function dirMove():void{
			
			
			
			var canMove:Boolean = false;
			
			//trace("getMyCorners speedY="+this.speedY);
			//trace("getMyCorners speedX="+this.speedX);
			
			if(this.speedY>0){//下
				
				
				getMyCorners(this.coordinate.x,this.coordinate.y+speedY);
				
				if(this.canDownLeft&&this.canDownRight){
					canMove = true;
				}else{
					this.speedY = 0;
					this.coordinate.y = (this.yTile+1)*this.map.tileHeight-this.blockBlock.height-this.blockBlock.y;
				}
			}
			
			if(this.speedY<0){//上
				
				
				
				getMyCorners(this.coordinate.x,this.coordinate.y+speedY);
				
				if(this.canUpLeft&&this.canUpRight){
					canMove = true;
				}else{
					this.speedY = 0;
					this.coordinate.y = this.yTile*this.map.tileHeight-this.blockBlock.y;
				}
			}
			
		
			
			if(this.speedX>0){//右
				getMyCorners(this.coordinate.x+speedX,this.coordinate.y);
				if(this.canUpRight&&this.canDownRight){
					canMove = true;
				}else{
					this.speedX = 0;
					this.coordinate.x = (this.xTile+1)*this.map.tileWidth-this.blockBlock.width-this.blockBlock.x;
				}
			}
			
			if(this.speedX<0){//左
				getMyCorners(this.coordinate.x+speedX,this.coordinate.y);
				if(this.canDownLeft&&this.canUpLeft){
					canMove = true;
				}else{ 
					this.speedX = 0;
					this.coordinate.x =  this.xTile*this.map.tileWidth-this.blockBlock.x;
				}
			}
			
			
			if(this.speedZ!=0){
				canMove = true;
			}
			
			
			if(canMove){
				super.move();//在此调用的是父类的move方法，而非此类的move方法
			}
		}
		
		
		
		
		
		
		
		/**
		 * 
		 * 矩形四个点，阻挡判断
		 * 
		 */ 
		public function getMyCorners(coodX:Number, coodY:Number) :void{
			var downY:int = Math.floor((coodY+this.blockBlock.height/2-1)/this.map.tileHeight);
			var upY:int = Math.floor((coodY-this.blockBlock.height/2)/this.map.tileHeight);
			var leftX:int = Math.floor((coodX-this.blockBlock.width/2)/this.map.tileWidth);
			var rightX:int = Math.floor((coodX+this.blockBlock.width/2-1)/this.map.tileWidth);
			//检测他们是否是障碍物
			this.canUpLeft = this.map.isTileWalkable(upY,leftX);
			this.canDownLeft = this.map.isTileWalkable(downY,leftX);
			this.canUpRight = this.map.isTileWalkable(upY,rightX);
			this.canDownRight = this.map.isTileWalkable(downY,rightX);
		}
		
		/**
		 * 
		 * 
		 * 改变tile
		 * 
		 */ 
		public function changeTile():void{
			
			
			
			this.xTile =  Math.floor(this.coordinate.x/this.map.tileWidth);
			this.yTile =  Math.floor(this.coordinate.y/this.map.tileHeight);
			
			trace("this.xTile="+this.xTile);
			trace("this.yTile="+this.yTile);
			
			//actor当前所在的tile
			var tile:Tile = this.map.getFrontTile(this.yTile,this.xTile);
			if(this.currentTile&&tile){
				if(this.currentTile != tile){
					this.currentTile.deleteActor(this);// 将actor删除  
					this.currentTile = tile;
			//		trace(this.modelStr+"this.currentTile="+this.currentTile);
					this.currentTile.addActor(this);
					this.dispatchEvent(new Event("ACTOR_TILE_CHANGE"));//tile改变
				}
			}else{
				this.currentTile = tile;
				this.currentTile.addActor(this);
				this.dispatchEvent(new Event("ACTOR_TILE_CHANGE"));
			}
			
			/*
			* 遮挡深度改变
			*/
			
			/*if(this.map.model.frontTileArray[(this.yTile+1)*this.map.view.mapCols-1].tileBitMap){
				var depth:int = this.map.view.frontSprite.getChildIndex(this.map.model.frontTileArray[(this.yTile+1)*this.map.view.mapCols-1].tileBitMap);
				this.map.view.frontSprite.setChildIndex(this, depth+1);
			}*/
		}
		
	
		
		
		public function get CurrentTile():Tile
		{
			return currentTile;
		}
		
		public function set CurrentTile(value:Tile):void
		{
			currentTile = value;
			this.xTile = currentTile.cols;
			this.yTile = currentTile.row;
			this.currentTile.addActor(this);
		}
		
		
		
	}
}