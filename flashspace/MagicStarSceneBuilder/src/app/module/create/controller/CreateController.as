package app.module.create.controller
{
	import magicstar.sys.flow.promiser.AbstractController;

	public class CreateController extends AbstractController
	{
		public function CreateController()
		{
		}
		
		//本模块入口函数
		override public function startController():void{
			trace("进入create流程");
		}
		
		
		
		
		
		
		
		//本模块终结函数
		override public function terminateController():void{
		}
		
	}
}