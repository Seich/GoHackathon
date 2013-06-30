package ;

import nme.Lib;
import org.flixel.addons.FlxCaveGenerator;
import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.FlxU;
import org.flixel.FlxTilemap;
import org.flixel.plugin.photonstorm.FlxBar;
import org.flixel.plugin.photonstorm.FlxControl;
import org.flixel.plugin.photonstorm.FlxControlHandler;

class PlayState extends FlxState 
{
	var player: Player;
	var cave: Cave;

	override public function create():Void
	{
		// Load player controller
		if (FlxG.getPlugin(FlxControl) == null)
		{
			FlxG.addPlugin(new FlxControl());
		}

		// Create player
		player = new Player();
		
		// Create player controls
		FlxControl.create(player, FlxControlHandler.MOVEMENT_INSTANT, FlxControlHandler.STOPPING_INSTANT);
		FlxControl.player1.setStandardSpeed(100, false);
		

		// Generate Cave
		cave = new Cave("assets/data/tile.png", 32, 32);


		var zombies = new ZombieManager(5);
		add(zombies);
		add(player);
		add(cave);
	}
	
	override public function destroy():Void
	{
		FlxControl.clear();
		super.destroy();
	}

	override public function update():Void
	{
		super.update();
		FlxG.collide(player, cave);
	}
}