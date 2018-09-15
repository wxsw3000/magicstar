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
	
	public class TypeTwoMenu extends Sprite
	{
		private static var instance:TypeTwoMenu;
		
		public static function getInstance():TypeTwoMenu
		{
			if(!instance){
				instance = new TypeTwoMenu(new TypeTwoMenuPrivate);
			}
			return instance;
		}
		
		public var scrollSpr:ScrollSpr;
		public function TypeTwoMenu(param:TypeTwoMenuPrivate)
		{
			this.visible = false;
			
			this.y = 100;
			this.x = 25;
			
			this.scrollSpr = new ScrollSpr(125,800);
			this.addChild(scrollSpr);
			
			var index:int = 0;
			for each(var vo:VersionVo in MagicStarMaterialManager.getInstance().type2Dic){
				var mc:MapResources = new MapResources(vo.fileName,2);
				mc.width = 100;
				mc.height = 100;
				mc.x = 50;
				mc.y = 50 + index * 120;
				scrollSpr.placeSpr.addChild(mc);
				mc.addEventListener(MouseEvent.CLICK,clickTypeTwoBitmap);
				index++;
			}
		}
		/**
		 * 点击选中资源
		 */
		public function clickTypeTwoBitmap(event:MouseEvent):void
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
class TypeTwoMenuPrivate{}