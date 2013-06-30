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
import org.flixel.plugin.photonstorm.FlxMath;

class Player extends FlxSprite
{
	var healthBar: FlxBar;
	var bullet_speed = 500;
	var _dir: String;
	var isFiring: String;
	public var gun: FlxWeapon;

	public function new()
	{
		super();

		this.loadGraphic("assets/data/gatos1.png", true, false, 60, 60);
		this.addAnimation("down", [0, 3], 6, false);
		this.addAnimation("up", [4, 7], 6, false);
		this.addAnimation("right", [8, 11], 6, false);
		this.addAnimation("left", [12, 15], 6, false);
		this.addAnimation("fire-down", [16,19],12,false);
		this.addAnimation("fire-right", [20,23],12,false);
		this.addAnimation("fire-left", [24,27],12,false);
		this.addAnimation("fire-up", [4,7], 12,false);
		this.addAnimation("hit",[28,29],12,false);
		this.addAnimation("kill",[28,35],34,false);

		this.play("down");
		health = 5;
		healthBar = new FlxBar(16, 64, FlxBar.FILL_LEFT_TO_RIGHT, 64, 6, this, "health", 0, 100);
		healthBar.trackParent(-32, -10);

		maxVelocity.x = 80;
		maxVelocity.y = 80;

		x = Registry.level.width/2;
		y = Registry.level.height/2;
		
		while(Registry.level.overlaps( this )){
			FlxG.width;
			x = FlxMath.rand((Registry.level.width /2) - ((FlxG.width/2)*2),(Registry.level.width /2) + ((FlxG.width/2)*2)  );
			y = FlxMath.rand((Registry.level.height/2) - ((FlxG.height/2)*2),(Registry.level.height/2) + ((FlxG.height/2)*2)  );
		}	
		

		gun = new FlxWeapon("gun", this);
		gun.makeImageBullet(50, "assets/data/bullet.png", 0, 0, true);
		

		gun.bounds = new FlxRect(0, 0, Registry.level.width, Registry.level.height);
	}
	public function fireGun() {
		if (FlxG.keys.UP) {
			isFiring = "fire-up";
		} else if (FlxG.keys.DOWN) {
			isFiring = "fire-down";
		} else if (FlxG.keys.LEFT) {
			isFiring = "fire-left";
		} if (FlxG.keys.RIGHT) {
			isFiring = "fire-right";
		}
		
		this.gun.fire();

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
			gun.setBulletOffset(30,20);

			this._dir = "up";
		}

		if (FlxG.keys.DOWN) {
			gun.setBulletDirection(FlxWeapon.BULLET_DOWN, bullet_speed);
			gun.setBulletOffset(20,40);

			this._dir = "down"; 
		}

		if (FlxG.keys.LEFT) {
		 	gun.setBulletDirection(FlxWeapon.BULLET_LEFT, bullet_speed);
		 	gun.setBulletOffset(10,28); 
			this._dir = "left";  
		}

		if (FlxG.keys.RIGHT) {
			gun.setBulletDirection(FlxWeapon.BULLET_RIGHT, bullet_speed);
			gun.setBulletOffset(35,28); 
			this._dir = "right"; 
		}

		if (FlxG.keys.UP || FlxG.keys.DOWN || FlxG.keys.LEFT || FlxG.keys.RIGHT) {
			this.play(this._dir);
		}
		if (FlxG.keys.SPACE) {
			
			this.play(this.isFiring);
		}

	}
}