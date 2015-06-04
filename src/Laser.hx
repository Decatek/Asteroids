package ;

import flash.geom.Point;
class Laser extends Entity {

    private var _path:String = "PNG/Lasers/laserBlue03";

    private static var LASER_SPEED:Int = -500;

    public function new(Position:Point, Rotation:Float) {
        super(_path);

        x = Position.x;
        y = Position.y;

        rotation = Rotation;

        var angle : Float = Math.PI * (rotation / 180);
        velocity = new Point( LASER_SPEED * Math.cos(angle), LASER_SPEED * Math.sin(angle) );
    }

    override public function update(Delta:Float) {
        super.update(Delta);
    }

    override public function move(Delta:Float) {
        super.move(Delta);
    }
}
