package logo
{
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	
	import magicstar.sys.app.MagicStarApplication;
	
	;

	public class MagicStar extends Sprite
	{
		private static var instance:MagicStar;
		
		
		public var logoPanel:Sprite;//放logo的层，有这一层之后，可以更方便的让图形中央对准整个logo的注册点
		public var star:Sprite;//整个logo
		public var yin:Sprite;
		public var yang:Sprite;
		public var size:Number = 200;
		public var shortSize:Number = 0;
		public var longSize:Number = 0;
		public var eyeSize:Number = 0;
		public var offset:Number = 1;//为了堵住缝隙
		
		public var windowWidth:Number = 1600;
		public var windowHeight:Number = 900;
		
		public static function getInstance():MagicStar{
			if(!instance){
				instance = new MagicStar(new MagicStarprivate);
			}
			return instance;
		}
		
		public function MagicStar(param:MagicStarprivate)
		{
			
			this.graphics.beginFill(0x881c33,1);//881c33   0xf02b2d
			this.graphics.drawRect(0,0,windowWidth,windowHeight);
			this.graphics.endFill();
			
			this.logoPanel = new Sprite;
			this.star = new Sprite;
			
			
			this.logoPanel.x = -size/2;
			this.logoPanel.y = -size/2;
			
			this.star.addChild(this.logoPanel);
			
			
			this.star.x = this.windowWidth/2;
			this.star.y = this.windowHeight/2;
			
			this.addChild(this.star);
			
			this.initSize();
			
			this.draw();
			
			
			
		}
		
		

		
		public function show():void{
			MagicStarApplication.getInstance().CurrentStage.addChild(this);
			this.logoAnimation();
		}
		
		public function hide():void{
			if(this.parent){
				this.parent.removeChild(this);
			}
			this.stopLogoAnimation();
		}
		
		public function logoAnimation():void{
			TweenLite.to(this.star,5,{rotation:360,onComplete:logoAnimation});
		}
		
		public function stopLogoAnimation():void{
			TweenLite.killTweensOf(this.star);
		}
		
		public function initSize():void{
			this.shortSize = size*(1/3);
			//this.shortSize = size*0.382;
			this.longSize = size - this.shortSize;
			this.eyeSize = size/6;
		}
		
		
		
		
		
		/////////////////////////////////
		
		public function draw():void{

			
			this.yin = new Sprite;
			this.yang = new Sprite;
			
			this.logoPanel.addChild(this.yin);
			this.logoPanel.addChild(this.yang);
			this.yang.x = this.shortSize;
			this.drawYin();
			this.drawYang();
		}
		
		public function drawYin():void{
			var yin1:Sprite = new Sprite;
			yin1.graphics.beginFill(0x000000,1);
			yin1.graphics.drawRect(0,0,this.shortSize,size/2+offset);
			yin1.graphics.endFill();
			
			var yin2:Sprite = new Sprite;
			yin2.graphics.beginFill(0x000000,1);
			yin2.graphics.drawRect(0,0,this.longSize,size/2);
			yin2.graphics.endFill();
			
			yin1.x = 0;
			yin1.y = 0;
			
			yin2.x = 0;
			yin2.y = size/2;
			
			this.yin.addChild(yin1);
			this.yin.addChild(yin2);
			
			
			var yinEye:Sprite = new Sprite;
			yinEye.graphics.beginFill(0xfefefe,1);
			yinEye.graphics.drawRect(-eyeSize/2,-eyeSize/2,eyeSize,eyeSize);
			yinEye.graphics.endFill();
			
			yinEye.x = this.shortSize;
			yinEye.y = this.size*(3/4);
			
			this.yin.addChild(yinEye);
			
		}
		
		
		public function drawYang():void{
			var yang1:Sprite = new Sprite;
			yang1.graphics.beginFill(0xfefefe,1);
			yang1.graphics.drawRect(0,0,this.longSize,size/2);
			yang1.graphics.endFill();
			
			var yang2:Sprite = new Sprite;
			yang2.graphics.beginFill(0xfefefe,1);
			yang2.graphics.drawRect(0,0,this.shortSize,size/2+offset);
			yang2.graphics.endFill();
			
			yang1.x = 0;
			yang1.y = 0;
			
			yang2.x = this.longSize - this.shortSize;
			yang2.y = size/2-offset;
			
			this.yang.addChild(yang1);
			this.yang.addChild(yang2);
			
			
			var yangEye:Sprite = new Sprite;
			yangEye.graphics.beginFill(0x000000,1);
			yangEye.graphics.drawRect(-eyeSize/2,-eyeSize/2,eyeSize,eyeSize);
			yangEye.graphics.endFill();
			
			yangEye.x = this.longSize - this.shortSize;
			yangEye.y = this.size*(1/4);
			
			this.yang.addChild(yangEye);
			
		}
		
		
		
		
		
		
		
		
		
		
		/*public function draw1():void{
		
		
		this.yin = new Sprite;
		this.yang = new Sprite;
		
		this.star.addChild(this.yin);
		this.star.addChild(this.yang);
		this.yang.x = size*(1/3);
		this.drawYin1();
		this.drawYang1();
		}
		
		
		public function drawYin1():void{
		var yin1:Sprite = new Sprite;
		yin1.graphics.beginFill(0x000000,1);
		yin1.graphics.drawRect(0,0,size*(1/3),size/2);
		yin1.graphics.endFill();
		
		var yin2:Sprite = new Sprite;
		yin2.graphics.beginFill(0x000000,1);
		yin2.graphics.drawRect(0,0,size*(2/3),size/2);
		yin2.graphics.endFill();
		
		yin1.x = 0;
		yin1.y = 0;
		
		yin2.x = 0;
		yin2.y = size/2;
		
		this.yin.addChild(yin1);
		this.yin.addChild(yin2);
		
		
		
		var eyeWidth:Number = 0;
		var eyeHeight:Number = 0;
		
		var yinEye:Sprite = new Sprite;
		yinEye.graphics.beginFill(0xfefefe,1);
		yinEye.graphics.drawRect(0,0,eyeWidth,eyeHeight);
		}
		
		
		
		
		public function drawYang1():void{
		var yang1:Sprite = new Sprite;
		yang1.graphics.beginFill(0xfefefe,1);
		yang1.graphics.drawRect(0,0,size*(2/3),size/2);
		yang1.graphics.endFill();
		
		var yang2:Sprite = new Sprite;
		yang2.graphics.beginFill(0xfefefe,1);
		yang2.graphics.drawRect(0,0,size*(1/3),size/2);
		yang2.graphics.endFill();
		
		yang1.x = 0;
		yang1.y = 0;
		
		yang2.x = size*(1/3);
		yang2.y = size/2;
		
		this.yang.addChild(yang1);
		this.yang.addChild(yang2);
		}*/
		
		
		
		
		
		
		
		
		
		
		
		
	}
}
class MagicStarprivate{}