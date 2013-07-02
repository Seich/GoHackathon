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

class GameOver extends FlxState
{

	override public function create():Void
	{
		this.set_bgColor(FlxG.BLUE);
		add(new FlxText(FlxG.width / 2 - 200, FlxG.height / 2, 200, "GAME OVER", 24));
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{
		super.update();

		if (FlxG.keys.SPACE || FlxG.mouse.justPressed()) {
        	FlxG.switchState(new MenuState());
		}
	}	

}