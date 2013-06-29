package ;

import org.flixel.FlxSprite;
import org.flixel.FlxG;
import org.flixel.plugin.photonstorm.FlxBar;
import org.flixel.plugin.photonstorm.FlxControl;
import org.flixel.plugin.photonstorm.FlxControlHandler;

class Player extends FlxSprite
{
	var healthBar: FlxBar;

	public function new()
	{
		super();
	}

	public function create() :Void 
	{
		maxVelocity.x = 80;
		maxVelocity.y = 80;
		x = 50;
		y = 50;
		health = 50;

		healthBar = new FlxBar(16, 64, FlxBar.FILL_LEFT_TO_RIGHT, 64, 6, this, "health", 0, 100);
		healthBar.trackParent(-32, -10);
	}

	override public function update() :Void 
	{
		super.update();
		FlxG.camera.follow(this);
	}
}