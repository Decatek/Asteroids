package ;

import flash.geom.Point;
import flash.events.Event;
import flash.display.BitmapData;
import openfl.Assets;
import flash.display.Bitmap;
import flash.display.Sprite;

class Entity extends Sprite {

    private var _name:String;

    private var velocity:Point;
    private var acceleration:Point;

    private var hitbox:Hitbox;

    public function new( BitmapName : String) {
        super();

        _name = BitmapName;

        velocity = new Point();
        acceleration = new Point();
        addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(e : Event) {
        removeEventListener(Event.ADDED_TO_STAGE, init);
        loadGraphic();
    }

    private function loadGraphic() {
        var bd:BitmapData = Assets.getBitmapData('assets/' + _name);
        var b:Bitmap = new Bitmap(bd);
    // centers the bitmap to the sprite object
        b.x = -b.width / 2;
        b.y = -b.height / 2;
        hitbox = new Hitbox(new Point(x, y), Math.floor(Math.max(b.width, b.height) / 2.0));
        addChild(b);
    }

    public function update(Delta : Float) {
        hitbox.set_center(x, y);
    }

    private function move(Delta : Float) {
        var delta = Delta;

        velocity.x += acceleration.x * delta;
        velocity.y += acceleration.y * delta;

        x += velocity.x * delta;
        y += velocity.y * delta;

        acceleration.setTo(0, 0);
    }

    public function get_hitbox():Hitbox { return this.hitbox; }
}
