package ;

import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxText;
import org.flixel.plugin.photonstorm.FlxBar;
import org.flixel.plugin.photonstorm.FlxControl;
import org.flixel.plugin.photonstorm.FlxControlHandler;
import org.flixel.plugin.photonstorm.FlxWeapon;

class Player extends FlxSprite
{
	var healthBar: FlxBar;
	var bullet_speed = 500;
	public var gun: FlxWeapon;

	public function new()
	{
		super();
		maxVelocity.x = 80;
		maxVelocity.y = 80;
		x = 50;
		y = 50;
		health = 50;

		healthBar = new FlxBar(16, 64, FlxBar.FILL_LEFT_TO_RIGHT, 64, 6, this, "health", 0, 100);
		healthBar.trackParent(-32, -10);

		gun = new FlxWeapon("gun", this);
		gun.makeImageBullet(50, "assets/data/cursor.png");

		FlxG.state.add(gun.group);
	}

	override public function update() :Void 
	{
		super.update();
		FlxG.camera.follow(this);

		if (FlxG.keys.UP) { gun.setBulletDirection(FlxWeapon.BULLET_UP, bullet_speed); }
		if (FlxG.keys.LEFT) { gun.setBulletDirection(FlxWeapon.BULLET_LEFT, bullet_speed); }
		if (FlxG.keys.DOWN) { gun.setBulletDirection(FlxWeapon.BULLET_DOWN, bullet_speed); }
		if (FlxG.keys.RIGHT) { gun.setBulletDirection(FlxWeapon.BULLET_RIGHT, bullet_speed); }
	}
}