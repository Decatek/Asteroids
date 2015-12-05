package ;

import openfl.geom.Point;
import flash.Lib;
import flash.display.Sprite;
import flash.events.Event;

class Main extends Sprite {

    public static inline var METEOR_CHANCE:Float = 0.010;

    private static var _instance:Main;

    private var lastTime:Int = 0;

    private var player:Player = null;

    private var lasers:Array<Laser> = new Array<Laser>();
    private var meteors:Array<Meteor> = new Array<Meteor>();

    private var meteorRange:Hitbox;

    public function new() {
        super();

        _instance = this;
        meteorRange = new Hitbox(new Point(stage.stageWidth / 2, stage.stageHeight / 2), Math.floor(stage.stageWidth));
        spawnPlayer();
    }

    private function spawnPlayer() {
        player = new Player();
        player.x = 500;
        player.y = 500;
        addChild(player);
        addEventListener(Event.ENTER_FRAME, update);
    }

    public function spawnLaser(Position:Point, Rotation:Float) {
        var laser = new Laser(Position, Rotation);
        lasers.push(laser);
        addChild(laser);
    }

    public function spawnMeteor(Position:Point, Type:String) {
        switch(Type) {
            case Meteor.BIG_METEOR: {
                var m = new BigMeteor(Position, Std.random(30) + 100, Std.random(5));
                meteors.push(m);
                addChild(m);
            }
            case Meteor.SMALL_METEOR: {
                var m = new SmallMeteor(Position, Std.random(30) + 200, Std.random(50));
                meteors.push(m);
                addChild(m);
            }
        }
    }

    public function removeLaser(Laser:Laser) {
        removeChild(Laser);
        lasers.remove(Laser);
    }

    private function update(e:Event) {
        var currentTime:Int = Lib.getTimer();
        var delta:Float = (lastTime - currentTime) / 1000;
        lastTime = currentTime;

        player.update(delta);
        player.move(delta);

        for ( meteor in meteors) {
            meteor.update(delta);
            meteor.move(delta);
        }

        for ( laser in lasers ){
            laser.update(delta);
            laser.move(delta);
        }

        if (Math.random() <= METEOR_CHANCE) {
            var position = meteorRange.randomPointOnRange();
            spawnMeteor(position, Meteor.BIG_METEOR);

        }

        for (m in meteors) {
            for (l in lasers) {
                if (m.get_hitbox().overlap(l.get_hitbox())){

                    m.destroy();

                    removeChild(m);
                    meteors.remove(m);

                    removeChild(l);
                    lasers.remove(l);
                }
            }

        }

        for (m in meteors) {
            if (m.get_hitbox().overlap(player.get_hitbox())) {
                removeChild(m);
                meteors.remove(m);

                player.takeDamage(m);

                if (player.get_hp() == 0)
                    removeChild(player);
            }
        }
    }
    public static function get_instance():Main {
        return _instance;
    }
}
