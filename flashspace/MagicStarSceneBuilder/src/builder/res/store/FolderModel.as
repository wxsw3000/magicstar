package builder.res.store
{
	import flash.filesystem.File;

	public class FolderModel
	{
		public var folderName:String;
		public var folderArray:Array;
		public var fileArray:Array;
		
		public function FolderModel(name:String)
		{
			this.folderName = name;
			this.folderArray = new Array;
			this.fileArray = new Array;
		}
		
		public function addFolder(folder:FolderModel):void{
			this.folderArray.push(folder);
		}
		
		public function addFile(file:File):void{
			this.fileArray.push(file);
		}
		
	}
}