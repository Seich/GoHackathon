package ;

import nme.Lib;
import org.flixel.FlxG;
import org.flixel.FlxObject;
import org.flixel.FlxGroup;
import org.flixel.plugin.photonstorm.FlxMath;


class ZombieManager extends FlxGroup {
	private var lastReleased:Int;
	private var releaseRate:Int;

	public function new(poolSize:Int) {
		super();
		releaseRate = 500;
		var i = 0;
		while(i < poolSize) {
			var enemy = new Zombie();
			add(enemy);
			i++;
		}
	}


	public function release():Void {
		if (getFirstAvailable() != null) {
            var enemy = cast ( getFirstAvailable(), Zombie);
            if (enemy != null) {
            	var arrayX = new Array();
            	var arrayY = new Array();
            	var launchY;
            	var launchX;

            	do {
	            	arrayX[0] = FlxMath.rand(FlxG.camera.scroll.x - 64,FlxG.camera.scroll.x + FlxG.camera.width + 64);
	            	arrayY[0] = FlxG.camera.scroll.y - 64;
	            	arrayX[1] = arrayX[0];
	            	arrayY[1] = FlxG.camera.scroll.y + FlxG.camera.height + 64;
	            	arrayX[2] = Math.floor(FlxG.camera.scroll.x - 64);
	            	arrayY[2] = FlxMath.rand(FlxG.camera.scroll.y - 64, FlxG.camera.scroll.y + FlxG.camera.height + 64);
	            	arrayX[3] = Math.floor(FlxG.camera.scroll.x + FlxG.camera.width + 64);
	            	arrayY[3] = arrayY[2];
	            
	            	var coord = FlxMath.rand(0,3);
	            	launchX = Math.floor(arrayX[coord]);
	            	launchY = Math.floor(arrayY[coord]);
            	} while(false);

				enemy.launch(launchX, launchY);
			}
        }
	}

	override public function update():Void {
		super.update();

		if (Lib.getTimer() > lastReleased + releaseRate) {
			lastReleased = Lib.getTimer();
			release();
		}
	}
	
	public function bulletHitEnemy(bullet:FlxObject, enemy:FlxObject):Void
    {
        bullet.kill();
 
        enemy.hurt(1);
 
        
        FlxG.score += 1;
    }


}