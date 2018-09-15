package magicstar.sys.init
{

	
	import app.module.init.controller.InitController;
	import app.module.init.view.InitUI;
	
	import magicstar.sys.logger.MagicStarLogger;

	/**
	 * 
	 * 反射注册器
	 * 
	 */
	public class ReflectionRegister
	{
		
		private static var instance:ReflectionRegister;
		
		public static function getInstance():ReflectionRegister{
			if(!instance){
				instance = new ReflectionRegister(new ReflectionRegisterPrivate);
			}
			return instance;
		}
		
		public function ReflectionRegister(param:ReflectionRegisterPrivate)
		{
			MagicStarLogger.getInstance().showLog("系统【ReflectionRegister】：反射注册器创建成功");
		}
		
		public function initReflectionManager():void{
			MagicStarLogger.getInstance().showLog("系统【ReflectionRegister】：注册需要反射的控制器和UI");
			this.registController();
			this.registUI();
		}
		
		
		
		public function registUI():void{
			var initUI:InitUI;

		}
		
		public function registController():void{
			var initController:InitController;

		}
	}
}
class ReflectionRegisterPrivate{}