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
/*
import org.flixel.FlxEmitter;
import org.flixel.FlxParticle;*/
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
		
		// Create player controls
		
		FlxControl.create(Registry.player, FlxControlHandler.MOVEMENT_INSTANT, FlxControlHandler.STOPPING_INSTANT);
		FlxControl.player1.setStandardSpeed(250, false);
		FlxControl.player1.setFireButton("SPACE", FlxControlHandler.KEYMODE_PRESSED, 250, Registry.player.gun.fire);

		
        

		Registry.zombies = new ZombieManager(5, 5000);

		add(Registry.level);
		add(Registry.player);
		add(Registry.zombies);
		add(Registry.player.gun.group);

		/*
		var rainEmitter:FlxEmitter = new FlxEmitter(0, 0, 200);
	    rainEmitter.setSize(FlxG.width, 0);
	    rainEmitter.setXSpeed(5, 5);
	    rainEmitter.setYSpeed(50, 50);
	    rainEmitter.setRotation(0, 0);
	    add(rainEmitter);
	    var rainDrop:FlxParticle;
        for (i in 0...rainEmitter.maxSize) 
        {
            rainDrop = new FlxParticle();
            #if !neko
            rainDrop.makeGraphic(2, 6, 0xFFFFFFFF);
            #else
            rainDrop.makeGraphic(2, 2, {rgb: 0xFFFFFF, a: 0xFF});
            #end
            rainDrop.visible = false; //Make sure the particle doesn't show up at (0, 0)
            rainEmitter.add(rainDrop);
        }
        #if (cpp || neko)
        var myAtlas = createAtlas("particles", 128, 128);
        rainEmitter.atlas = myAtlas;
        #end
		rainEmitter.start(false, 10, .1);*/
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
	
	override public function update():Void {	
		super.update();
		FlxG.collide(Registry.zombies, Registry.level);
		FlxG.collide(Registry.player, Registry.level);
		Registry.level.follow();
		Registry.zombies.callAll("getPath");
		FlxG.overlap(Registry.player.gun.group, Registry.zombies, bulletHitZombie);
	}

}