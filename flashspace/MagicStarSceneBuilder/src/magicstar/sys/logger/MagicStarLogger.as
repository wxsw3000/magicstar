package magicstar.sys.logger
{
	public class MagicStarLogger
	{
		
		private static var instance:MagicStarLogger;
		public var step:int=0;
		
		public static function getInstance():MagicStarLogger{
			if(!instance){
				instance = new MagicStarLogger(new MagicStarLoggerPrivate);
			}
			return instance;
		}
		
		public function MagicStarLogger(param:MagicStarLoggerPrivate);
		{
		}
		public function showLog(log:String=null):void{
			trace("log step-"+this.step+":"+log);
			this.step++;
		}
	}
}
class MagicStarLoggerPrivate{}