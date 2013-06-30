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
	var title:FlxSprite;
	var glitch:FlxSprite;


	override public function create():Void
	{
		#if !neko
			FlxG.bgColor = 0x15644405;
		#else
			FlxG.camera.bgColor = {rgb: 0x15644405, a: 0xff};
		#end		

		FlxG.mouse.hide();

		if (FlxG.getPlugin(FlxMouseControl) == null)
		{
			FlxG.addPlugin(new FlxMouseControl());
		}

		var grassTop = new FlxSprite(0, 0, "assets/data/hojas.png");
		grassTop.scale = new FlxPoint(1.3, 1.3);

		var grassBot = new FlxSprite(0, 0, "assets/data/hojasb.png");
		grassBot.scale = new FlxPoint(1.3, 1.3);
		grassBot.y = FlxG.height - grassBot.height;

		title = new FlxSprite(0, 0, "assets/data/title.png");
		title.scale = new FlxPoint(0.9, 0.9);
		title.x = 100;
		title.y = -100;

		var board = new FlxSprite(0, 0, "assets/data/tablita.png");
		board.x = FlxG.width - board.width;
		board.y = FlxG.height - board.height;

		glitch = new FlxSprite(0, 0, "assets/data/glitch.png");
		glitch.x = -100;
		glitch.y = FlxG.height - glitch.height;


		add(grassTop);
		add(grassBot);
		add(glitch);
		add(board);
		add(title);
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{
		if (title.y < 50) {
			title.y += 10;
		}

		if (glitch.x < 0) {
			glitch.x += 10;
		}

		if (FlxG.keys.SPACE || FlxG.mouse.justPressed()) {
        	FlxG.switchState(new MovieState(1));
		}

		super.update();
	}	

	private function onStartClick( ):Void
    {
    	FlxG.switchState(new MovieState(1));
        //FlxG.switchState(new PlayState());
    }
}