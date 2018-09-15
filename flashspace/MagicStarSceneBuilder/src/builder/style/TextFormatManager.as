package builder.style
{
	import com.greensock.layout.AlignMode;
	import flash.text.TextFormat;
	
	public class TextFormatManager
	{
		private static var instance:TextFormatManager;
		
		public static function getInstance():TextFormatManager
		{
			if(!instance){
				instance = new TextFormatManager;
			}
			return instance;
		}
		
		public var black26BlodCenter:TextFormat;
		
		public var black22BlodLeft:TextFormat;
		
		public var black22BlodCenter:TextFormat;
		public function TextFormatManager()
		{
			black26BlodCenter = new TextFormat;
			black26BlodCenter.size = 26;
			black26BlodCenter.bold = true;
			black26BlodCenter.color = 0x000000;
			black26BlodCenter.align = AlignMode.CENTER;
			black26BlodCenter.font = "宋体";
			
			black22BlodLeft = new TextFormat;
			black22BlodLeft.size = 22;
			black22BlodLeft.bold = true;
			black22BlodLeft.color = 0x000000;
			black22BlodLeft.align = AlignMode.LEFT;
			black22BlodLeft.font = "宋体";
			
			black22BlodCenter = new TextFormat;
			black22BlodCenter.size = 22;
			black22BlodCenter.bold = true;
			black22BlodCenter.color = 0x000000;
			black22BlodCenter.align = AlignMode.CENTER;
			black22BlodCenter.font = "宋体";
		}
	}
}