package builder.style
{
	import com.greensock.layout.AlignMode;
	
	import flash.text.TextFormat;
	

	public class MagicStarFormatsManager
	{
		//文本样式命名规则
		
		//文本样式-------------  颜色+字号+对齐方式(左<Left>,右<Right>,居中(Center))+文本样式加粗 
		
		//------  如: 白色18号右对齐加粗 --> white18RightBold        白色18号右对齐 --> white18Right
		
		
		//每增加一个新色加一个区
		//***************************************白色区*****************************************//
		/**
		 * 好汉图鉴文本居中
		 * */
		public var handBookCenterFormat:TextFormat;
		/**
		 * 好汉图鉴文本
		 * */
		public var handBookFormat:TextFormat;
		/**
		 * 白色特大号居中
		 * */
		public var white26CenterBold:TextFormat;
		
		/**
		 * 白色26号居中行距17
		 * */
		public var white26CenterBoldLeading17:TextFormat;
		
		
		public var white36CenterBold:TextFormat;
		
		//***************************************红色区*****************************************//
		
		
		
		public var green38LeftFormat:TextFormat;
		
		
		
		
		
		
		
		
		
		
		//***************************************紫色区*****************************************//
		
		
		
		
		
		
		/**
		 * 咖啡色文本
		 * */
		public var brownFormat:TextFormat;
		/**
		 * 橙黄色文本
		 * */
		public var orangeFormat:TextFormat;
		/**
		 * 公用好汉盒子文本
		 * */
		public var publicHeroBoxFormat:TextFormat;
		/**
		 * 招募好汉盒子数据
		 * */
		public var recuitHeroBoxFormat:TextFormat;
		/**
		 * 关卡选择文本
		 * */
		public var stageChooseFormat:TextFormat;
		/**
		 * 兵种天赋绿色文本
		 */
		public var green22BoldLeftFormat:TextFormat;
		/**
		 * 招募绿色文本
		 */
		public var recuitFormat:TextFormat;
		/**
		 * 黑色22号居中字体
		 */
		public var black22CenterFormat:TextFormat;
		/**
		 * 黑色22号靠左字体
		 */
		public var black22LeftFormat:TextFormat;
		/**
		 * 黑色26号居中字体
		 */
		public var black26CenterFormat:TextFormat;
		/**
		 * 黑色26号靠左字体
		 */
		public var black26LeftFormat:TextFormat;
		/**
		 * 白色22号居中字体
		 */
		public var white22CenterBold:TextFormat;
		/**
		 * 白色18号居中字体
		 */
		public var white18CenterBold:TextFormat;
		/**
		 * 白色18号左对齐字体
		 */
		public var white18LeftBold:TextFormat;
		/**
		 * 绿色18号左对齐字体
		 */
		public var green18LeftBold:TextFormat;
		
		/**
		 * 白色18号左对齐字体行距5
		 */
		public var white18LeftBoldLeading5:TextFormat;
		/**
		 * 白色22号靠左字体
		 */
		public var white22LeftBold:TextFormat;
		/**
		 * 白色20号靠左字体行距3
		 */
		public var white20LeftBoldLeading:TextFormat;
		/**
		 * 白色20号靠左字体
		 */
		public var white20LeftBold:TextFormat;
		/**
		 * 白色36号靠左字体
		 */		
		public var white36leftBold:TextFormat;
		
		/**
		 * 蓝色22号居中字体
		 */
		public var blue22CenterBold:TextFormat;
		/**
		* 黄色22号居中字体
		*/
		public var yellow22CenterBold:TextFormat;
		/**
		* 红色22号居中字体
		*/
		public var red22CenterBold:TextFormat;
		/**
		 * 红色22号居左字体
		 */
		public var red22LeftBold:TextFormat;
		
		
		
		
		
		/**
		 * 白32号居中字体
		 */
		public var white32CenterBold:TextFormat;
		/**
		 * 蓝色32号居中字体
		 */
		public var blue32CenterBold:TextFormat;
		/**
		 * 绿色32号居中字体
		 */
		public var green32CenterBold:TextFormat;
		/**
		 * 红色32号居中字体
		 */
		public var red32CenterBold:TextFormat;
		
		
		
		/**
		 * 白色38号居中字体
		 */
		public var white38CenterBold:TextFormat;
		/**
		 * 蓝色38号居中字体
		 */
		public var blue38CenterBold:TextFormat;
		/**
		 * 绿色38号居中字体
		 */
		public var green38CenterBold:TextFormat;
		/**
		 * 红色38号居中字体
		 */
		public var red38CenterBold:TextFormat;
		
		
		/**
		 * 红色25号居中字体
		 */
		public var red20CenterBold:TextFormat;
		
		/**
		 * 白色56号居中字体
		 */
		public var white56CenterBold:TextFormat;
		
		/**
		 * 蓝色56号居中字体
		 */
		public var blue56CenterBold:TextFormat;
		/**
		 * 绿色56号居中字体
		 */
		public var green56CenterBold:TextFormat;
		/**
		 * 红色56号居中字体
		 */
		public var red56CenterBold:TextFormat;
		/**
		 * 绿色22号靠右字体
		 */
		public var green22RightBold:TextFormat;
		
		/**
		 * 白色16号居中字体
		 */
		public var white16CenterBold:TextFormat;
		/**
		 * 红色16号居中字体
		 */
		public var red16CenterBold:TextFormat;
		
		/**
		* 白色12号居中字体
		*/
			public var white14CenterBold:TextFormat;
		/**
		 * 红色12号居中字体
		 */
		public var red14CenterBold:TextFormat;
		
		/**
		 * 黄色12号居中字体
		 */
		public var yellow14CenterBold:TextFormat;
		
		public var green26LeftBold:TextFormat;
		
		
		private static var instance:MagicStarFormatsManager;
		
		public static function getInstance():MagicStarFormatsManager{
			if(!instance){
				instance = new MagicStarFormatsManager(new MagicStarFormatsManagerPrivate);
			}
			return instance;
		}
		
		
		public function MagicStarFormatsManager(param:MagicStarFormatsManagerPrivate)
		{
			this.black22CenterFormat = new TextFormat;
			this.black22CenterFormat.leading=0;
			this.black22CenterFormat.size = 22;
			this.black22CenterFormat.bold = true;
			this.black22CenterFormat.color = 0x000000;
			this.black22CenterFormat.align = AlignMode.CENTER;
			
			this.black22LeftFormat = new TextFormat;
			this.black22LeftFormat.leading=0;
			this.black22LeftFormat.size = 22;
			this.black22LeftFormat.bold = true;
			this.black22LeftFormat.color = 0x000000;
			this.black22LeftFormat.align = AlignMode.LEFT;
			
			this.black26CenterFormat = new TextFormat;
			this.black26CenterFormat.leading=0;
			this.black26CenterFormat.size = 26;
			this.black26CenterFormat.bold = true;
			this.black26CenterFormat.color = 0x000000;
			this.black26CenterFormat.align = AlignMode.CENTER;
			
			this.black26LeftFormat = new TextFormat;
			this.black26LeftFormat.leading=0;
			this.black26LeftFormat.size = 26;
			this.black26LeftFormat.bold = true;
			this.black26LeftFormat.color = 0x000000;
			this.black26LeftFormat.align = AlignMode.LEFT;
			
			this.white22CenterBold = new TextFormat;
			this.white22CenterBold.leading=0;
			this.white22CenterBold.size = 22;
			this.white22CenterBold.bold = true;
			this.white22CenterBold.color = 0xFFFFFF;
			this.white22CenterBold.align = AlignMode.CENTER;
			
			
			this.white16CenterBold = new TextFormat;
			this.white16CenterBold.leading=0;
			this.white16CenterBold.size = 16;
			this.white16CenterBold.bold = true;
			this.white16CenterBold.color = 0xFFFFFF;
			this.white16CenterBold.align = AlignMode.CENTER;
			
			
			this.red16CenterBold = new TextFormat;
			this.red16CenterBold.leading=0;
			this.red16CenterBold.size = 16;
			this.red16CenterBold.bold = true;
			this.red16CenterBold.color = 0xFF0000;
			this.red16CenterBold.align = AlignMode.CENTER;
			
			this.white14CenterBold = new TextFormat;
			this.white14CenterBold.leading=0;
			this.white14CenterBold.size = 14;
			this.white14CenterBold.bold = true;
			this.white14CenterBold.color = 0xFFFFFF;
			this.white14CenterBold.align = AlignMode.CENTER;
			
			
			this.red14CenterBold = new TextFormat;
			this.red14CenterBold.leading=0;
			this.red14CenterBold.size = 12;
			this.red14CenterBold.bold = true;
			this.red14CenterBold.color = 0xFF0000;
			this.red14CenterBold.align = AlignMode.CENTER;
			
			this.yellow14CenterBold = new TextFormat;
			this.yellow14CenterBold.leading=0;
			this.yellow14CenterBold.size = 14;
			this.yellow14CenterBold.bold = true;
			this.yellow14CenterBold.color = 0xffff00;
			this.yellow14CenterBold.align = AlignMode.CENTER;
			
			
			
			this.white18CenterBold = new TextFormat;
			this.white18CenterBold.leading=-2;
			this.white18CenterBold.size = 18;
			this.white18CenterBold.bold = true;
			this.white18CenterBold.color = 0xFFFFFF;
			this.white18CenterBold.align = AlignMode.CENTER;
			
			this.white18LeftBold = new TextFormat;
			this.white18LeftBold.leading=0;
			this.white18LeftBold.size = 18;
			this.white18LeftBold.bold = true;
			this.white18LeftBold.color = 0xFFFFFF;
			this.white18LeftBold.align = AlignMode.LEFT;
			
			
			this.green18LeftBold = new TextFormat;
			this.green18LeftBold.leading=0;
			this.green18LeftBold.size = 18;
			this.green18LeftBold.bold = true;
			this.green18LeftBold.color = 0x00ff00;
			this.green18LeftBold.align = AlignMode.LEFT;
			
			this.white18LeftBoldLeading5 = new TextFormat;
			this.white18LeftBoldLeading5.leading=0;
			this.white18LeftBoldLeading5.size = 18;
			this.white18LeftBoldLeading5.bold = true;
			this.white18LeftBoldLeading5.color = 0xFFFFFF;
			this.white18LeftBoldLeading5.align = AlignMode.LEFT;
			this.white18LeftBoldLeading5.leading=5;
			
			this.blue22CenterBold = new TextFormat;
			this.blue22CenterBold.leading=0;
			this.blue22CenterBold.size = 22;
			this.blue22CenterBold.bold = true;
			this.blue22CenterBold.color = 0x35f1fa;
			this.blue22CenterBold.align = AlignMode.CENTER;
			
			this.yellow22CenterBold = new TextFormat;
			this.yellow22CenterBold.leading=0;
			this.yellow22CenterBold.size = 22;
			this.yellow22CenterBold.bold = true;
			this.yellow22CenterBold.color = 0xFFB618;
			this.yellow22CenterBold.align = AlignMode.CENTER;
			
			this.red22CenterBold = new TextFormat;
			this.red22CenterBold.leading=0;
			this.red22CenterBold.size = 22;
			this.red22CenterBold.bold = true;
			this.red22CenterBold.color = 0xff0000;
			this.red22CenterBold.align = AlignMode.CENTER;
			
			this.red22LeftBold = new TextFormat;
			this.red22LeftBold.leading=0;
			this.red22LeftBold.size = 22;
			this.red22LeftBold.bold = true;
			this.red22LeftBold.color = 0xff0000;
			this.red22LeftBold.align = AlignMode.LEFT;
			
			
			
			this.white32CenterBold = new TextFormat;
			this.white32CenterBold.leading=0;
			this.white32CenterBold.size = 32;
			this.white32CenterBold.bold = true;
			this.white32CenterBold.color = 0xffffff;
			this.white32CenterBold.align = AlignMode.CENTER;
			
			this.blue32CenterBold = new TextFormat;
			this.blue32CenterBold.leading=0;
			this.blue32CenterBold.size = 32;
			this.blue32CenterBold.bold = true;
			this.blue32CenterBold.color = 0x35f1fa;
			this.blue32CenterBold.align = AlignMode.CENTER;
			
			this.green32CenterBold = new TextFormat;
			this.green32CenterBold.leading=0;
			this.green32CenterBold.size = 32;
			this.green32CenterBold.bold = true;
			this.green32CenterBold.color = 0x00ff00;
			this.green32CenterBold.align = AlignMode.CENTER;
			
			this.red32CenterBold = new TextFormat;
			this.red32CenterBold.leading=0;
			this.red32CenterBold.size = 32;
			this.red32CenterBold.bold = true;
			this.red32CenterBold.color = 0xff0000;
			this.red32CenterBold.align = AlignMode.CENTER;
			
			
			this.white56CenterBold = new TextFormat;
			this.white56CenterBold.leading=0;
			this.white56CenterBold.size = 56;
			this.white56CenterBold.bold = true;
			this.white56CenterBold.color = 0xffffff;
			this.white56CenterBold.align = AlignMode.CENTER;
			this.white56CenterBold.leading=60;
			
			this.blue56CenterBold = new TextFormat;
			this.blue56CenterBold.leading=0;
			this.blue56CenterBold.size = 56;
			this.blue56CenterBold.bold = true;
			this.blue56CenterBold.color = 0x35f1fa;
			this.blue56CenterBold.align = AlignMode.CENTER;
			
			this.green56CenterBold = new TextFormat;
			this.green56CenterBold.leading=0;
			this.green56CenterBold.size = 56;
			this.green56CenterBold.bold = true;
			this.green56CenterBold.color = 0x00ff00;
			this.green56CenterBold.align = AlignMode.CENTER;
			
			this.red56CenterBold = new TextFormat;
			this.red56CenterBold.leading=0;
			this.red56CenterBold.size = 56;
			this.red56CenterBold.bold = true;
			this.red56CenterBold.color = 0xff0000;
			this.red56CenterBold.align = AlignMode.CENTER;
			
			
			
			this.white38CenterBold = new TextFormat;
			this.white38CenterBold.leading=0;
			this.white38CenterBold.size = 38;
			this.white38CenterBold.bold = true;
			this.white38CenterBold.color = 0xffffff;
			this.white38CenterBold.align = AlignMode.CENTER;
				
			this.blue38CenterBold = new TextFormat;
			this.blue38CenterBold.leading=0;
			this.blue38CenterBold.size = 38;
			this.blue38CenterBold.bold = true;
			this.blue38CenterBold.color = 0x35f1fa;
			this.blue38CenterBold.align = AlignMode.CENTER;
			
			this.green38CenterBold = new TextFormat;
			this.green38CenterBold.leading=0;
			this.green38CenterBold.size = 38;
			this.green38CenterBold.bold = true;
			this.green38CenterBold.color = 0x00ff00;
			this.green38CenterBold.align = AlignMode.CENTER;
			
			this.red38CenterBold = new TextFormat;
			this.red38CenterBold.leading=0;
			this.red38CenterBold.size = 38;
			this.red38CenterBold.bold = true;
			this.red38CenterBold.color = 0xff0000;
			this.red38CenterBold.align = AlignMode.CENTER;
			
			
			
			this.red20CenterBold = new TextFormat;
			this.red20CenterBold.leading=0;
			this.red20CenterBold.size = 20;
			this.red20CenterBold.bold = true;
			this.red20CenterBold.color = 0xff0000;
			this.red20CenterBold.align = AlignMode.CENTER;
			
			this.white22LeftBold = new TextFormat;
			this.white22LeftBold.leading=0;
			this.white22LeftBold.size = 22;
			this.white22LeftBold.bold = true;
			this.white22LeftBold.color = 0xFFFFFF;
			this.white22LeftBold.align = AlignMode.LEFT;
			
			this.white20LeftBold = new TextFormat;
			this.white20LeftBold.leading=0;
			this.white20LeftBold.size = 20;
			this.white20LeftBold.bold = true;
			this.white20LeftBold.color = 0xFFFFFF;
			this.white20LeftBold.align = AlignMode.LEFT;
			
			this.white20LeftBoldLeading = new TextFormat;
			this.white20LeftBoldLeading.size = 20;
			this.white20LeftBoldLeading.bold = true;
			this.white20LeftBoldLeading.color = 0xFFFFFF;
			this.white20LeftBoldLeading.align = AlignMode.LEFT;
			this.white20LeftBoldLeading.leading=3;
			
			this.publicHeroBoxFormat = new TextFormat;
			this.publicHeroBoxFormat.size = 22;
			this.publicHeroBoxFormat.leading=0;
			this.publicHeroBoxFormat.bold = true;
			this.publicHeroBoxFormat.color = 0xFFFFFF;
			this.publicHeroBoxFormat.align = AlignMode.CENTER;
			
			this.recuitHeroBoxFormat = new TextFormat;
			this.recuitHeroBoxFormat.leading=0;
			this.recuitHeroBoxFormat.size = 22;
			this.recuitHeroBoxFormat.bold = true;
			this.recuitHeroBoxFormat.color = 0x00FF00;
			
			this.stageChooseFormat = new TextFormat;
			this.stageChooseFormat.leading=0;
			this.stageChooseFormat.size = 22;
			this.stageChooseFormat.bold = true;
			this.stageChooseFormat.color = 0xFFFFFF;
			this.stageChooseFormat.align = AlignMode.LEFT;
			
			this.green22BoldLeftFormat = new TextFormat;
			this.green22BoldLeftFormat.leading=0;
			this.green22BoldLeftFormat.size = 22;
			this.green22BoldLeftFormat.bold = true;
			this.green22BoldLeftFormat.color = 0x00FF00;
			this.green22BoldLeftFormat.align = AlignMode.LEFT;
			
			handBookCenterFormat = new TextFormat;
			handBookCenterFormat.leading=0;
			handBookCenterFormat.size = 22;
			handBookCenterFormat.bold = true;
			handBookCenterFormat.color = 0xFFFFFF;
			handBookCenterFormat.align = AlignMode.CENTER;
			
			handBookFormat = new TextFormat;
			handBookFormat.leading=0;
			handBookFormat.size = 22;
			handBookFormat.bold = true;
			handBookFormat.color = 0xFFFFFF;
			
			brownFormat = new TextFormat;
			brownFormat.leading=0;
			brownFormat.size = 22;
			brownFormat.bold = true;
			brownFormat.align = AlignMode.CENTER;
			brownFormat.color = 0x816442;
			
			orangeFormat = new TextFormat;
			orangeFormat.leading=0;
			orangeFormat.size = 25;
			orangeFormat.bold = true;
			orangeFormat.color = 0xFFA94F;
			
			
			white26CenterBold = new TextFormat;
			white26CenterBold.leading=0;
			white26CenterBold.size = 26;
			white26CenterBold.bold = true;
			white26CenterBold.color = 0xFFFFFF;
			white26CenterBold.align = AlignMode.CENTER;
			
			white26CenterBoldLeading17 = new TextFormat;
			white26CenterBoldLeading17.size = 26;
			white26CenterBoldLeading17.bold = true;
			white26CenterBoldLeading17.color = 0xFFFFFF;
			white26CenterBoldLeading17.align = AlignMode.CENTER;
			white26CenterBoldLeading17.leading=17;
			
			white36CenterBold = new TextFormat;
			white36CenterBold.leading=0;
			white36CenterBold.size = 36;
			white36CenterBold.bold = true;
			white36CenterBold.color = 0xFFFFFF;
			white36CenterBold.align = AlignMode.CENTER;
			
			
			white36leftBold = new TextFormat;
			white36leftBold.leading=0;
			white36leftBold.size = 36;
			white36leftBold.bold = true;
			white36leftBold.color = 0xFFFFFF;
			white36leftBold.align = AlignMode.LEFT;
			
			this.recuitFormat = new TextFormat;
			this.recuitFormat.leading=0;
			this.recuitFormat.size = 22;
			this.recuitFormat.bold = true;
			this.recuitFormat.color = 0x00FF00;
			this.recuitFormat.align = AlignMode.CENTER;
			
			
			
			
			
			
			this.green38LeftFormat = new TextFormat;
			this.green38LeftFormat.leading=0;
			this.green38LeftFormat.size = 38;
			this.green38LeftFormat.bold = true;
			this.green38LeftFormat.color = 0x00ff00;
			this.green38LeftFormat.align = AlignMode.LEFT;
			
			this.green26LeftBold=new TextFormat;
			this.green26LeftBold.leading=0;
			this.green26LeftBold.size=26;
			this.green26LeftBold.bold=true;
			this.green26LeftBold.color=0x00ff00;
			this.green26LeftBold.align=AlignMode.LEFT;
			
			this.green22RightBold=new TextFormat;
			this.green22RightBold.leading=0;
			this.green22RightBold.size=22;
			this.green22RightBold.bold=true;
			this.green22RightBold.color=0x35f1fa;
			this.green22RightBold.align=AlignMode.RIGHT;
		}
	}
}
class MagicStarFormatsManagerPrivate{}