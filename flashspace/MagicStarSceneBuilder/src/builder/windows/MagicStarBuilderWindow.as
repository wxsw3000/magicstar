package builder.windows
{
	import flash.display.Sprite;
	
	import builder.windows.menu.EditorWindow;
	import builder.windows.menu.LeftUI;
	import builder.windows.menu.TopUI;
	import builder.windows.editlayer.TipsLayer;

	/**
	 * 
	 * 此对象是我的编辑器窗口框架，当前需要把editorstage的东西都搬过来
	 * 
	 */
	public class MagicStarBuilderWindow extends Sprite
	{
		private static var instance:MagicStarBuilderWindow;
		
		public var uiLayer:Sprite;
		public var panelLayer:Sprite;
		public var effectLayer:Sprite;
		
		public static function getInstance():MagicStarBuilderWindow{
			if(!instance){
				instance = new MagicStarBuilderWindow(new MagicStarBuildeWindowPrivate);
			}
			return instance;
		}
		public function MagicStarBuilderWindow(param:MagicStarBuildeWindowPrivate)
		{
			this.initLayers();
			
			this.initEditorWindow();
			this.initLeftUI();
			this.initTopUI();
			
		}
		
		public function initLayers():void{
			this.uiLayer = new Sprite;
			this.panelLayer = new Sprite;
			this.effectLayer = new Sprite;
			
			this.addChildAt(this.uiLayer,0);
			this.addChildAt(this.panelLayer,1);
			this.addChildAt(this.effectLayer,2);
		}
		
		
		public function initTopUI():void{
			this.uiLayer.addChild(TopUI.getInstance());
		}
		
		public function initLeftUI():void{
			LeftUI.getInstance().y = 100+1;
			this.uiLayer.addChild(LeftUI.getInstance());
		}
		
		public function initEditorWindow():void{
			EditorWindow.getInstance().y = 100+3;
			EditorWindow.getInstance().x = 250+3;
			this.uiLayer.addChild(EditorWindow.getInstance());
		}
		
		
		public function showPanel(panel:Sprite):void{
			this.panelLayer.addChild(panel);
		}
		
		public function showTips(message:String):void{
			this.effectLayer.addChild(TipsLayer.getInstance());
			TipsLayer.getInstance().showTips(message);
		}
		
		
	}
}
class MagicStarBuildeWindowPrivate{}