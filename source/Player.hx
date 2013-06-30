package ;

import org.flixel.FlxG;
import org.flixel.FlxObject;
import org.flixel.FlxSprite;
import org.flixel.FlxText;
import org.flixel.FlxRect;
import org.flixel.plugin.photonstorm.FlxBar;
import org.flixel.plugin.photonstorm.FlxControl;
import org.flixel.plugin.photonstorm.FlxControlHandler;
import org.flixel.plugin.photonstorm.FlxWeapon;

class Player extends FlxSprite
{
	var healthBar: FlxBar;
	public var bullet_speed:Int = 500;
	public var _dir: String;
	public var gun: FlxWeapon;
	public var _touch: Bool;

	public function new()
	{
		super();

		this.loadGraphic("assets/data/gatos1.png", true, false, 60, 60);
		this.addAnimation("down", [0, 3], 6, false);
		this.addAnimation("up", [4, 7], 6, false);
		this.addAnimation("right", [8, 11], 6, false);
		this.addAnimation("left", [12, 15], 6, false);
		this.play("down");

		health = 5;
		healthBar = new FlxBar(16, 64, FlxBar.FILL_LEFT_TO_RIGHT, 64, 6, this, "health", 0, 100);
		healthBar.trackParent(-32, -10);

		maxVelocity.x = 80;
		maxVelocity.y = 80;
		
		x = 50;
		y = 50;

		gun = new FlxWeapon("gun", this);
		gun.makeImageBullet(50, "assets/data/bullet.png", 50, 5, true);
		gun.bounds = new FlxRect(0, 0, Registry.level.width, Registry.level.height);
	}

	public function worldBound() {
		if(this.x < Registry.level.x)
			this.x = Registry.level.x;
		if(this.x + this.width > Registry.level.x + Registry.level.width)
			this.x = Registry.level.x + Registry.level.width - this.width;
		if(this.y < Registry.level.y)
			this.y = Registry.level.y;
		if(this.y + this.height > Registry.level.y + Registry.level.height)
			this.y = Registry.level.y + Registry.level.height - this.width;
	}

	override public function update() :Void 
	{
		super.update();
		this.worldBound();
		FlxG.camera.follow(this);

		if (FlxG.keys.UP) {
			gun.setBulletDirection(FlxWeapon.BULLET_UP, bullet_speed); 
			this._dir = "up";
		}

		if (FlxG.keys.DOWN) {
			gun.setBulletDirection(FlxWeapon.BULLET_DOWN, bullet_speed); 
			this._dir = "down"; 
		}

		if (FlxG.keys.LEFT) {
		 	gun.setBulletDirection(FlxWeapon.BULLET_LEFT, bullet_speed); 
			this._dir = "left";  
		}

		if (FlxG.keys.RIGHT) {
			gun.setBulletDirection(FlxWeapon.BULLET_RIGHT, bullet_speed); 
			this._dir = "right"; 
		}

		#if (ios || android)
			if (this._touch) {
				this.play(this._dir);
			}
		#else
			if (FlxG.keys.UP || FlxG.keys.DOWN || FlxG.keys.LEFT || FlxG.keys.RIGHT) {
				this.play(this._dir);
			}
		#end
	}
}