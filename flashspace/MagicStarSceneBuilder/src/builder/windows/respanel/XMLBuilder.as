package builder.windows.respanel
{
	import flash.net.FileReference;
	import builder.windows.editlayer.map.BackGroundLayer;
	import builder.windows.editlayer.map.ForeGroundLayer;
	import builder.windows.editlayer.struct.MarkLayer;
	
	import builder.windows.data.CurrentMapData;
	
	import builder.windows.components.MapResources;

	public class XMLBuilder
	{
		private static var instance:XMLBuilder;
		
		public static function getInstance():XMLBuilder
		{
			if(!instance){
				instance = new XMLBuilder;
			}
			return instance;
		}
		
		public function XMLBuilder()
		{
		}
		
		private var saveXml:FileReference;
		public function builderXml():void
		{
			var markArr:Array = MarkLayer.getInstance().tileArr;
			
			var xml:XML = new XML("<MapList></MapList>");
			
			var IdXML:XML = new XML; 
			IdXML = <Id>{CurrentMapData.getInstance().mapID}</Id>;
			xml = xml.appendChild(IdXML);
			
			var widthXMl:XML = new XML;
			widthXMl = <colNum>{CurrentMapData.getInstance().cols}</colNum>;
			xml = xml.appendChild(widthXMl);
			
			var heightXML:XML = new XML;
			heightXML = <rowNum>{CurrentMapData.getInstance().rows}</rowNum>;
			xml = xml.appendChild(heightXML);
			
			if(BackGroundLayer.getInstance().numChildren > 0){
				var backGroundXml:XML = new XML("<BackGrounds></BackGrounds>");
				
				for(var i:int = 0;i < BackGroundLayer.getInstance().numChildren;i++){
					var newnode:XML = new XML();
					
					if(BackGroundLayer.getInstance().getChildAt(i).scaleX == 1){
						newnode = <BackGround name={(BackGroundLayer.getInstance().getChildAt(i) as MapResources).url} x={(BackGroundLayer.getInstance().getChildAt(i) as MapResources).x.toString()} y={(BackGroundLayer.getInstance().getChildAt(i) as MapResources).y.toString() } type={(BackGroundLayer.getInstance().getChildAt(i) as MapResources).type.toString()} opposide={false}></BackGround>;
					}else{
						newnode = <BackGround name={(BackGroundLayer.getInstance().getChildAt(i) as MapResources).url} x={(BackGroundLayer.getInstance().getChildAt(i) as MapResources).x.toString()} y={(BackGroundLayer.getInstance().getChildAt(i) as MapResources).y.toString() } type={(BackGroundLayer.getInstance().getChildAt(i) as MapResources).type.toString()} opposide={true}></BackGround>;
					}
					
					backGroundXml = backGroundXml.appendChild(newnode);
				}
				
				xml = xml.appendChild(backGroundXml);
			}
			
			if(ForeGroundLayer.getInstance().numChildren > 0){
				var outLookXml:XML = new XML("<OutLooks></OutLooks>");
				
				for(var o:int = 0;o < ForeGroundLayer.getInstance().numChildren;o++){
					var newNode:XML = new XML();
					
					if(ForeGroundLayer.getInstance().getChildAt(o).scaleX == 1){
						newNode = <OutLook name={(ForeGroundLayer.getInstance().getChildAt(o) as MapResources).url.toString()} x={ForeGroundLayer.getInstance().getChildAt(o).x.toString()} y={ForeGroundLayer.getInstance().getChildAt(o).y.toString()} type={(ForeGroundLayer.getInstance().getChildAt(o) as MapResources).type.toString()} opposide={false}></OutLook>;
					}else{
						newNode = <OutLook name={(ForeGroundLayer.getInstance().getChildAt(o) as MapResources).url.toString()} x={ForeGroundLayer.getInstance().getChildAt(o).x.toString()} y={ForeGroundLayer.getInstance().getChildAt(o).y.toString()} type={(ForeGroundLayer.getInstance().getChildAt(o) as MapResources).type.toString()} opposide={true}></OutLook>;
					}
					
					outLookXml = outLookXml.appendChild(newNode);
				}
				
				xml = xml.appendChild(outLookXml);
			}
			
			if(markArr.length > 0){
				var moveArr:Array = new Array;
				for(var q:int = 0;q < markArr.length;q++){
					if(markArr[q].isMove){
						moveArr.push("0");
					}else{
						moveArr.push("1");
					}
				}
				
				var isMove:String = moveArr.join(",");
				
				var NewNode:XML = new XML("<mark><![CDATA["+isMove+"]]></mark>");
				
				xml = xml.appendChild(NewNode);
			}
			
//			trace(xml);
			
			saveXml = new FileReference;
			saveXml.save(xml,".xml");
		}
	}
}