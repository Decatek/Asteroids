package ;

import flash.ui.Keyboard;
import flash.events.KeyboardEvent;
import flash.events.Event;
import flash.display.Bitmap;
import openfl.Assets;
import flash.display.BitmapData;
import flash.display.Sprite;

class Player extends Sprite {

    private var _path:String = 'assets/PNG/playerShip1_blue.png';

    public var throttle:Float = 0.0;
    //positive number is clockwise
    public var steer:Float = 0.0;
    public var fire:Bool = false;

    //Keyboard States
    private var keyLeft:Bool = false;
    private var keyRight:Bool = false;
    private var keyUp:Bool = false;
    private var keyDown:Bool = false;
    private var keySpace:Bool = false;

    public function new() {
        super();

        addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(e:Event) {
        this.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        this.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
        var bd:BitmapData = Assets.getBitmapData(_path);
        var b:Bitmap = new Bitmap(bd);
        // centers the bitmap to the sprite object
        b.x = -b.width / 2;
        b.y = -b.height / 2;
        addChild(b);
    }

    public function updatePosition() {
        if (!(keyLeft && keyRight)) {
            if (keyLeft)
                steer = -1.0;
            if (keyRight)
                steer = 1.0;
        }
        if (keyUp)
            throttle = 1.0;

        fire = keySpace;
    }

    public function move(Elapsed:Float) {


    }

    public function shoot(Elapsed:Float) {

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
}
