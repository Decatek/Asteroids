package ;

import flash.display.Sprite;
import flash.events.Event;
import openfl.Lib.getTimer;

class Main extends Sprite {

    private static var _instance:Main;

    private var lastTime:Int = 0;

    private var player:Player = null;

    public function new() {
        super();

        _instance = this;

        spawnPlayer();
    }

    private function spawnPlayer() {
        player = new Player();
        player.x = 500;
        player.y = 500;
        addChild(player);
        addEventListener(Event.ENTER_FRAME, update);
    }
    private function update(e:Event) {
        var currentTime:Int = getTimer();
        var elapsed:Float = (lastTime - currentTime) / 1000;
        lastTime = currentTime;

        player.updatePosition(elapsed);
        player.move(elapsed);
    }
    public static function get_instance():Main {
        return _instance;
    }
}
