
package ;

import org.flixel.addons.FlxCaveGenerator;
import org.flixel.FlxG;
import org.flixel.FlxTilemap;
import org.flixel.FlxRect;
import org.flixel.plugin.photonstorm.FlxMath;

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
					matrix[i][j] = FlxMath.rand(0,7);
				} else {
					matrix[i][j] = FlxMath.rand(8,11);
				}
			}
		}
		level = FlxCaveGenerator.convertMatrixToStr(matrix);
		FlxG.log(level);
		loadMap(level, tileset, width, height, this.auto);

		FlxG.worldBounds = new FlxRect(0, 0, this.width, this.height);
	}
}