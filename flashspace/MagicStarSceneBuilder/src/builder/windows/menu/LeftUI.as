package builder.windows.menu
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	
	import builder.res.MagicStarMaterialManager;
	import builder.res.store.FolderModel;
	import builder.style.TextFiltersManager;
	import builder.style.TextFormatManager;
	import builder.windows.respanel.TypeOneMenu;
	import builder.windows.respanel.TypeThrMenu;
	import builder.windows.respanel.TypeTwoMenu;
	
	import fl.controls.Button;
	
	import org.aswing.AsWingManager;
	import org.aswing.BorderLayout;
	import org.aswing.JFrame;
	import org.aswing.JPanel;
	import org.aswing.JScrollPane;
	import org.aswing.JTree;
	import org.aswing.event.ClickCountEvent;
	import org.aswing.event.SelectionEvent;
	import org.aswing.event.TreeSelectionEvent;
	import org.aswing.tree.DefaultMutableTreeNode;
	import org.aswing.tree.DefaultTreeModel;
	import org.aswing.tree.TreePath;

	public class LeftUI extends Sprite
	{
		private static var instance:LeftUI;
		
		public var isBackGround:Boolean;
		//静态图片按钮
		public var typeOneBtn:Button;
		//静态元件按钮
		public var typeTwoBtn:Button;
		//动态元件按钮
		public var typeThrBtn:Button;
		
		
		public static function getInstance():LeftUI{
			if(!instance){
				instance = new LeftUI(new LeftUIPrivate);
			}
			return instance;
		}
		
		public function LeftUI(param:LeftUIPrivate)
		{
			
			/*this.graphics.beginFill(0xFFFFFF,1);
			this.graphics.drawRect(0,0,150,900);
			this.filters = [TextFiltersManager.getInstance().blackFilters];
			this.graphics.endFill();*/
			

			//this.initUI();
			this.testTree();
			
		}
		
		
		
		
		
		/**********************aswing************************/
		
		public function createNode(folder:FolderModel,parentNode:DefaultMutableTreeNode):void{
			var node:DefaultMutableTreeNode = new DefaultMutableTreeNode(folder.folderName);
			parentNode.append(node);
			for(var i:int = 0;i < folder.folderArray.length;i++){
				var cFolder:FolderModel = folder.folderArray[i];
				this.createNode(cFolder,node);
			}
			for(var n:int = 0;n < folder.fileArray.length;n++){
				var file:File = folder.fileArray[n];
				var fileNode:DefaultMutableTreeNode = new DefaultMutableTreeNode(file.name);
				node.append(fileNode);
			}
		}

		
		
		private var tree:JTree;
		private var frame:JFrame;
		
		public function testTree():void{
			AsWingManager.initAsStandard(this);
			frame=new JFrame(this,"资源管理器");
			
			
			var pane:JPanel=new JPanel(new BorderLayout  );
			
			var root:DefaultMutableTreeNode=new DefaultMutableTreeNode("资源库");
			
			
			
			this.createNode(MagicStarMaterialManager.getInstance().rootFolder,root);
			
			
			var model:DefaultTreeModel=new DefaultTreeModel(root);
			
			tree=new JTree  ;
			tree.setModel(model);
			
			pane.append(new JScrollPane(tree),BorderLayout.CENTER);
			frame.setContentPane(pane);
			frame.setSizeWH(250,808);
			
			frame.setResizable(false);
			frame.setDragable(false);
			frame.setClosable(false);
			
			
			frame.show();
			
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		public function initUI():void{
			this.typeOneBtn = new Button;
			this.typeOneBtn.label = "静态图片";
			this.typeOneBtn.width = 150;
			this.typeOneBtn.height = 30;
			this.typeOneBtn.setStyle("textFormat",TextFormatManager.getInstance().black22BlodCenter);
			this.addChild(typeOneBtn);
			this.typeOneBtn.addEventListener(MouseEvent.CLICK,clickTypeBtn);
			
			this.typeTwoBtn = new Button;
			this.typeTwoBtn.label = "静态元件";
			this.typeTwoBtn.width = 150;
			this.typeTwoBtn.height = 30;
			this.typeTwoBtn.setStyle("textFormat",TextFormatManager.getInstance().black22BlodCenter);
			this.addChild(typeTwoBtn);
			this.typeTwoBtn.y = 30;
			this.typeTwoBtn.addEventListener(MouseEvent.CLICK,clickTypeBtn);
			
			this.typeThrBtn = new Button;
			this.typeThrBtn.label = "动态元件";
			this.typeThrBtn.width = 150;
			this.typeThrBtn.height = 30;
			this.typeThrBtn.setStyle("textFormat",TextFormatManager.getInstance().black22BlodCenter);
			this.addChild(typeThrBtn);
			this.typeThrBtn.y = 60;
			
			this.typeThrBtn.addEventListener(MouseEvent.CLICK,clickTypeBtn);
			this.addChild(TypeOneMenu.getInstance());
			this.addChild(TypeTwoMenu.getInstance());
			this.addChild(TypeThrMenu.getInstance());
		}

		/**
		 * 点击资源类型按钮
		 */
		public function clickTypeBtn(event:MouseEvent):void
		{
			var btn:Button = event.currentTarget as Button;
			
			if(btn == typeOneBtn){
				TypeOneMenu.getInstance().visible = true;
				TypeTwoMenu.getInstance().visible = false;
				TypeThrMenu.getInstance().visible = false;
			}else if(btn == typeTwoBtn){
				TypeOneMenu.getInstance().visible = false;
				TypeTwoMenu.getInstance().visible = true;
				TypeThrMenu.getInstance().visible = false;
			}else if(btn == typeThrBtn){
				TypeOneMenu.getInstance().visible = false;
				TypeTwoMenu.getInstance().visible = false;
				TypeThrMenu.getInstance().visible = true;
			}
		}
		
	}
}
class LeftUIPrivate{}