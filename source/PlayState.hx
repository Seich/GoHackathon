package ;

import nme.Lib;
import org.flixel.addons.FlxCaveGenerator;
import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.FlxTilemap;
import org.flixel.FlxU;
import org.flixel.FlxPath;
import org.flixel.FlxPoint;
import org.flixel.FlxObject;
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

		// Generate Cave
		Registry.level = new Level("assets/data/scene.png", 60, 60);

		// create Player		
		Registry.player = new Player();

		// Zombehs!		
		Registry.zombies = new ZombieManager(10, 5000);

		// Create player controls
		#if (ios || android)
			Registry.controller = new Controller();
		#else
			FlxControl.create(Registry.player, FlxControlHandler.MOVEMENT_INSTANT, FlxControlHandler.STOPPING_INSTANT);
			FlxControl.player1.setStandardSpeed(250, false);
			FlxControl.player1.setFireButton("SPACE", FlxControlHandler.KEYMODE_PRESSED, 250, Registry.player.gun.fire);
	    #end

		add(Registry.level);
		add(Registry.player);

		add(Registry.zombies);
		add(Registry.player.gun.group);

		#if (ios || android)
			add(Registry.controller);
		#end
	}
	
	override public function destroy():Void {
		FlxControl.clear();
		super.destroy();
	}

	function bulletHitZombie(bullet:FlxObject, enemy:FlxObject):Void {
		var zombie = cast(enemy, Zombie);
		zombie.hurt(1);
		bullet.kill();
	}

	function zombieTouchesCat(zombie:FlxObject, cat:FlxObject) {
		if (!cat.flickering) {
			cat.hurt(1);
			cat.flicker(1);
		}
	}
	
	override public function update():Void {	
		super.update();

		FlxG.overlap(Registry.zombies, Registry.player, zombieTouchesCat);
		FlxG.collide(Registry.zombies, Registry.level);
		FlxG.collide(Registry.player, Registry.level);

		Registry.level.follow();
		Registry.zombies.callAll("getPath");
		FlxG.overlap(Registry.player.gun.group, Registry.zombies, bulletHitZombie);

	}

}