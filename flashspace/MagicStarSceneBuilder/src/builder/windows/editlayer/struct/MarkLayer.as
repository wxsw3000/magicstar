package builder.windows.editlayer.struct
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import builder.windows.menu.EditorWindow;
	import builder.windows.components.Tile;
	
	public class MarkLayer extends Sprite
	{
		private static var instance:MarkLayer;
		
	
		
		public static function getInstance():MarkLayer
		{
			if(!instance){
				instance = new MarkLayer(new MarkLayerPrivate);
			}
			return instance;
		}
		
		public var isShow:Boolean;
		public var tileArr:Array;
		public var isFirst:Boolean;
		public function MarkLayer(param:MarkLayerPrivate)
		{
			this.visible = false;
			this.isShow = false;
			this.tileArr = new Array;
		}
		
		public function setMarkSize(cols:int, rows:int):void
		{
			if(tileArr.length == 0){
				var mapSize:int = cols * rows;
				var index:int;
				for(var i:int = 0;i < mapSize;i++){
					
					if(index == cols){
						index = 0;
					}
					
					var tile:Tile = new Tile(0,EditorWindow.getInstance().tileWidth,EditorWindow.getInstance().tileHeight);
					this.addChild(tile);
					tileArr.push(tile);
					
					tile.x = EditorWindow.getInstance().tileWidth * index;
					tile.y = EditorWindow.getInstance().tileHeight * int(i / cols);
					index++;
					
					tile.addEventListener(MouseEvent.CLICK,clickTile);
				}
			}
			
			isFirst = true;
		}
		
		public function clickTile(e:MouseEvent):void
		{
			var tile:Tile = e.currentTarget as Tile;
			
			if(tile.isMove){
				tile.isMove = false;
				tile.showSpr.visible = true;
			}else{
				tile.isMove = true;
				tile.showSpr.visible = false;
			}
		}
		
		public function clear():void
		{
			if(tileArr.length > 0){
				for(var i:int = 0;i < tileArr.length;i++){
					if(tileArr[i].parent){
						tileArr[i].parent.removeChild(tileArr[i]);
					}
				}
			}
			
			tileArr = new Array;
		}
	}
}
class MarkLayerPrivate{}