package builder.windows.language
{
	import flash.utils.Dictionary;

	public class MagicStarLanguageManager
	{
		private static var instance:MagicStarLanguageManager;
		
		private var wordsDB:Dictionary;
		
		public static function getInstance():MagicStarLanguageManager{
			if(!instance){
				instance = new MagicStarLanguageManager(new MagicStarLanguageManagerPrivate);
			}
			return instance;
		}
		public function MagicStarLanguageManager(param:MagicStarLanguageManagerPrivate)
		{
			this.wordsDB = new Dictionary;
			
			this.initLanguageDB();
		}
		
		public function getWords(key:String,lanCode:String=null):String{
			if(!lanCode){
				lanCode = "CN";
			}
			var dic:Dictionary = this.wordsDB[lanCode];
			return dic[key];
		}
		/**
		 * 
		 * 初始化一个多国语言库。未来可以使用配置文件
		 * 
		 */
		public function initLanguageDB():void{
			var cnDic:Dictionary = new Dictionary;
			var enDic:Dictionary = new Dictionary;
			
			cnDic["file"] = "文件";
			enDic["file"] = "File";
			
			cnDic["view"]= "视图";
			enDic["view"]= "view";
			
			cnDic["edit"]= "编辑";
			enDic["edit"]= "edit";
			
			cnDic["new"] = "新建";
			enDic["new"] = "new"
			
			cnDic["save"] = "保存";
			enDic["save"] = "Save"
			
			cnDic["import"] = "导入";
			enDic["import"] = "import";
			
			cnDic["foreLayer"]= "前景层";
			enDic["foreLayer"]= "foreLayer";
			
			cnDic["backLayer"]= "背景层";
			enDic["backLayer"]= "backLayer";
			
			cnDic["allLayer"]= "全部层";
			enDic["allLayer"]= "allLayer";
			
			cnDic["delete"]= "删除";
			enDic["delete"]= "delete";
			
			cnDic["regresses"]= "回退";
			enDic["regresses"]= "regresses";
			
			
			
			
			cnDic["showGrid"]= "显示网格";
			enDic["showGrid"]= "showGrid";
			
			cnDic["setBlock"]= "设置阻挡";
			enDic["setBlock"]= "setBlock";
			
			cnDic["returnSize"]= "还原大小";
			enDic["returnSize"]= "returnSize";
			
			cnDic["mirror"]= "镜像翻转";
			enDic["mirror"]= "mirror";
			
			cnDic["bringForward"]= "移至最前";
			enDic["bringForward"]= "bringForward";
			
			cnDic["sendBack"]= "移至最后";
			enDic["sendBack"]= "sendBack";
			
			cnDic["forward"]= "前移一层";
			enDic["forward"]= "forward";
			
			cnDic["back"]= "后移一层";
			enDic["back"]= "back";
			
			cnDic["showOneScreen"]= "显示一屏";
			enDic["showOneScreen"]= "showOneScreen";
			
			
			cnDic["newProject"] = "新建项目";
			cnDic["newProject"] = "new project";
			
			this.wordsDB["CN"] = cnDic;
			this.wordsDB["EN"] = enDic;
			
		}
		
	}
}
class MagicStarLanguageManagerPrivate{}