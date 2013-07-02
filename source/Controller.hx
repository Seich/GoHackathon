package ;

import nme.Lib;
import org.flixel.FlxG;
import org.flixel.FlxObject;
import org.flixel.FlxGroup;
import org.flixel.FlxPoint;
import org.flixel.FlxSprite;
import org.flixel.system.input.FlxTouch;
import org.flixel.system.input.FlxTouchManager;
import org.flixel.plugin.photonstorm.FlxWeapon;

class Controller extends FlxGroup
{
	var touchManager: FlxTouchManager;
	var up: FlxSprite;
	var down: FlxSprite;
	var left: FlxSprite;
	var right: FlxSprite;

	var fire: FlxSprite;
	var counter:Float = 0;


	public function new()
	{
		super();

		touchManager = new FlxTouchManager();

		var offset = 10;
		var size = 44;

		up = new FlxSprite();
		up.loadGraphic("assets/data/button_up.png", false, false, size, size);
		up.scrollFactor = new FlxPoint(0, 0);
		up.x = (size * 2);
		up.y = (FlxG.height - (up.height * 2)) - offset;
		up.frame = 1;

		down = new FlxSprite();
		down.loadGraphic("assets/data/button_down.png", false, false, size, size);
		down.scrollFactor = new FlxPoint(0, 0);
		down.x = (size * 2);
		down.y = (FlxG.height - down.height) - 10;
		down.frame = 1;

		left = new FlxSprite();
		left.loadGraphic("assets/data/button_left.png", false, false, size, size);
		left.scrollFactor = new FlxPoint(0, 0);
		left.x = (size * 1);
		left.y = (FlxG.height - left.height) - 10;
		left.frame = 1;

		right = new FlxSprite();
		right.loadGraphic("assets/data/button_right.png", false, false, size, size);
		right.scrollFactor = new FlxPoint(0, 0);
		right.x = (size * 3);
		right.y = (FlxG.height - right.height) - 10;
		right.frame = 1;

		fire = new FlxSprite();
		fire.loadGraphic("assets/data/button_a.png", false, false, size, size);
		fire.scrollFactor = new FlxPoint(0, 0);
		fire.x =  FlxG.width - (size + offset);
		fire.y = (FlxG.height - fire.height) - 10;
		fire.frame = 1;

		add(up);
		add(down);
		add(left);
		add(right);
		add(fire);

		this.setAll("alpha" , 0.7);
	}

	override public function update(): Void
	{
		counter += FlxG.elapsed;

		#if (ios || android)
	    	touchInput();
	    #end
	}

	private function touchInput():Void
	{
	    var touches:Array<FlxTouch> = touchManager.touches;
	    var touch:FlxTouch;
	 
	    for(touch in touches)
	    {
	        if (touch.isActive())
	        {
	            // get touch position (relative to screen)
	            var px:Int = touch.screenX;
	            var py:Int = touch.screenY;

	            if (left.overlapsPoint(new FlxPoint(px, py))) {
	            	left.frame = 2;
	            	Registry.player.velocity.x = -80;
	            	Registry.player._dir = "left";
	            	Registry.player.gun.setBulletDirection(FlxWeapon.BULLET_LEFT, Registry.player.bullet_speed);
	            } else if (right.overlapsPoint(new FlxPoint(px, py))) {
	            	right.frame = 2;
	            	Registry.player.velocity.x = 80;
	            	Registry.player._dir = "right";
	            	Registry.player.gun.setBulletDirection(FlxWeapon.BULLET_RIGHT, Registry.player.bullet_speed);
	            }

	            if (up.overlapsPoint(new FlxPoint(px, py))) {
	            	up.frame = 2;
	            	Registry.player.velocity.y = -80;
	            	Registry.player._dir = "up";
	            	Registry.player.gun.setBulletDirection(FlxWeapon.BULLET_UP, Registry.player.bullet_speed);
	            } else if (down.overlapsPoint(new FlxPoint(px, py))) {
	            	down.frame = 2;
	            	Registry.player.velocity.y = 80;
	            	Registry.player._dir = "down";
	            	Registry.player.gun.setBulletDirection(FlxWeapon.BULLET_DOWN, Registry.player.bullet_speed);
	            }

	            if (fire.overlapsPoint(new FlxPoint(px, py))) {
	            	fire.frame = 2;
	            	if (counter >= 0.5) {
	            		Registry.player.gun.fire();
	            		counter = 0;
	            	}
	            }

	            Registry.player._touch = true;
	        } else {
	        	this.setAll("frame", 1);
	        	Registry.player.velocity = new FlxPoint(0, 0);
	            Registry.player._touch = false;
	        }

	        if (touch.justReleased()) {
	        	this.setAll("frame", 1);
	        	Registry.player.velocity = new FlxPoint(0, 0);
	            Registry.player._touch = false;	
	        }
	    }
	}
}
