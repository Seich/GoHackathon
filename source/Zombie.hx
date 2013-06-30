package ;

import org.flixel.FlxG;
import org.flixel.FlxObject;
import org.flixel.FlxSprite;
import org.flixel.plugin.photonstorm.FlxCollision;
import org.flixel.FlxPoint;
import org.flixel.FlxPath;

class Zombie extends FlxSprite {
    private var targ:FlxSprite;
    private var playerPath:FlxPath;

	public function new() {
        super(0, 0);
        this.loadGraphic("assets/data/zombie1.png", true, false, 60, 60);
        this.addAnimation("down", [0, 3], 6, false);
        this.addAnimation("up", [4, 7], 6, false);
        this.addAnimation("right", [8, 11], 6, false);
        this.addAnimation("left", [12, 15], 6, false);
        this.play("down");

        exists = false;
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
        var pathEnd:FlxPoint = new FlxPoint(Registry.player.x,Registry.player.y);
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
        
        if (distX > 0) {
            this.facing = FlxObject.LEFT;
        } else {
            this.facing = FlxObject.RIGHT;
        }

        if (distY > 0) {
            this.facing = FlxObject.UP;
        } else {
            this.facing = FlxObject.DOWN;
        }


        if (exists && this.health <= 0 ){
            exists = false;
        }

        if (this.facing == FlxObject.UP) { this.play("up"); }
        else if (this.facing == FlxObject.DOWN)  { this.play("down"); } 
        else if (this.facing == FlxObject.LEFT)  { this.play("left"); } 
        else if (this.facing == FlxObject.RIGHT)  { this.play("right"); } 
    }

}

