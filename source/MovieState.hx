package;

import nme.Assets;
import nme.geom.Rectangle;
import nme.Lib;
import nme.net.SharedObject;
import org.flixel.plugin.photonstorm.FlxDisplay;
import org.flixel.FlxButton;
import org.flixel.FlxG;
import org.flixel.FlxPath;
import org.flixel.FlxSave;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.FlxU;
import org.flixel.plugin.photonstorm.FlxGridOverlay;
import org.flixel.plugin.photonstorm.FlxButtonPlus;
import org.flixel.plugin.photonstorm.FlxExtendedSprite;
import org.flixel.plugin.photonstorm.FlxMouseControl;
import org.flixel.FlxPoint;

class MovieState extends FlxState {
	var i:Int;
	override public function new(id:Int):Void {
		i = id;
		super();
	}

	override public function create():Void
	{
		
		#if !neko
			FlxG.bgColor = 0x15644405;
		#else
			FlxG.camera.bgColor = {rgb: 0x15644405, a: 0xff};
		#end		

		#if !FLX_NO_MOUSE
			FlxG.mouse.show();
		#end

		if (FlxG.getPlugin(FlxMouseControl) == null)
		{
			FlxG.addPlugin(new FlxMouseControl());
		}

		var movieTake = new FlxSprite();
		movieTake.loadGraphic("assets/data/toma"+i+".png",true, false, 600, 464 );
		movieTake.addAnimation("default",[0,3],6,true);
		movieTake.play("default");
		add(movieTake);
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{
		
		
		if (FlxG.keys.SPACE || FlxG.mouse.justPressed()) {
        	if (i == 9) {
        		FlxG.switchState(new PlayState());
    		} else {
    			FlxG.switchState(new MovieState(i+1));	
    		}
		}

		super.update();
	}	

	private function onStartClick( ):Void
    {
    	
    }
}