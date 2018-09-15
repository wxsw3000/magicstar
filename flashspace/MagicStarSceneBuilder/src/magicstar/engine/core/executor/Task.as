package magicstar.engine.core.executor
{
	/**
	 * 
	 * 游戏核心的主频的具体作业单元。
	 * 
	 */
	public class Task
	{
		
		
		public var taskID:int=-1;//为-1则为未进入任务队列状态
		public var execute:Function;
		public var intervalClip:int=0;//间隔帧
		
		public var clip:int = 0;//加入任务始库 帧初始值
		
		
		public function Task()
		{
		}
	}
}