package ;

import flash.events.Event;
import openfl.events.KeyboardEvent;
import flash.display.BitmapData;
import openfl.Assets;
import flash.display.Bitmap;
import flash.display.Sprite;

class Entity extends Sprite {

    private var _name:String;

    //Keyboard States
    private var keyLeft:Bool = false;
    private var keyRight:Bool = false;
    private var keyUp:Bool = false;
    private var keyDown:Bool = false;
    private var keySpace:Bool = false;

    public function new( BitmapName : String) {
        super();

        _name = BitmapName;

        addEventListener(Event.ADDED_TO_STAGE, init);

        Main.get_instance().stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        Main.get_instance().stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);

    }

    private function init() {
    loadGraphic();

    }

    private function loadGraphic() {
        var bd:BitmapData = Assets.getBitmapData(_name);
        var b:Bitmap = new Bitmap(bd);
    // centers the bitmap to the sprite object
        b.x = -b.width / 2;
        b.y = -b.height / 2;
        addChild(b);
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
