package ;

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
	var player:FlxSprite;
	var tilemap: FlxTilemap;

	override public function create():Void
	{
		if (FlxG.getPlugin(FlxControl) == null)
		{
			FlxG.addPlugin(new FlxControl());
		}

		var cave = FlxCaveGenerator.convertMatrixToStr(new FlxCaveGenerator(100, 100).generateCaveLevel());
		
		tilemap = new FlxTilemap();
		tilemap.loadMap(cave, "assets/data/tile.png", 32, 32);

		player = new FlxSprite(FlxG.width/2 - 5);
		player.makeGraphic(20, 30, 0xffaa1111);
		player.maxVelocity.x = 80;
		player.maxVelocity.y = 80;
		player.x = 50;
		player.y = 50;
		player.health = 50;

		FlxControl.create(player, FlxControlHandler.MOVEMENT_INSTANT, FlxControlHandler.STOPPING_INSTANT);
		FlxControl.player1.setStandardSpeed(100, false);

		var health: FlxBar = new FlxBar(16, 64, FlxBar.FILL_LEFT_TO_RIGHT, 64, 6, player, "health", 0, 100);
		health.trackParent(-32, -10);

		add(tilemap);
		add(player);
		add(health);
	}
	
	override public function destroy():Void
	{
		FlxControl.clear();
		super.destroy();
	}

	override public function update():Void
	{
		super.update();
		FlxG.collide(player, tilemap);
		FlxG.camera.follow(player);
	}
}