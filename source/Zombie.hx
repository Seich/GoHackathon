package ;

import org.flixel.FlxG;
import org.flixel.FlxObject;
import org.flixel.FlxSprite;
import org.flixel.plugin.photonstorm.FlxCollision;
<<<<<<< HEAD
import org.flixel.plugin.photonstorm.FlxMath;

class Zombie extends FlxSprite {
	public var speed:Int;
=======
import org.flixel.FlxPoint;
import org.flixel.FlxPath;
import org.flixel.plugin.photonstorm.FlxBar;
import org.flixel.FlxTimer;


class Zombie extends FlxSprite {
>>>>>>> acb83efd92d1ddec2601e5aa698f10a22a22ef02
    private var targ:FlxSprite;
    private var playerPath:FlxPath;
    private var healthBar: FlxBar;
	public function new() {
        super(0, 0);
        this.loadGraphic("assets/data/zombie1.png", true, false, 60, 60);
        this.addAnimation("down", [0, 3], 6, false);
        this.addAnimation("up", [4, 7], 6, false);
        this.addAnimation("right", [8, 11], 6, false);
        this.addAnimation("left", [12, 15], 6, false);
        this.addAnimation("kill",[16,19], 9, false);
        this.addAnimation("hit", [20,21],4,false);
        this.play("down");

        this.speed = FlxMath.rand(50, 75);
        //this.canMove();
        exists = false;
        this.health = 4;

        healthBar = new FlxBar(16, 64, FlxBar.FILL_LEFT_TO_RIGHT, 64, 6, this, "health", 0, 100);
        healthBar.trackParent(-32, -10);

        FlxG.state.add(healthBar);
    }

    override public function hurt(dmg: Float) {
        this.play("hit");
        var tiempo = new FlxTimer();
        tiempo.start(5000);
        super.hurt(dmg);
    }

    override public function kill(){
        this.play("kill");
        var tiempo = new FlxTimer();
        tiempo.start(6000);
        super.kill();
    }

 	public function launch(bx:Int, by:Int):Void {
        x = bx;
        y = by;   
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
                this.facing = FlxObject.LEFT;
            } else {
                this.facing = FlxObject.RIGHT;
            }
        } else {
            if (distY > 0) {
                this.facing = FlxObject.UP;
            } else {
                this.facing = FlxObject.DOWN;
            }
        }


        if (exists && this.health <= 0 ){
            exists = false;
            //this.kill();
        }

        if (this.facing == FlxObject.UP) { 
            this.play("up");
        } else if (this.facing == FlxObject.DOWN) { 
            this.play("down");
        } else if (this.facing == FlxObject.LEFT) { 
            this.play("left");
        } else if (this.facing == FlxObject.RIGHT) { 
            this.play("right");
        } 
    }

}

