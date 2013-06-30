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

class MenuState extends FlxState
{
	override public function create():Void
	{
		#if !neko
			FlxG.bgColor = 0x15644405;
		#else
			FlxG.camera.bgColor = {rgb: 0x131c1b, a: 0xff};
		#end		

		#if !FLX_NO_MOUSE
			FlxG.mouse.show();
		#end

		if (FlxG.getPlugin(FlxMouseControl) == null)
		{
			FlxG.addPlugin(new FlxMouseControl());
		}

		FlxG.camera.zoom = 1;

		var background1 = new FlxSprite(0, 0, "assets/data/bg.png");

		var background2 = new FlxSprite(0, 0, "assets/data/fg-1.png");
		var background3 = new FlxSprite(0, 0, "assets/data/fg-2.png");

		var title = new FlxSprite(0, 0, "assets/data/title.png");
		title.scrollFactor = new FlxPoint(0, 0);
		title.x = (FlxG.width - title.width) / 2;
		title.y += 100;

		var glitch = new FlxSprite(0, 0, "assets/data/glitch.png");
		glitch.scrollFactor = new FlxPoint(0, 0);

		var menu = new FlxSprite(0, 0, "assets/data/bg2.png");
		menu.scrollFactor = new FlxPoint(0, 0);
		menu.x = FlxG.width - menu.width;
		menu.y = FlxG.height - menu.height;

		add(background1);
		//add(foreground1);
		//add(foreground2);
		add(title);
		add(glitch);
		add(menu);

	}
	
	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{
		super.update();
	}	

	private function onStartClick( ):Void
    {
        
        FlxG.switchState(new PlayState());
    }
}