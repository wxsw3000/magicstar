package builder.windows.menu.components
{
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	import builder.style.MagicStarFormatsManager;

	public class MagicStarMenu extends TextField
	{
		public var clickFunc:Function;
		public var menuType:String;
		
		public function MagicStarMenu(menuType:String)
		{
			this.menuType = menuType;
			this.type = TextFieldType.DYNAMIC;
			this.selectable = false;
			
			this.background = true;
			this.backgroundColor = 0xF5F5F5;
			
			this.defaultTextFormat = MagicStarFormatsManager.getInstance().black22CenterFormat;
			
			
			super.addEventListener(MouseEvent.CLICK,this.onClick);
			super.addEventListener(MouseEvent.MOUSE_OVER,this.onOver);
			super.addEventListener(MouseEvent.MOUSE_OUT,this.onOut);
			
			
		}
		
		
		public function onClick(event:MouseEvent):void{
			if(this.clickFunc!=null){
				this.clickFunc(menuType);
			}
		}
		
		public function onOver(event:MouseEvent):void{
			this.backgroundColor = 0xE1FFFF;
		}
		
		public function onOut(event:MouseEvent):void{
			this.backgroundColor = 0xF5F5F5;
		}
		
	}
}