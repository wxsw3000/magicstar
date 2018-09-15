package builder.windows.menu
{
	import flash.display.Sprite;
	import flash.system.fscommand;
	
	import builder.style.TextFiltersManager;
	import builder.windows.language.MagicStarLanguageManager;
	import builder.windows.menu.components.MagicStarMenu;
	import builder.windows.menu.components.MenuPanel;
	
	import org.aswing.ASColor;
	import org.aswing.AsWingManager;
	import org.aswing.Container;
	import org.aswing.EmptyLayout;
	import org.aswing.FlowLayout;
	import org.aswing.JFrame;
	import org.aswing.JMenu;
	import org.aswing.JMenuBar;
	import org.aswing.JMenuItem;
	import org.aswing.JPanel;
	import org.aswing.JWindow;
	import org.aswing.KeySequence;
	import org.aswing.KeyStroke;
	import org.aswing.border.LineBorder;
	import org.aswing.event.AWEvent;
	

	public class TopUI extends Sprite
	{
		private static var instance:TopUI;
		public static function getInstance():TopUI{
			if(!instance){
				instance = new TopUI(new TopUIPrivate);
			}
			return instance;
		}
		
		public function TopUI(param:TopUIPrivate)
		{
			/*this.graphics.beginFill(0xF5F5F5,1);//0xFFFFFF
			this.graphics.drawRect(0,0,1800,100);
			this.filters = [TextFiltersManager.getInstance().blackFilters];
			this.graphics.endFill();*/
			
			//this.initTopMenu();
			
			this.initMenuBar();
		}
		
		
		public function initMenuBar():void{
			//初始化
			AsWingManager.initAsStandard(this);
			//容器
			//var window:JWindow = new JWindow();
			
			var window:JFrame = new JFrame
			window.setSizeWH(1600,100);
			window.setLocationXY(0,0);
			window.setBorder(new LineBorder());
			//window.setBackground(new ASColor(0xFF0000));
			
			window.getContentPane().setLayout(new EmptyLayout());
			var pane:Container = window.getContentPane();
			pane.setLayout(new FlowLayout());
			window.show();
			
			//菜单栏
			var menuBar:JMenuBar = new JMenuBar();
			pane.append(menuBar);
			
			var fileMenu:JMenu = new JMenu(MagicStarLanguageManager.getInstance().getWords("file"));
			var editMenu:JMenu = new JMenu(MagicStarLanguageManager.getInstance().getWords("edit"));
			var viewMenu:JMenu = new JMenu(MagicStarLanguageManager.getInstance().getWords("view"));
			
			menuBar.append(fileMenu);
			menuBar.append(editMenu);
			menuBar.append(viewMenu);
			
			
			
			
			var newMenuItem:JMenuItem = new JMenuItem(MagicStarLanguageManager.getInstance().getWords("new"));
			var saveMenuItem:JMenuItem = new JMenuItem(MagicStarLanguageManager.getInstance().getWords("save"));
			var importMenuItem:JMenuItem = new JMenuItem(MagicStarLanguageManager.getInstance().getWords("import"));
			
			fileMenu.append(newMenuItem);
			fileMenu.append(saveMenuItem);
			fileMenu.append(importMenuItem);
			
			newMenuItem.addActionListener(MenuOperator.getInstance().onNewScene);
			saveMenuItem.addActionListener(MenuOperator.getInstance().clickSave);
			importMenuItem.addActionListener(MenuOperator.getInstance().onImportScene);
			
			
			var deleteMenuItem:JMenuItem = new JMenuItem(MagicStarLanguageManager.getInstance().getWords("delete"));
			var regressesMenuItem:JMenuItem = new JMenuItem(MagicStarLanguageManager.getInstance().getWords("regresses"));
			var bringForwardMenuItem:JMenuItem = new JMenuItem(MagicStarLanguageManager.getInstance().getWords("bringForward"));
			var forwardMenuItem:JMenuItem = new JMenuItem(MagicStarLanguageManager.getInstance().getWords("forward"));
			var backMenuItem:JMenuItem = new JMenuItem(MagicStarLanguageManager.getInstance().getWords("back"));
			var sendBackMenuItem:JMenuItem = new JMenuItem(MagicStarLanguageManager.getInstance().getWords("sendBack"));
			var mirrorMenuItem:JMenuItem = new JMenuItem(MagicStarLanguageManager.getInstance().getWords("mirror"));
			var setBlockMenuItem:JMenuItem = new JMenuItem(MagicStarLanguageManager.getInstance().getWords("setBlock"));
			
			editMenu.append(deleteMenuItem);
			editMenu.append(regressesMenuItem);
			editMenu.append(bringForwardMenuItem);
			editMenu.append(forwardMenuItem);
			editMenu.append(backMenuItem);
			editMenu.append(sendBackMenuItem);
			editMenu.append(mirrorMenuItem);
			editMenu.append(setBlockMenuItem);
			
			deleteMenuItem.addActionListener(MenuOperator.getInstance().clickDelete);
			regressesMenuItem.addActionListener(MenuOperator.getInstance().regressesOneStep);
			bringForwardMenuItem.addActionListener(MenuOperator.getInstance().onBringForward);
			forwardMenuItem.addActionListener(MenuOperator.getInstance().onForwardOne);
			backMenuItem.addActionListener(MenuOperator.getInstance().onBackOne);
			sendBackMenuItem.addActionListener(MenuOperator.getInstance().onSendBack);
			mirrorMenuItem.addActionListener(MenuOperator.getInstance().onMirror);
			setBlockMenuItem.addActionListener(MenuOperator.getInstance().onSetBlock);
		
			
			
			
			var foreLayerMenuItem:JMenuItem = new JMenuItem(MagicStarLanguageManager.getInstance().getWords("foreLayer"));
			var backLayerMenuItem:JMenuItem = new JMenuItem(MagicStarLanguageManager.getInstance().getWords("backLayer"));
			var allLayerMenuItem:JMenuItem = new JMenuItem(MagicStarLanguageManager.getInstance().getWords("allLayer"));
			var showGridMenuItem:JMenuItem = new JMenuItem(MagicStarLanguageManager.getInstance().getWords("showGrid"));
			var returnSizeMenuItem:JMenuItem = new JMenuItem(MagicStarLanguageManager.getInstance().getWords("returnSize"));
			var showOneScreenMenuItem:JMenuItem = new JMenuItem(MagicStarLanguageManager.getInstance().getWords("showOneScreen"));
			
			viewMenu.append(foreLayerMenuItem);
			viewMenu.append(backLayerMenuItem);
			viewMenu.append(allLayerMenuItem);
			viewMenu.append(showGridMenuItem);
			viewMenu.append(returnSizeMenuItem);
			viewMenu.append(showOneScreenMenuItem);
			
			foreLayerMenuItem.addActionListener(MenuOperator.getInstance().onDisplayForeLayer);
			backLayerMenuItem.addActionListener(MenuOperator.getInstance().onDisplayBackLayer);
			allLayerMenuItem.addActionListener(MenuOperator.getInstance().onDisplayAllLayer);
			showGridMenuItem.addActionListener(MenuOperator.getInstance().onShowGrid);
			returnSizeMenuItem.addActionListener(MenuOperator.getInstance().onReturnSize);
			showOneScreenMenuItem.addActionListener(MenuOperator.getInstance().onOneScreen);
			
			
			/*var menu1:JMenu = new JMenu("文件(&F)");
			menuBar.append(menu1);
			
			var menuItem3:JMenuItem = new JMenuItem("导入(&M)");
			var menuItem4:JMenuItem = new JMenuItem("导出(&N)");
			menuItem3.addActionListener(menuAction);
			menuItem4.addActionListener(menuAction);
			//助记键
			menuItem3.setAccelerator(new KeySequence(KeyStroke.VK_CONTROL,KeyStroke.VK_M));
			menuItem4.setAccelerator(new KeySequence(KeyStroke.VK_CONTROL,KeyStroke.VK_N));
			
			menu1.append(menuItem3);
			menu1.append(menuItem4);
			
			var menu:JMenu = new JMenu("编辑(&E)");
			menuBar.append(menu);
			
			var menuItem1:JMenuItem = new JMenuItem("保存(&S)");
			var menuItem2:JMenuItem = new JMenuItem("关闭(&C)");
			menuItem1.addActionListener(menuAction);
			menuItem2.addActionListener(menuAction);
			//助记键
			menuItem1.setAccelerator(new KeySequence(KeyStroke.VK_CONTROL,KeyStroke.VK_S));
			menuItem2.setAccelerator(new KeySequence(KeyStroke.VK_CONTROL,KeyStroke.VK_C));
			menu.append(menuItem1);
			menu.append(menuItem2);*/
			
			fscommand("trapallkeys", "true");
		}
		
		
		
		
		
		
		
		
		
		
		
		private function menuAction(e:AWEvent):void{
			var menu:JMenuItem = e.currentTarget as JMenuItem;
			trace(menu.getText() + " clicked!");
		}
		
		
		public function initTopMenu():void{
			
			
			var fileMenu:MagicStarMenu = new MagicStarMenu("file");
			fileMenu.text = MagicStarLanguageManager.getInstance().getWords("file");
			fileMenu.width = 80;
			fileMenu.height = 30;
			this.addChild(fileMenu);
			
			MenuPanel.getInstance().y = 30;
			
			fileMenu.clickFunc = MenuPanel.getInstance().openPanel;
			
			var editMenu:MagicStarMenu = new MagicStarMenu("edit");
			editMenu.text = MagicStarLanguageManager.getInstance().getWords("edit");
			editMenu.width = 80;
			editMenu.height = 30;
			editMenu.x = 100;
			this.addChild(editMenu);
			
			MenuPanel.getInstance().y = 30;
			
			editMenu.clickFunc = MenuPanel.getInstance().openPanel;
			
			
			var viewMenu:MagicStarMenu = new MagicStarMenu("view");
			viewMenu.text = MagicStarLanguageManager.getInstance().getWords("view");
			viewMenu.width = 80;
			viewMenu.height = 30;
			viewMenu.x = 200;
			this.addChild(viewMenu);
			
			MenuPanel.getInstance().y = 30;
			
			viewMenu.clickFunc = MenuPanel.getInstance().openPanel;
		}
	}
}
class TopUIPrivate{}