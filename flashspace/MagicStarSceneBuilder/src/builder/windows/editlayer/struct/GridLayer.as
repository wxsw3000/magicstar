package builder.windows.editlayer.struct
{
	import flash.display.Sprite;
	
	import builder.windows.menu.EditorWindow;
	import builder.windows.components.Grid;
	
	public class GridLayer extends Sprite
	{
		private static var instance:GridLayer;
		
		public static function getInstance():GridLayer
		{
			if(!instance){
				instance = new GridLayer(new GridLayerPrivate);
			}
			return instance;
		}
		
		public function GridLayer(param:GridLayerPrivate)
		{
			this.visible = false;
			this.mouseEnabled = false;
		}
		
		public function setGridSize(mapWidth:int, mapHeight:int):void
		{
			var mapSize:int = mapWidth * mapHeight;
			var index:int;
			for(var i:int = 0;i < mapSize;i++){
				
				if(index == mapWidth){
					index = 0;
				}
				
				var grid:Grid = new Grid(EditorWindow.getInstance().tileWidth,EditorWindow.getInstance().tileHeight);
				this.addChild(grid);
				
				grid.x = EditorWindow.getInstance().tileWidth * index;
				grid.y = EditorWindow.getInstance().tileHeight * int(i / mapWidth);
				index++;
			}
		}
	}
}
class GridLayerPrivate{}