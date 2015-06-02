package ;

import flash.geom.Point;
import flash.events.Event;
import flash.display.BitmapData;
import openfl.Assets;
import flash.display.Bitmap;
import flash.display.Sprite;

class Entity extends Sprite {

    private var _name:String;

    private var position:Point;
    private var velocity:Point;
    private var acceleration:Point;

    public function new( BitmapName : String) {
        super();

        _name = BitmapName;

        velocity = new Point();
        acceleration = new Point();
        position = new Point();
        addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(e : Event) {
        loadGraphic();
    }

    private function loadGraphic() {
        var bd:BitmapData = Assets.getBitmapData('assets/' + _name + '.png');
        var b:Bitmap = new Bitmap(bd);
    // centers the bitmap to the sprite object
        b.x = -b.width / 2;
        b.y = -b.height / 2;
        addChild(b);
    }

    public function update(Delta : Float) {
        position.setTo(x, y);
    }

    private function move(Delta : Float) {
        var delta = Delta;

        velocity.x += acceleration.x * delta;
        velocity.y += acceleration.y * delta;

        position.x += velocity.x * delta;
        position.y += velocity.y * delta;

        x = position.x;
        y = position.y;

        acceleration.setTo(0, 0);
    }

}
