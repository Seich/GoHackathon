package ;

import org.flixel.FlxG;
import org.flixel.FlxObject;
import org.flixel.FlxSprite;
import org.flixel.plugin.photonstorm.FlxCollision;
import org.flixel.plugin.photonstorm.FlxMath;
import org.flixel.FlxPoint;
import org.flixel.FlxPath;
import org.flixel.plugin.photonstorm.FlxBar;
import org.flixel.FlxTimer;


class Zombie extends FlxSprite {
	public var speed:Int;
    var targ:FlxSprite;
    var playerPath:FlxPath;
    var healthBar: FlxBar;

	public function new() {
        super(0, 0);
        this.loadGraphic("assets/data/zombie1.png", true, false, 60, 60);
        this.addAnimation("down", [0, 3], 6, false);
        this.addAnimation("up", [4, 7], 6, false);
        this.addAnimation("right", [8, 11], 6, false);
        this.addAnimation("left", [12, 15], 6, false);
        this.addAnimation("kill",[16,19], 9, false);
        this.addAnimation("hit-down", [20,21],4,false);
        this.addAnimation("hit-right",[22],6,false);
        this.addAnimation("hit-left",[23],6,false);
        this.addAnimation("hit-up",[8,9],6,false);
        this.addAnimation("attack-down",[24,25],6,false);
        this.addAnimation("attack-up",[26,27],6,false);
        this.addAnimation("attack-right",[28,29],6,false);
        this.addAnimation("attack-left",[30,31],6,false);

        this.play("down");

        this.speed = FlxMath.rand(50, 75);
        this.exists = false;
        this.health = 4;

        healthBar = new FlxBar(16, 64, FlxBar.FILL_LEFT_TO_RIGHT, 64, 6, this, "health", 0, 100);
        healthBar.trackParent(-32, -10);

        FlxG.state.add(healthBar);
    }

    public function isOverlaped(bx:Int , by:Int){
        x = bx;
        y = by;
        return Registry.level.overlaps( this );
    }

    override public function hurt(dmg: Float) {
        this.play("hit");
        super.hurt(dmg);
        this.flicker(0.5);
    }

    override public function kill(){
        this.play("kill");

        super.kill();
    }

 	public function launch():Void { 
        exists = true;
        targ = Registry.player;
    }

    public function getPath() {
        if (playerPath != null) {
            this.stopFollowingPath(true);
        }

        var pathStart:FlxPoint = new FlxPoint(this.x + this.width / 2, this.y + this.height / 2);
        var pathEnd:FlxPoint = new FlxPoint(Registry.player.x + (Registry.player.width/2), Registry.player.y + (Registry.player.height/2));
        playerPath = Registry.level.findPath(pathStart, pathEnd);
         
        if (playerPath != null) {
            this.followPath(playerPath);     
        }

        if (this.pathSpeed == 0) {
            this.velocity.x = 0;
            this.velocity.y = 0;
        }              
    }

    override public function update():Void {
        super.update();

        var distX:Float = this.x - targ.x;
        var distY:Float = this.y - targ.y;
        if (distX > distY) {
                if (distX > 0) {
                this.velocity.x = -50;
                this.facing = FlxObject.LEFT;
            } else {
                this.velocity.x = 50;
                this.facing = FlxObject.RIGHT;
            }
        } else {
            if (distY > 0) {
                this.velocity.y = -50;
                this.facing = FlxObject.UP;
            } else {
                this.velocity.y = 50;
                this.facing = FlxObject.DOWN;
            }    
        }

        if (exists && this.health <= 0 ){
            exists = false;
            this.kill();
        }

        if (!this.flickering) {
            if (this.facing == FlxObject.LEFT) { 
                this.play("left"); 
            }

            if (this.facing == FlxObject.RIGHT) {
                this.play("right");
            }

            if (this.facing == FlxObject.UP) {
                this.play("up");
            }

            if (this.facing == FlxObject.DOWN) {
                this.play("down");
            }
        } else {
            this.velocity.x = 0;
            this.velocity.y = 0;
        }
    }

}

