package ;

import flash.geom.Point;
import flash.ui.Keyboard;
import flash.events.KeyboardEvent;
import flash.events.Event;
import flash.display.Sprite;

class Player extends Sprite {

    private var _path:String = 'assets/PNG/playerShip1_blue.png';

    public var throttle:Float = 0.0;
    //positive number is clockwise
    public var steer:Float = 0.0;
    public var fire:Bool = false;



    private var position:Point;
    private var velocity:Point;
    private var acceleration:Point;

    public function new() {
        super();

        velocity = new Point();
        acceleration = new Point();

    }

    private function init(e:Event) {

        position = new Point(x, y);
    }

    public function updatePosition(Elapsed:Float) {

        position.setTo(x, y);


    }

    public function move(Elapsed:Float) {
        velocity.x += acceleration.x * Elapsed;
        velocity.y += acceleration.y * Elapsed;

        position.x += velocity.x * Elapsed;
        position.y += velocity.y * Elapsed;

        x = position.x;
        y = position.y;

        acceleration.setTo(0, 0);
    }

    public function shoot(Elapsed:Float) {

    }


}
