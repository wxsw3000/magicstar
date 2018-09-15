package builder.res
{
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.utils.Dictionary;
	
	import builder.res.store.FolderModel;
	import builder.windows.data.VersionVo;
	
	
	
	
	
    /**
	 * 
	 * 资源管理器，处理本地资源库的导入，内存中的存储，业务中的资源获取。
	 * 
	 */
	public class MagicStarMaterialManager extends EventDispatcher
	{
		
		private static var instance:MagicStarMaterialManager;
		
		
		public var targetDir:String;//目标文件夹
		public var file:File;//用于读取文件流
		
		
		public var type1Dic:Dictionary;
		public var type2Dic:Dictionary;
		public var type3Dic:Dictionary;
		
		
		
		
		public var rootFolder:FolderModel;		
		
		
		public static function getInstance():MagicStarMaterialManager{
			if(!instance){
				instance = new MagicStarMaterialManager(new SrcManagerPrivate);
			}
			return instance;
		}
		
		
		public function MagicStarMaterialManager(param:SrcManagerPrivate)
		{
			this.type1Dic = new Dictionary;
			this.type2Dic = new Dictionary;
			this.type3Dic = new Dictionary;
			
			
			
		}
		
		
		public var fileTree:Array;
		
		/**
		 * 
		 * 读取本地文件夹结构
		 * 
		 */
		/*public function readLocalStructure():void{
			this.targetDir = File.applicationDirectory.resolvePath("localdata").nativePath;
			var file:File = new File(this.targetDir);
			this.getFileList(file);
		}*/
		/**
		 * 
		 * 获取指定路径下的文件夹结构和相关文件
		 * 
		 */
		/*public function getFileList(dirFile:File):void{
			
			
			this.fileTree = dirFile.getDirectoryListing();
			
			var arr:Array = dirFile.getDirectoryListing();//获取文件夹下所有的文件
			
			
			var fileURL:String;
			
			
			for(var i:int=0;i<arr.length;i++){//遍历这些文件
				var file:File = arr[i] as File;
				fileURL = file.url.replace("file:///","");//获取这些文件的本地url
				trace("fileURL="+fileURL);
				if(file.isDirectory){//如果文件是一个文件夹的话
					var fileURLArray:Array = fileURL.split("/");//分析路径时，将路径拆分出来。
					var dirName:String = fileURLArray[fileURLArray.length-1];//分析当前文件夹的名称
					if(dirName!=".svn"){//主要是为了避免分析了svn中.svn这个文件夹的内容。当时非常周道的设计
						this.getFileList(new File(fileURL));//通过递归，将文件夹下的所有文件都获取
					}
				}else{//如果是一个文件，则获取它
					this.createSrcStore(fileURL);
				}
			}
		}*/
		
		
		
		
		
		
		
		public var targetFile:File;
		
		
		
		/**
		 * 
		 * 读取本地文件
		 * 
		 */
		public function readLocal():void{
			this.targetDir = File.applicationDirectory.resolvePath("localdata").nativePath
			
				//本地安装路径
				//var f:File =  File.applicationDirectory;
				//f = f.resolvePath(File.applicationDirectory.resolvePath("exe/"+gameVo.gameName+".exe").nativePath);
				
			trace(this.targetDir);
			var file:File = new File(this.targetDir);
			
			//this.targetFile = new File(this.targetDir);
			
			this.rootFolder = new FolderModel(this.getFileName(file));
			this.getFile(file,this.rootFolder);
		}
		
		
		
	
		
		
		
		
		
		
		
		
		
		

	
		/**
		 * 
		 * 获取一个文件夹下的文件
		 * 
		 */
		public function getFile(dirFile:File,parentFolder:FolderModel):void{
			
			var arr:Array = dirFile.getDirectoryListing();//获取文件夹下所有的文件
			var fileURL:String;
			
			trace("len="+arr.length+"---"+dirFile.url);
			
			for(var i:int=0;i<arr.length;i++){//遍历这些文件
				var file:File = arr[i] as File;
				fileURL = file.url.replace("file:///","");//获取这些文件的本地url
				trace("fileURL="+fileURL);
				if(file.isDirectory){//如果文件是一个文件夹的话
					var fileName:String = this.getFileName(file);
					trace("文件夹名称="+fileName);
					if(fileName!=".svn"){//主要是为了避免分析了svn中.svn这个文件夹的内容。当时非常周道的设计
						var folder:FolderModel = new FolderModel(fileName);
						parentFolder.addFolder(folder);
						this.getFile(file,folder);//通过递归，将文件夹下的所有文件都获取
					}
				}else{//如果是一个文件，则获取它
					parentFolder.addFile(file);
					this.createSrcStore(fileURL);
				}
			}
		}
		
		
		public function getFileName(file:File):String{
			var fileURLArray:Array = this.getFileURL(file).split("/");//分析路径时，将路径拆分出来。
			return fileURLArray[fileURLArray.length-1];//分析当前文件夹的名称;
		}
		
		public function getFileURL(file:File):String{
			return file.url.replace("file:///","");//获取这些文件的本地url
		}
		
		
		
		/**
		 * 
		 * 生成资源库的数据结构
		 * 
		 */
		public function createSrcStore(fileURL:String):void{
			var dataArray:Array = fileURL.split("/");//同样拆开文件的的url，然后进行分析
			var fileNameArray:Array = (dataArray[dataArray.length-1] as String).split(".");//把具体的文件名称（名称.后缀名）拆开，进行分析。
			if(fileNameArray.length > 1){//如果是一个由后缀名的文件
				var versionVo:VersionVo = new VersionVo;
				versionVo.fileURL = fileURL;
				versionVo.fileName = fileNameArray[0];//文件的名称，和loadConfig的文件名称对应
				versionVo.suffixName = fileNameArray[1];//文件的后缀名
				versionVo.fileURL = versionVo.fileURL.split("/").join("\\");//将反斜杠换为正斜杠，这个很重要，否则读取不了。
				versionVo.loadURL = versionVo.fileURL.replace(this.targetDir,"");//把目标文件夹给去了。loadURL仿佛并没有用于加载，这个变量是否有必要？
				var str:String = versionVo.loadURL;
				str = str.replace("\\"+versionVo.fileName+"."+versionVo.suffixName,"");//值取当前文件所在的文件夹名称，其中包括type1、type2、type3
				versionVo.dirArray = str.split("\\");//由于str还带了斜杠，因此在此切开分析。具体的文件夹名就和斜杠分离了。可以获得文件夹的名称。
				/**
				 * 
				 * 将具体的文件放入不同的资源库。这些不同的资源库，根据其所在文件夹的不同而不同，其中包括type1、type2、type3
				 * 
				 */
				if(versionVo.dirArray[versionVo.dirArray.length-1] == "type1"){
					this.type1Dic[versionVo.fileName] = versionVo;
				}else if(versionVo.dirArray[versionVo.dirArray.length-1] == "type2"){
					this.type2Dic[versionVo.fileName] = versionVo;
				}else if(versionVo.dirArray[versionVo.dirArray.length-1] == "type3"){
					this.type3Dic[versionVo.fileName] = versionVo;
				}
			}
			
			//生成加载列表
			var loadArray:Array = new Array;
			
			for each(var versionVo1:VersionVo in this.type1Dic){
				loadArray.push(versionVo1);
			}
			
			for each(var versionVo2:VersionVo in this.type2Dic){
				loadArray.push(versionVo2);
			}
			
			for each(var versionVo3:VersionVo in this.type3Dic){
				loadArray.push(versionVo3);
			}
			//将加载列表放入加载队列，并开始加载
			MagicStarSrcManager.getInstance().addEventListener("TASK_LOAD_COMPLETE",onSrcLoadOK)
			MagicStarSrcManager.getInstance().initLoadQue(loadArray);
			
			
		}
		
		/**
		 * 
		 * 资源加载完毕后，开始初始化编辑器
		 * 
		 */
		public function onSrcLoadOK(event:Event):void{
			
			this.dispatchEvent(new Event("INIT_EDITOR"));
			
			
		}
		
		
		
	}
}
class SrcManagerPrivate{}