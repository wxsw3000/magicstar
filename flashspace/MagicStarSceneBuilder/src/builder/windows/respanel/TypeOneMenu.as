package builder.windows.respanel
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import builder.res.MagicStarMaterialManager;
	import builder.windows.editlayer.map.BackGroundLayer;
	import builder.windows.editlayer.map.ForeGroundLayer;
	import builder.windows.menu.MenuOperator;
	import builder.windows.components.MapResources;
	import builder.windows.components.ScrollSpr;
	import builder.windows.data.VersionVo;
	
	public class TypeOneMenu extends Sprite
	{
		private static var instance:TypeOneMenu;
		
		public static function getInstance():TypeOneMenu
		{
			if(!instance){
				instance = new TypeOneMenu(new TypeOneMenuPrivate);
			}
			return instance;
		}
		
		public var scrollSpr:ScrollSpr;
		public function TypeOneMenu(param:TypeOneMenuPrivate)
		{
			this.visible = true;
			
			this.y = 100;
			this.x = 50;
			
			this.scrollSpr = new ScrollSpr(100,800);
			this.addChild(scrollSpr);
			
			var index:int = 0;
			for each(var vo:VersionVo in MagicStarMaterialManager.getInstance().type1Dic){
				var bitmap:MapResources = new MapResources(vo.fileName,1);
				bitmap.width = 50;
				bitmap.height = 50;
				bitmap.y = 0 + index * 120;
				scrollSpr.placeSpr.addChild(bitmap);
				bitmap.addEventListener(MouseEvent.CLICK,clickTypeOneBitmap);
				index++;
			}
		}
		/**
		 * 点击选中资源
		 */
		public function clickTypeOneBitmap(event:MouseEvent):void
		{
			if(scrollSpr.isMove){
				scrollSpr.isMove = false;
				return;
			}
			
			if(MenuOperator.getInstance().isDelete){
				MenuOperator.getInstance().isDelete = false;
				return;
			}
			
			var mapResources:MapResources = event.currentTarget as MapResources;
			
			if(MenuOperator.getInstance().currentGround == 0){
				BackGroundLayer.getInstance().setMapResources(mapResources.url,mapResources.type);
			}else{
				ForeGroundLayer.getInstance().setMapResources(mapResources.url,mapResources.type);
			}
		}
	}
}
class TypeOneMenuPrivate{}