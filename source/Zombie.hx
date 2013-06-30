package ;

import org.flixel.FlxG;
import org.flixel.FlxObject;
import org.flixel.FlxSprite;
import org.flixel.plugin.photonstorm.FlxCollision;
import org.flixel.plugin.photonstorm.FlxMath;

class Zombie extends FlxSprite {
	public var speed:Int;
    private var targ:FlxSprite;

	public function new()
    {
        super(0, 0);
        this.loadGraphic("assets/data/zombie1.png", true, false, 60, 60);
        this.addAnimation("down", [0, 3], 6, false);
        this.addAnimation("up", [4, 7], 6, false);
        this.addAnimation("right", [8, 11], 6, false);
        this.addAnimation("left", [12, 15], 6, false);
        this.play("down");

        this.speed = FlxMath.rand(50, 75);

        //this.canMove();
        exists = false;
    }

 	public function launch(bx:Int, by:Int):Void
    {
        x = bx;
        y = by;   
        exists = true;
        targ = Registry.player;
    }
 
    public function canMove()
    {
        FlxG.log(Registry.level.overlaps(this));
    }
 
    override public function update():Void
    {
        super.update();

        var distX:Float = this.x - targ.x;
        var distY:Float = this.y - targ.y;
        

        if (distY > 0) {
            this.velocity.y = -speed;
            this.facing = FlxObject.UP;
        } else {
            this.velocity.y = speed;
            this.facing = FlxObject.DOWN;
        }

        if (distX > 0) {
            this.velocity.x = -speed;
            this.facing = FlxObject.LEFT;
        } else {
            this.velocity.x = speed;
            this.facing = FlxObject.RIGHT;
        }

        if (exists && this.health == 0 ){
            exists = false;
        }

        if (this.facing == FlxObject.UP) { this.play("up"); }
        else if (this.facing == FlxObject.DOWN)  { this.play("down"); } 
        else if (this.facing == FlxObject.LEFT)  { this.play("left"); } 
        else if (this.facing == FlxObject.RIGHT)  { this.play("right"); } 
    }

}

