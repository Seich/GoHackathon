package ;

import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.plugin.photonstorm.FlxCollision;
import org.flixel.FlxObject;

class Zombie extends FlxSprite {
	public var speed:Int = 100;
    private var targ:FlxSprite;

	public function new()
    {
        super(0, 0);
        this.loadGraphic("assets/data/zombie1.png", true, false, 60, 60);
        exists = false;
        this.canMove();
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
        
        if (distX > 0) {
            this.velocity.x = -50;
            this.facing = FlxObject.LEFT;
        } else {
            this.velocity.x = 50;
            this.facing = FlxObject.RIGHT;
        }
        if (distY > 0) {
            this.velocity.y = -50;
            this.facing = FlxObject.UP;
        } else {
            this.velocity.y = 50;
            this.facing = FlxObject.DOWN;
        }


        if (exists && this.health == 0 ){
            exists = false;
        }
    }
	

}

