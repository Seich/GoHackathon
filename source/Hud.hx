package ;

import org.flixel.FlxGroup;
import org.flixel.FlxSprite;

class Hud extends FlxGroup
{
	var _score: int;
	var icon: FlxSprite

	public function new()
	{
		this._score = 0;
	} 

	override public function update(): Void {

	}
}