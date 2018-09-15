package magicstar.engine.scene.map
{
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	
	public class Tile extends Sprite
	{
		
			public var middlePoint:Point;
			public var isWalkble:Boolean;
			public var canDestroyed:Boolean;
			public var actors:Array;
			public var registPoint:Point;
			public var tileBitMap:Bitmap;
			public var row:int;
			public var cols:int;
			public var g:int;
			public var h:int;
			public var f:int;
			public var parentTile:Tile;
			
			
			
			public function Tile(type:String)
			{
				if(type=="1"){
					this.isWalkble = false;
				}else{
					this.isWalkble = true;
				}
				
				this.actors = new Array;
			}
			
			public function addActor(actor:Object):void{
				this.actors.push(actor);
			}
			
			
			public function deleteActor(actor:Object):void{
				this.actors.splice(this.actors.indexOf(actor),1);
			}
			
		}
	}