package  magicstar.sys
{
	import flash.system.System;
	import flash.utils.getTimer;
	
	import magicstar.sys.conf.MagicStarConfigDB;
	import magicstar.sys.flow.MagicStarSectionProcessor;
	import magicstar.sys.init.Sections;
	import magicstar.sys.logger.MagicStarLogger;
	import magicstar.sys.res.conf.MagicStarURLDB;

	/**
	 * 
	 * 流程管理器
	 * 
	 */
	public class MagicStarProcessManager
	{
		
		
		private static var instance:MagicStarProcessManager;
		
		
		//总体的流程管理器，因此该提出来
		public static function getInstance():MagicStarProcessManager{
			if(!instance){
				instance = new MagicStarProcessManager(new MagicStarProcessManagerPrivate);
			}
			return instance;
		}
		
		public function MagicStarProcessManager(param:MagicStarProcessManagerPrivate)
		{
			MagicStarLogger.getInstance().showLog("系统【MagicStarProcessManager】：流程管理器创建成功");
		}
		
		
		//【20180607】系统开始的第一步，加载各种配置文件，并初始化各种管理器。
		public function systemBegin():void{
			
			MagicStarLogger.getInstance().showLog("系统：系统启动前内存占用"+System.privateMemory/1024/1024+"mb");
			MagicStarLogger.getInstance().showLog("系统【MagicStarProcessManager】：正式启动系统");
			
			this.createURLDB();
		}
		/**
		 * 
		 * 加载创建路径库
		 * 
		 */
		public function createURLDB():void{
			MagicStarURLDB.getInstance().createComplete = this.createConfigDB;
			MagicStarURLDB.getInstance().loadLoadURLStore();//【20180607】开始总加载清单的加载，注意加载的是总清单，而不是清单中的项。我们将清单文件称为资源URL管理文件
		}
		/**
		 * 
		 * 加载创建配置库
		 * 
		 */
		public function createConfigDB():void{
			MagicStarConfigDB.getInstance().configCompleteFunc = this.configComplete;
			MagicStarConfigDB.getInstance().loadConfigStore();
		}
		
		
		public function configComplete():void{
			MagicStarLogger.getInstance().showLog("系统【MagicStarProcessManager】：系统配置完成");
			//原初始化各配置数据库的地方，想办法重构
			this.startApp();
		}
		
		
		
		
		
		//框架流程结束，正式开始应用流程
		public function startApp():void{
			//trace("解析xml时间:"+(getTimer()-this.currentTime)/1000+"秒");//解析xml时间:2.767秒 解析xml时间:2.649秒
			MagicStarLogger.getInstance().showLog("Sections.LOGIN 之前"+System.privateMemory/1024/1024+"  mb");
			MagicStarSectionProcessor.getInstance().Section = Sections.INIT;
			MagicStarLogger.getInstance().showLog("Sections.LOGIN 之后"+System.privateMemory/1024/1024+"  mb");
		}
		
	}
}
class MagicStarProcessManagerPrivate{}