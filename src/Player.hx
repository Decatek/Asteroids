package ;

import flash.geom.Point;
import flash.ui.Keyboard;
import flash.events.KeyboardEvent;
import flash.events.Event;

class Player extends Entity {

    private var _path:String = 'PNG/playerShip1_blue.png';

    public var throttle:Float = 0.0;
    //positive number is clockwise
    public var steer:Float = 0.0;
    public var fire:Bool = false;

    private var hp:Int = 100;

    public static var STEER_POWER:Int = 100;
    public static var THROTTLE_POWER:Int = 150;

    //Keyboard States
    private var keyLeft:Bool = false;
    private var keyRight:Bool = false;
    private var keyUp:Bool = false;
    private var keyDown:Bool = false;
    private var keySpace:Bool = false;
    private var previousKeySpace:Bool = false;

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
        switch (e.keyCode) {
            case Keyboard.LEFT:
                keyLeft = true;
            case Keyboard.RIGHT:
                keyRight = true;
            case Keyboard.UP:
                keyUp = true;
            case Keyboard.DOWN:
                keyDown = true;
            case Keyboard.SPACE:
                keySpace = true;
        }
    }

    private function onKeyUp(e:KeyboardEvent) {
        switch (e.keyCode) {
            case Keyboard.LEFT:
                keyLeft = false;
            case Keyboard.RIGHT:
                keyRight = false;
            case Keyboard.UP:
                keyUp = false;
            case Keyboard.DOWN:
                keyDown = false;
            case Keyboard.SPACE:
                keySpace = false;
        }
    }

    override public function update(Delta:Float) {
        fire = keySpace && !previousKeySpace;

        if (fire)
            shoot(Delta);

        previousKeySpace = keySpace;
        super.update(Delta);
    }

    override public function move(Delta:Float) {
        rotation += Delta * STEER_POWER * steer;
        var angle = Math.PI * (rotation / 180);

        //if keyUp t=1.0, else if keyDown t=-0.5, else t=0.0
        throttle = keyUp ? 1.0 : (keyDown ? -0.5 : 0.0);
        steer = keyLeft ? 1.0 : (keyRight ? -1.0 : 0.0);

        acceleration.x += THROTTLE_POWER * throttle * Math.cos(angle);
        acceleration.y += THROTTLE_POWER * throttle * Math.sin(angle);
        super.move(Delta);
    }

    public function wrap() {

        if (x > stage.stageWidth)
            x -= stage.stageWidth;
        if (x < 0)
            x += stage.stageWidth;
        if (y > stage.stageHeight)
            y -= stage.stageHeight;
        if (y < stage.stageHeight)
            y += stage.stageHeight;
    }

    public function takeDamage(Meteor:Meteor) {
        hp--;
    }

    public function shoot(Delta:Float) {
        //TODO: multi shot?
        var angle:Float = Math.PI * (rotation / 180);

        var turret1Position = new Point();
        turret1Position.x = this.x + Math.sin(angle) * 40;
        turret1Position.y = this.y - Math.cos(angle) * 40;

        var turret2Position = new Point();
        turret2Position.x = this.x - Math.sin(angle) * 40;
        turret2Position.y = this.y + Math.cos(angle) * 40;

        Main.get_instance().spawnLaser(turret1Position, rotation);
        Main.get_instance().spawnLaser(turret2Position, rotation);
    }

    public function get_position():Point {
        return new Point(x, y);
    }

    public function get_hp():Int { return this.hp; }

}
