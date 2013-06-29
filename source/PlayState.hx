package ;

import nme.Lib;
import org.flixel.addons.FlxCaveGenerator;
import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.FlxTilemap;
import org.flixel.FlxU;
import org.flixel.plugin.photonstorm.FlxBar;
import org.flixel.plugin.photonstorm.FlxControl;
import org.flixel.plugin.photonstorm.FlxControlHandler;

class PlayState extends FlxState 
{
	override public function create():Void
	{
		// Load player controller
		if (FlxG.getPlugin(FlxControl) == null)
		{
			FlxG.addPlugin(new FlxControl());
		}

		// create Player		
		Registry.player = player = new Player();
		
		// Create player controls
		FlxControl.create(player, FlxControlHandler.MOVEMENT_INSTANT, FlxControlHandler.STOPPING_INSTANT);
		FlxControl.player1.setStandardSpeed(250, false);
		
		// Generate Cave
		Registry.cave = new Cave("assets/data/tile.png", 32, 32);

		add(Registry.cave);
		add(Registry.player);
	}
	
	override public function destroy():Void
	{
		FlxControl.clear();
		super.destroy();
	}

	override public function update():Void
	{	
		super.update();
		FlxG.collide(Registry.player, Registry.cave);
	}
}