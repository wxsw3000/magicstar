package magicstar.engine.core
{
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import magicstar.sys.app.MagicStarApplication;
	import magicstar.engine.core.executor.Task;
	
    /**
	 * 
	 * 游戏主频，游戏的演进都由主频控制。此类是核心，控制游戏的任务队列的运行。
	 * 
	 */
	public class TaskManager
	{
		private static var instance:TaskManager;
		
		public var tasks:Dictionary;
		public var generateID:int=0;
		
		
		public static function getInstance():TaskManager{
			if(!instance){
				instance = new TaskManager(new TaskManagerPrivate);	
			}
			return instance;
		}
		
		public function TaskManager(param:TaskManagerPrivate)
		{
			this.tasks = new Dictionary;
		}
		
		public function startAniEngine():void{
			MagicStarApplication.getInstance().CurrentStage.addEventListener(Event.ENTER_FRAME,onEnter);
		}
		
		public function stopAniEngine():void{
			MagicStarApplication.getInstance().CurrentStage.removeEventListener(Event.ENTER_FRAME,onEnter);
		}
		
		public function addTask(taskObj:Task,intervalClip:int=0):void{
			taskObj.intervalClip = intervalClip;
			taskObj.taskID = this.getGenerateID();
			this.tasks[taskObj.taskID] = taskObj;
		}
		/**
		 * 
		 * 添加有时间间隔的任务
		 * 
		 */ 
/*		public function addClipTask(taskObj:Task,intervalClip:int):void{
			taskObj.intervalClip = intervalClip;
			taskObj.taskID = this.getGenerateID();
			this.tasks[taskObj.taskID] = taskObj;
		}*/
		
		public function removeTask(taskObj:Task):void{
			delete this.tasks[taskObj.taskID];
			taskObj.taskID = -1;
		}
		
		private function onEnter(event:Event):void{
			
			
			this.onframeRate();
			//this.onClip();
		}
		
		private function getGenerateID():int{
		   return this.generateID++;
		}
		
		private function onframeRate():void{
			for each(var taskObj:Task in this.tasks){
				//trace("taskObj.intervalClip="+taskObj.intervalClip);
				if(taskObj.intervalClip){//如果设置有间隔时间
					taskObj.clip++;//本任务当前时钟
					if(!(taskObj.clip%taskObj.intervalClip)){
						taskObj.clip = 0;
					//	trace("taskexecute1");
						taskObj.execute();
					}
				}else{
					//trace("taskexecute2");
					taskObj.execute();
				}
				
				
			}
		}
		
		////////////////////////////////////////////////////
		/**
		 * 
		 * 
		 * 
		 */ 
		/*public function addClipTask(taskObj:Task,intervalClip:int):void{
			taskObj.intervalClip = intervalClip;
			var taskDic:Dictionary = this.timeTasks[taskObj.intervalClip];
			if(taskDic){
				taskObj.taskID = this.getGenerateID();
				taskDic[taskObj.taskID] = taskObj;
			}else{
				taskDic = new Dictionary;
				taskObj.taskID = this.getGenerateID();
				taskDic[taskObj.taskID] = taskObj;
				this.timeTasks[taskObj.intervalClip] = taskDic;
			}
		}
		
		public function removeClipTask(taskObj:Task):void{
			var taskDic:Dictionary = this.timeTasks[taskObj.intervalClip];
			if(taskDic){
				var tempTaskObj:Task = taskDic[taskObj.taskID];
				if(tempTaskObj){
					delete taskDic[taskObj.taskID];
				}
			}
		}*/
		
		
		/*private function onClip():void{
			if(this.clipCount >= 25){
				this.clipCount = 0;
			}
			this.clipCount++;
			var taskDic:Dictionary = this.timeTasks[this.clipCount];
			if(taskDic){
				var size:int = 0;
				for each(var taskObj:Task in taskDic){
					taskObj.execute();
					size++;
				}
				if(size==0){
					delete this.timeTasks[this.clipCount];
				}
			}
		}*/
		
		
		
		
		
	}
}
class TaskManagerPrivate{}