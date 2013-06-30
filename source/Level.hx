
package ;

import org.flixel.addons.FlxCaveGenerator;
import org.flixel.FlxG;
import org.flixel.FlxTilemap;
import org.flixel.FlxRect;
import org.flixel.plugin.photonstorm.FlxMath;
import org.flixel.FlxObject;

class Level extends FlxTilemap
{
	var level: String;

	public function new(tileset: String, width: Int, height: Int)
	{
		super();
		var matrixLength:Int = 100;
		var matrix = new FlxCaveGenerator(matrixLength, matrixLength).generateCaveLevel();
		for (i in 0...matrix.length) {
			for (j in 0...matrix.length) {
				if (matrix[i][j] == 0) {
					var temp = FlxMath.rand(1,11);
					if (temp >= 4 && temp <= 7) {
						var YoN = FlxMath.rand(0,100);
						if (YoN >= 50) {
							matrix[i][j] = temp; 
						} else {
							matrix[i][j] = 8;
						}
					} else {
						matrix[i][j] = temp;
					}	
				} else {
						matrix[i][j] = FlxMath.rand(12,19);
				}
			}
		}
			
		level = FlxCaveGenerator.convertMatrixToStr(matrix);
		
		loadMap(level, tileset, width, height, this.auto);
		for (i in 1...12) {
			this.setTileProperties(i,FlxObject.NONE);
		}

		for (i in 12...20) {
			this.setTileProperties(i,FlxObject.ANY);
		}



		FlxG.worldBounds = new FlxRect(0, 0, this.width-60, this.height);
	}
}