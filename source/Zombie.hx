package ;

import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.plugin.photonstorm.FlxCollision;


class Zombie extends FlxSprite {
	public var speed:Int = 100;
    
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
    }
 
    public function canMove()
    {
        FlxG.log(Registry.level.overlaps(this));
    }
 
    override public function update():Void
    {
        super.update();
 
        if (exists && this.health == 0 ){
            exists = false;
        }
    }
	

}

