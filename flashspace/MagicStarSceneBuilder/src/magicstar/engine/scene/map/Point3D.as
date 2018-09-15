package magicstar.engine.scene.map
{
	import flash.geom.Point;

	public class Point3D
	{
		public var x:Number = 0;
		public var y:Number = 0;
		public var z:Number = 0;
		
		public var projectRate:Number = Math.tan(45*Math.PI/180);
		
		public function Point3D(x:Number=0,y:Number=0,z:Number=0)
		{
			this.x = x;
			this.y = y;
			this.z = z;
		}
		
		public function switchTo2D():Point{
			var point2D:Point = new Point;
		    point2D.x = this.x;
			point2D.y = y - (z/projectRate);
			return point2D;
		}
	}
}