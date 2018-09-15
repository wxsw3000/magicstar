package builder.windows.menu
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	import builder.windows.MagicStarBuilderWindow;
	import builder.windows.editlayer.TipsLayer;
	import builder.windows.data.CurrentMapData;
	import builder.style.TextFiltersManager;
	import builder.style.TextFormatManager;
	
	import fl.controls.Button;

	public class CreateSceneUI extends Sprite
	{
		
		private static var instance:CreateSceneUI;
		
		
		public var uiWidth:Number = 400;
		public var uiHeight:Number = 250;
		
		public var mapNameField:TextField = new TextField;
		public var colsField:TextField = new TextField;
		public var rowsField:TextField = new TextField;
		
		
		public static function getInstance():CreateSceneUI{
			if(!instance){
				instance = new CreateSceneUI(new CreateSceneUIPrivate);
			}
			return instance;
		}
		
		public function CreateSceneUI(param:CreateSceneUIPrivate)
		{
			
			this.graphics.beginFill(0xccaacc,1);
			this.graphics.drawRect(0,0,uiWidth,uiHeight);
			this.filters = [TextFiltersManager.getInstance().blackFilters];
			
			var tishi:TextField = new TextField;
			tishi.mouseEnabled = false;
			tishi.defaultTextFormat = TextFormatManager.getInstance().black22BlodLeft;
			tishi.filters = [TextFiltersManager.getInstance().whiteFilters];
			tishi.width = 400;
			tishi.height = 30;
			this.addChild(tishi);
			tishi.htmlText = "输入完行数和列数后请点击确定按钮";
			
			var mapNameLabel:TextField = new TextField;
			mapNameLabel.mouseEnabled = false;
			mapNameLabel.defaultTextFormat = TextFormatManager.getInstance().black22BlodLeft;
			mapNameLabel.filters = [TextFiltersManager.getInstance().whiteFilters];
			mapNameLabel.width = 100;
			mapNameLabel.height = 30;
			mapNameLabel.htmlText = "地图名称：";
			mapNameLabel.x = 0;
			mapNameLabel.y = 50;
			this.addChild(mapNameLabel);
			
			
			var colsLabel:TextField = new TextField;
			colsLabel.mouseEnabled = false;
			colsLabel.defaultTextFormat = TextFormatManager.getInstance().black22BlodLeft;
			colsLabel.filters = [TextFiltersManager.getInstance().whiteFilters];
			colsLabel.width = 100;
			colsLabel.height = 30;
			colsLabel.htmlText = "列数：";
			colsLabel.x = 0;
			colsLabel.y = 100;
			this.addChild(colsLabel);
			
			
			var rowsLabel:TextField = new TextField;
			rowsLabel.mouseEnabled = false;
			rowsLabel.defaultTextFormat = TextFormatManager.getInstance().black22BlodLeft;
			rowsLabel.filters = [TextFiltersManager.getInstance().whiteFilters];
			rowsLabel.width = 100;
			rowsLabel.height = 30;
			rowsLabel.htmlText = "行数：";
			rowsLabel.x = 0;
			rowsLabel.y = 150;
			this.addChild(rowsLabel);
			
			
			mapNameField.background = true;
			mapNameField.backgroundColor = 0xaaccbb;
			mapNameField.type = TextFieldType.INPUT;
			mapNameField.defaultTextFormat = TextFormatManager.getInstance().black22BlodLeft;
			//mapNameField.filters = [TextFiltersManager.getInstance().blackFilters];
			mapNameField.maxChars = 5;
			mapNameField.restrict = "[0-9]";
			mapNameField.width = 120;
			mapNameField.height = 30;
			mapNameField.x = 130;
			mapNameField.y = 50;
			this.addChild(mapNameField);
			
			
			colsField.background = true;
			colsField.backgroundColor = 0xaaccbb;
			colsField.type = TextFieldType.INPUT;
			colsField.defaultTextFormat = TextFormatManager.getInstance().black22BlodLeft;
			//colsField.filters = [TextFiltersManager.getInstance().blackFilters];
			colsField.maxChars = 5;
			colsField.restrict = "[0-9]";
			colsField.width = 120;
			colsField.height = 30;
			colsField.x = 130;
			colsField.y = 100;
			this.addChild(colsField);
			
			
			
			rowsField.background = true;
			rowsField.backgroundColor = 0xaaccbb;
			rowsField.type = TextFieldType.INPUT;
			rowsField.defaultTextFormat = TextFormatManager.getInstance().black22BlodLeft;
			//rowsField.filters = [TextFiltersManager.getInstance().blackFilters];
			rowsField.maxChars = 5;
			rowsField.restrict = "[0-9]";
			rowsField.width = 120;
			rowsField.height = 30;
			rowsField.x = 130;
			rowsField.y = 150;
			this.addChild(rowsField);
			
			var createBtn:Button = new Button;
			createBtn.label = "确定";
			createBtn.setStyle("textFormat",TextFormatManager.getInstance().black22BlodCenter);
			createBtn.width = 100;
			createBtn.height = 40;
			this.addChild(createBtn);
			
			createBtn.x = 80;
			createBtn.y = 200;
			
			createBtn.addEventListener(MouseEvent.CLICK,createScene);//这个函数应该是创建地图的入口函数，非常重要
			
			
			var cancelBtn:Button = new Button;
			cancelBtn.label = "取消";
			cancelBtn.setStyle("textFormat",TextFormatManager.getInstance().black22BlodCenter);
			cancelBtn.width = 100;
			cancelBtn.height = 40;
			this.addChild(cancelBtn);
			
			cancelBtn.x = 190;
			cancelBtn.y = 200;
			
			cancelBtn.addEventListener(MouseEvent.CLICK,cancelCreate);//这个函数应该是创建地图的入口函数，非常重要
			
			
		}
		
		private function cancelCreate(event:MouseEvent):void{
			this.hide();
		}
		
		/**
		 * 点击确定按钮后调用。通过行列数创建地图。
		 */
		private function createScene(e:MouseEvent):void
		{
			if(!this.rowsField.text && this.rowsField.text == ""){
				MagicStarBuilderWindow.getInstance().showTips("请输入地图行数");
				return;
			}else if(!this.colsField.text && this.colsField.text == ""){
				MagicStarBuilderWindow.getInstance().showTips("请输入地图列数");
				return;
			}else if(!this.mapNameField.text && this.mapNameField.text == ""){
				MagicStarBuilderWindow.getInstance().showTips("请输入地图ID");
				return;
			}
			
			var rows:int = int(this.rowsField.text);
			var cols:int = int(this.colsField.text);
			/**
			 * 
			 * builderDataCenter是一个地图的基本数据
			 * 
			 */
			CurrentMapData.getInstance().cols = cols;
			CurrentMapData.getInstance().rows = rows;
			CurrentMapData.getInstance().mapID = this.mapNameField.text;
			
			
			EditorWindow.getInstance().setMapSize(cols,rows);
			
			//MapLayer.getInstance().setMapSize(cols,rows);//初始化编辑区域的大小
			//GridLayer.getInstance().setGridSize(cols,rows);//网格也在此初始化，为什么不能有个统一的设定、修改接口呢。这样会导致业务分离情况下的不一致性
			//MarkLayer.getInstance().setMarkSize(cols,rows);//阻挡显示层，也在此初始化
			
			this.hide();
		}
		
		private function hide():void{
			if(this && this.parent){
				this.parent.removeChild(this);
			}
		}
		
		/**
		 * 
		 * 居中显示创建场景的子页面
		 * 
		 */
		public function show():void{
			
			this.x = (Capabilities.screenResolutionX-this.uiWidth)/2;
			this.y = (Capabilities.screenResolutionY-this.uiHeight)/2;
			MagicStarBuilderWindow.getInstance().showPanel(this);
		}
	}
}
class CreateSceneUIPrivate{}