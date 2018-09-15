package app.module.create.view
{
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import fl.controls.Button;
	
	import magicstar.sys.flow.promiser.AbstractUI;
	
	import builder.res.MagicStarMaterialManager;

	public class CreateUI extends AbstractUI
	{
		
		public var selectTargetButton:Button;
		public var loadingText:TextField;
		
		public function CreateUI()
		{
			this.selectTargetButton = new Button;
			this.selectTargetButton.label = "导入库";
			this.selectTargetButton.x = 650;
			this.selectTargetButton.y = 450;
			this.selectTargetButton.width = 200;
			this.selectTargetButton.height = 100;
			
			
			this.selectTargetButton.addEventListener(MouseEvent.CLICK,importStore);
			this.addChild(this.selectTargetButton);
			
			
			
			this.loadingText = new TextField;
			this.loadingText.selectable = false;
			
			this.loadingText.width = 1000;
			this.loadingText.height = 100;
			this.loadingText.x = 250;
			this.loadingText.y = 450;
			
			var format:TextFormat = new TextFormat;
			format.size = 60;
			format.align = TextFormatAlign.CENTER;
			this.loadingText.defaultTextFormat = format;
			
			
			this.loadingText.visible = false;
			
			this.addChild(this.loadingText);
		}
		
		public function importStore(event:MouseEvent):void{
			this.loadingText.text = "正在为您导入库和配置,请稍候...";
			MagicStarMaterialManager.getInstance().importStore();
		}
		
	}
}