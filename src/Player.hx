package ;

import flash.geom.Point;
import flash.ui.Keyboard;
import flash.events.KeyboardEvent;
import flash.events.Event;

class Player extends Entity {

    private var _path:String = 'PNG/playerShip1_blue';

    public var throttle:Float = 0.0;
    //positive number is clockwise
    public var steer:Float = 0.0;
    public var fire:Bool = false;

    public static var STEER_POWER:Int = 100;
    public static var THROTTLE_POWER:Int = 150;

    //Keyboard States
    private var keyLeft:Bool = false;
    private var keyRight:Bool = false;
    private var keyUp:Bool = false;
    private var keyDown:Bool = false;
    private var keySpace:Bool = false;

    public function new() {
        super(_path);
        addEventListener(Event.ADDED_TO_STAGE, init);
    }

    override private function init(e:Event) {
        super.init(e);
        Main.get_instance().stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        Main.get_instance().stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
    }

    private function onKeyDown(e:KeyboardEvent) {
        if (e.keyCode == Keyboard.LEFT)
            keyLeft = true;
        else if(e.keyCode == Keyboard.RIGHT)
            keyRight = true;
        else if(e.keyCode == Keyboard.UP)
            keyUp = true;
        else if(e.keyCode == Keyboard.DOWN)
            keyDown = true;
        else if(e.keyCode == Keyboard.SPACE)
            keySpace = true;
    }

    private function onKeyUp(e:KeyboardEvent) {
        if (e.keyCode == Keyboard.LEFT)
            keyLeft = false;
        else if(e.keyCode == Keyboard.RIGHT)
            keyRight = false;
        else if(e.keyCode == Keyboard.UP)
            keyUp = false;
        else if(e.keyCode == Keyboard.DOWN)
            keyDown = false;
        else if(e.keyCode == Keyboard.SPACE)
            keySpace = false;
    }

    override public function update(Delta:Float) {
        if (fire)
            shoot(Delta);

        super.update(Delta);
    }

    override public function move(Delta:Float) {
        rotation += Delta * STEER_POWER * steer;
        var angle = Math.PI * (rotation / 180);

        //if keyUp t=1.0, else if keyDown t=-0.5, else t=0.0
        throttle = keyUp ? 1.0 : (keyDown ? -0.5 : 0.0);
        steer = keyLeft ? 1.0 : (keyRight ? -1.0 : 0.0);
        fire = keySpace;

        acceleration.x += THROTTLE_POWER * throttle * Math.cos(angle);
        acceleration.y += THROTTLE_POWER * throttle * Math.sin(angle);
        super.move(Delta);
    }


    public function shoot(Delta:Float) {
        //TODO: multi shot?
        Main.get_instance().spawnLaser();
    }

    public function get_position():Point {
        return new Point(x, y);
    }

    public function get_rotation():Float {
        return this.rotation;
    }

}
