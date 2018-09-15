package builder.windows.editlayer
{
	
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.system.Capabilities;
	import flash.text.TextField;
	
	import builder.windows.MagicStarBuilderWindow;
	import builder.style.TextFiltersManager;
	import builder.style.TextFormatManager;

	public class TipsLayer extends Sprite
	{
		private static var instance:TipsLayer;
		
		public static function getInstance():TipsLayer
		{
			if(!instance){
				instance = new TipsLayer;
			}
			return instance;
		}
		
		private var viewWidth:Number = Capabilities.screenResolutionX;
		private var viewHeight:Number = Capabilities.screenResolutionY;
		
		private var tipsSpr:Sprite;
		private var tipsField:TextField;
		public function TipsLayer()
		{
			this.mouseEnabled = false;
			this.mouseChildren = false;
			
			tipsSpr = new Sprite;
			tipsSpr.graphics.beginFill(0xFFFFFF,1);
			tipsSpr.graphics.drawRoundRect(0,0,600,150,10,10);
			tipsSpr.filters = [TextFiltersManager.getInstance().blackFilters];
			tipsSpr.visible = false;
			tipsSpr.alpha = 0;
			this.addChild(tipsSpr);
			
			tipsSpr.x = (viewWidth - 600) / 2;
			tipsSpr.y = (viewHeight - 150) / 2;
			
			tipsField = new TextField;
			tipsField.mouseEnabled = false;
			tipsField.defaultTextFormat = TextFormatManager.getInstance().black26BlodCenter;
			tipsField.filters = [TextFiltersManager.getInstance().whiteFilters];
			tipsField.width = 500;
			tipsField.height = 100;
			tipsField.wordWrap = true;
			tipsField.multiline = true;
			tipsSpr.addChild(tipsField);
			
			tipsField.x = 50;
			tipsField.y = 25;
		}
		
		
		/**
		 * 
		 * 显示tips
		 * 
		 */
		public function showMSG(message:String):void{
			MagicStarBuilderWindow.getInstance().effectLayer.addChild(TipsLayer.getInstance());
			TipsLayer.getInstance().showTips(message);
		}
		
		public function showTips(str:String):void
		{
			tipsField.htmlText = str;
			
			TweenLite.to(tipsSpr,1,{alpha:1,visible:true,onComplete:xiaoshi});
		}
		
		private function xiaoshi():void
		{
			TweenLite.to(tipsSpr,2,{alpha:0,visible:false,onComplete:onClear});
		}
		
		private function onClear():void
		{
			if(this.parent){
				this.parent.removeChild(this);
			}
		}
	}
}