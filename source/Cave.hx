
package ;

import org.flixel.addons.FlxCaveGenerator;
import org.flixel.FlxTilemap;

class Cave extends FlxTilemap
{
	var cave: String;

	public function new(tileset: String, width: Int, height: Int)
	{
		super();
		cave = FlxCaveGenerator.convertMatrixToStr(new FlxCaveGenerator(100, 100).generateCaveLevel());
		loadMap(cave, tileset, width, height);
	}
}