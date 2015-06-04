package ;

import flash.Lib;
import flash.display.Sprite;
import flash.events.Event;

class Main extends Sprite {

    private static var _instance:Main;

    private var lastTime:Int = 0;

    private var player:Player = null;

    private var lasers:Array<Laser> = new Array<Laser>();

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

    public function spawnLaser() {
        var laser_center = new Laser(player.get_position(), player.get_rotation());
        lasers.push(laser_center);
        addChild(laser_center);
    }

    public function removeLaser(Laser:Laser) {

    }
    private function update(e:Event) {
        var currentTime:Int = Lib.getTimer();
        var delta:Float = (lastTime - currentTime) / 1000;
        lastTime = currentTime;

        player.update(delta);
        player.move(delta);

        for ( laser in lasers ){
            laser.update(delta);
            laser.move(delta);
        }

    }
    public static function get_instance():Main {
        return _instance;
    }
}
