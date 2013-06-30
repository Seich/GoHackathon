
package ;

import org.flixel.addons.FlxCaveGenerator;
import org.flixel.FlxG;
import org.flixel.FlxTilemap;
import org.flixel.FlxRect;

class Level extends FlxTilemap
{
	var level: String;

	public function new(tileset: String, width: Int, height: Int)
	{
		super();

		var matrix = new FlxCaveGenerator(100, 100).generateCaveLevel();

		level = FlxCaveGenerator.convertMatrixToStr(matrix);
		loadMap(level, tileset, width, height, this.auto);

		FlxG.worldBounds = new FlxRect(0, 0, this.width, this.height);
	}
}