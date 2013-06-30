
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
					matrix[i][j] = FlxMath.rand(1,11);
				} else {
					matrix[i][j] = FlxMath.rand(12,15);
				}
			}
		}
		level = FlxCaveGenerator.convertMatrixToStr(matrix);
		FlxG.log(level);
		loadMap(level, tileset, width, height, this.auto);
		for (i in 1...11) {
			this.setTileProperties(i,FlxObject.NONE);
		}

		for (i in 12...15) {
			this.setTileProperties(i,FlxObject.ANY);
		}



		FlxG.worldBounds = new FlxRect(0, 0, this.width, this.height);
	}
}