package builder.windows.menu.components
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import builder.windows.MagicStarBuilderWindow;
	import builder.windows.language.MagicStarLanguageManager;
	import builder.windows.menu.MenuOperator;
	import builder.style.TextFiltersManager;
	
	

	public class MenuPanel extends Sprite
	{
		private static var instance:MenuPanel;
		public var isShow:Boolean = false;
		public var fileSprite:Sprite = new Sprite;
		public var editSprite:Sprite = new Sprite;
		public var viewSprite:Sprite = new Sprite;
		
		public static function getInstance():MenuPanel{
			if(!instance){
				instance = new MenuPanel(new MenuPanelPrivate);
			}
			return instance;
		}
		
		public function MenuPanel(param:MenuPanelPrivate)
		{
			var drawWidth:Number = 200;
			var drawHeight:Number = 350;
			
			
			
			this.fileSprite.graphics.beginFill(0xF5F5F5,1);
			this.fileSprite.graphics.drawRect(0,0,drawWidth,drawHeight);
			this.fileSprite.graphics.endFill();
			
			this.editSprite.graphics.beginFill(0xF5F5F5,1);
			this.editSprite.graphics.drawRect(0,0,drawWidth,drawHeight);
			this.editSprite.graphics.endFill();
			
			this.viewSprite.graphics.beginFill(0xF5F5F5,1);
			this.viewSprite.graphics.drawRect(0,0,drawWidth,drawHeight);
			this.viewSprite.graphics.endFill();
			
			
			this.fileSprite.filters = [TextFiltersManager.getInstance().blackFilters];
			this.editSprite.filters = [TextFiltersManager.getInstance().blackFilters];
			this.viewSprite.filters = [TextFiltersManager.getInstance().blackFilters];
			
			
			this.addEventListener(MouseEvent.CLICK,onHide);
			
			/*this.graphics.lineStyle(1,0xA9A9A9);
			this.graphics.moveTo(0,0);
			this.graphics.lineTo(drawWidth,0);
			this.graphics.lineTo(drawWidth,drawHeight);
			this.graphics.lineTo(0,drawHeight);
			this.graphics.lineTo(0,0);*/
			this.initPanel();
		}
		
		public function onHide(event:MouseEvent):void{
			this.hide();
		}
		
		public function show():void{
			this.isShow = true;
			MagicStarBuilderWindow.getInstance().addChild(this);
		}
		
		public function hide():void{
			if(this.parent){
				this.parent.removeChild(this);
				this.isShow = false;
			}
		}
		
		public function openPanel(type:String):void{
			if(this.isShow){
				this.hide();
			}else{
				this.change(type);
				this.show();
			}
		}
		//为什么显示切换没作用呢，我晕
		public function initPanel():void{
			
			//文件：保存
			//编辑：删除、撤销、前移一层、后移一层、移至最后，移至最前，显示一屏、翻转，设置阻挡
			//视图：前景层、背景层、全部层、显示网格、还原大小、
			
			
			
			
			/**
			 * 
			 * 文件面板
			 * 
			 */
			
			//新建按钮
			var newMenu:MagicStarMenu = new MagicStarMenu("new");
			newMenu.text = MagicStarLanguageManager.getInstance().getWords("new");
			newMenu.width = 199;
			newMenu.height = 30;
			newMenu.x = 1;
			newMenu.y = 1;
			this.fileSprite.addChild(newMenu);
			newMenu.addEventListener(MouseEvent.CLICK,MenuOperator.getInstance().onNewScene);//新建场景
			
			//保存按钮
			var saveMenu:MagicStarMenu = new MagicStarMenu("save");
			saveMenu.text = MagicStarLanguageManager.getInstance().getWords("save");
			saveMenu.width = 199;
			saveMenu.height = 30;
			saveMenu.x = 1;
			saveMenu.y = 41;
			this.fileSprite.addChild(saveMenu);
			saveMenu.addEventListener(MouseEvent.CLICK,MenuOperator.getInstance().clickSave);//保存场景
			
			//导入按钮
			var importMenu:MagicStarMenu = new MagicStarMenu("import");
			importMenu.text = MagicStarLanguageManager.getInstance().getWords("import");
			importMenu.width = 199;
			importMenu.height = 30;
			importMenu.x = 1;
			importMenu.y = 81;
			this.fileSprite.addChild(importMenu);
			importMenu.addEventListener(MouseEvent.CLICK,MenuOperator.getInstance().onImportScene);//导入按钮
			
			
			/**
			 * 
			 * 编辑面板
			 * 
			 */
			
			//删除按钮
			var deleteMenu:MagicStarMenu = new MagicStarMenu("delete");
			deleteMenu.text = MagicStarLanguageManager.getInstance().getWords("delete");
			deleteMenu.width = 199;
			deleteMenu.height = 30;
			deleteMenu.x = 1;
			deleteMenu.y = 1;
			this.editSprite.addChild(deleteMenu);
			deleteMenu.addEventListener(MouseEvent.CLICK,MenuOperator.getInstance().clickDelete);//切换到删除元素状态。接下来要改为，删除当前元素。
			
			//撤销回退按钮
			var regressesMenu:MagicStarMenu = new MagicStarMenu("regresses");
			regressesMenu.text = MagicStarLanguageManager.getInstance().getWords("regresses");
			regressesMenu.width = 199;
			regressesMenu.height = 30;
			regressesMenu.x = 1;
			regressesMenu.y = 41;
			this.editSprite.addChild(regressesMenu);
			regressesMenu.addEventListener(MouseEvent.CLICK,MenuOperator.getInstance().regressesOneStep);//将编辑操作回退一步
			
			//移至最前
			var bringForwardMenu:MagicStarMenu = new MagicStarMenu("bringForward");
			bringForwardMenu.text = MagicStarLanguageManager.getInstance().getWords("bringForward");
			bringForwardMenu.width = 199;
			bringForwardMenu.height = 30;
			bringForwardMenu.x = 1;
			bringForwardMenu.y = 81;
			this.editSprite.addChild(bringForwardMenu);
			bringForwardMenu.addEventListener(MouseEvent.CLICK,MenuOperator.getInstance().onBringForward);//将当前所选原件置为最前层（在当前父容器中）
			
			//前移一层按钮
			var forwardMenu:MagicStarMenu = new MagicStarMenu("forward");
			forwardMenu.text = MagicStarLanguageManager.getInstance().getWords("forward");
			forwardMenu.width = 199;
			forwardMenu.height = 30;
			forwardMenu.x = 1;
			forwardMenu.y = 121;
			this.editSprite.addChild(forwardMenu);
			forwardMenu.addEventListener(MouseEvent.CLICK,MenuOperator.getInstance().onForwardOne);//将当前所选原件置为最前层（在当前父容器中）
			
			
			//后移一层按钮
			var backMenu:MagicStarMenu = new MagicStarMenu("back");
			backMenu.text = MagicStarLanguageManager.getInstance().getWords("back");
			backMenu.width = 199;
			backMenu.height = 30;
			backMenu.x = 1;
			backMenu.y = 161;
			this.editSprite.addChild(backMenu);
			backMenu.addEventListener(MouseEvent.CLICK,MenuOperator.getInstance().onBackOne);//当前所选原件往后移一层
			
			//移至最后一层
			var sendBackMenu:MagicStarMenu = new MagicStarMenu("sendBack");
			sendBackMenu.text = MagicStarLanguageManager.getInstance().getWords("sendBack");
			sendBackMenu.width = 199;
			sendBackMenu.height = 30;
			sendBackMenu.x = 1;
			sendBackMenu.y = 201;
			this.editSprite.addChild(sendBackMenu);
			
			sendBackMenu.addEventListener(MouseEvent.CLICK,MenuOperator.getInstance().onSendBack);//将当前所选原件置为最底层
			
			
			
			//镜面翻转
			var mirrorMenu:MagicStarMenu = new MagicStarMenu("mirror");
			mirrorMenu.text = MagicStarLanguageManager.getInstance().getWords("mirror");
			mirrorMenu.width = 199;
			mirrorMenu.height = 30;
			mirrorMenu.x = 1;
			mirrorMenu.y = 241;
			this.editSprite.addChild(mirrorMenu);
			
			mirrorMenu.addEventListener(MouseEvent.CLICK,MenuOperator.getInstance().onMirror);//操作当前的原件图形镜面转逆
			
			
			
			//设置阻挡
			var setBlockMenu:MagicStarMenu = new MagicStarMenu("setBlock");
			setBlockMenu.text = MagicStarLanguageManager.getInstance().getWords("setBlock");
			setBlockMenu.width = 199;
			setBlockMenu.height = 30;
			setBlockMenu.x = 1;
			setBlockMenu.y = 281;
			this.editSprite.addChild(setBlockMenu);
			
			setBlockMenu.addEventListener(MouseEvent.CLICK,MenuOperator.getInstance().onSetBlock);//设置阻挡
			
			
			
			//视图：前景层、背景层、全部层、显示网格、还原大小、
			/**
			 * 
			 * 视图面板
			 * 
			 */
			
			//仅仅显示前层按钮
			var foreLayerMenu:MagicStarMenu = new MagicStarMenu("foreLayer");
			foreLayerMenu.text = MagicStarLanguageManager.getInstance().getWords("foreLayer");
			foreLayerMenu.width = 199;
			foreLayerMenu.height = 30;
			foreLayerMenu.x = 1;
			foreLayerMenu.y = 1;
			this.viewSprite.addChild(foreLayerMenu);
			
			foreLayerMenu.addEventListener(MouseEvent.CLICK,MenuOperator.getInstance().onDisplayForeLayer);//显示场景的前层
			
			
			
			//仅仅显示底层按钮
			var backLayerMenu:MagicStarMenu = new MagicStarMenu("backLayer");
			backLayerMenu.text = MagicStarLanguageManager.getInstance().getWords("backLayer");
			backLayerMenu.width = 199;
			backLayerMenu.height = 30;
			backLayerMenu.x = 1;
			backLayerMenu.y = 41;
			this.viewSprite.addChild(backLayerMenu);
			
			backLayerMenu.addEventListener(MouseEvent.CLICK,MenuOperator.getInstance().onDisplayBackLayer);//显示场景的背景层
			
			
			
			//显示全部层
			var allLayerMenu:MagicStarMenu = new MagicStarMenu("allLayer");
			allLayerMenu.text = MagicStarLanguageManager.getInstance().getWords("allLayer");
			allLayerMenu.width = 199;
			allLayerMenu.height = 30;
			allLayerMenu.x = 1;
			allLayerMenu.y = 81;
			this.viewSprite.addChild(allLayerMenu);
			
			allLayerMenu.addEventListener(MouseEvent.CLICK,MenuOperator.getInstance().onDisplayAllLayer);//显示场景的全部层
			
			
			
			//显示网格
			var showGridMenu:MagicStarMenu = new MagicStarMenu("showGrid");
			showGridMenu.text = MagicStarLanguageManager.getInstance().getWords("showGrid");
			showGridMenu.width = 199;
			showGridMenu.height = 30;
			showGridMenu.x = 1;
			showGridMenu.y = 121;
			this.viewSprite.addChild(showGridMenu);
			
			showGridMenu.addEventListener(MouseEvent.CLICK,MenuOperator.getInstance().onShowGrid);//显示场景中的网格
			
		
			
			//还原大小
			var returnSizeMenu:MagicStarMenu = new MagicStarMenu("returnSize");
			returnSizeMenu.text = MagicStarLanguageManager.getInstance().getWords("returnSize");
			returnSizeMenu.width = 199;
			returnSizeMenu.height = 30;
			returnSizeMenu.x = 1;
			returnSizeMenu.y = 161;
			this.viewSprite.addChild(returnSizeMenu);
			
			returnSizeMenu.addEventListener(MouseEvent.CLICK,MenuOperator.getInstance().onReturnSize);//还原场景的大小
			
		
			
			//显示一屏
			var oneScreenMenu:MagicStarMenu = new MagicStarMenu("showOneScreen");
			oneScreenMenu.text = MagicStarLanguageManager.getInstance().getWords("showOneScreen");
			oneScreenMenu.width = 199;
			oneScreenMenu.height = 30;
			oneScreenMenu.x = 1;
			oneScreenMenu.y = 201;
			this.viewSprite.addChild(oneScreenMenu);
			
			oneScreenMenu.addEventListener(MouseEvent.CLICK,MenuOperator.getInstance().onOneScreen);//在当前场景中显示一屏的大小
			
			
			
			this.fileSprite.x = 0;
			this.editSprite.x = 100;
			this.viewSprite.x = 200;
			
			this.addChild(this.fileSprite);
			this.addChild(this.editSprite);
			this.addChild(this.viewSprite);
			
		}
		
		public function change(type:String):void{
			trace("change:"+type);
			if(type=="file"){
				this.fileSprite.alpha = 1;
				this.editSprite.alpha = 0;
				this.viewSprite.alpha = 0;
			}else if(type=="edit"){
				this.fileSprite.alpha = 0;
				this.editSprite.alpha = 1;
				this.viewSprite.alpha = 0;
			}else if(type=="view"){
				this.fileSprite.alpha = 0;
				this.editSprite.alpha = 0;
				this.viewSprite.alpha = 1;
			}
		}
		
		
		
		
		
		
		
		
		
		
		
	}
}
class MenuPanelPrivate{}