package ;

import flash.geom.Point;
class Laser extends Entity {

    private var _path:String = "PNG/Lasers/laserBlue03.png";

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
        checkOnScreen();
    }

    override public function move(Delta:Float) {
        super.move(Delta);
    }

    private function checkOnScreen() {
        if (x >= Main.get_instance().stage.stageWidth || x <= 0)
            Main.get_instance().removeLaser(this);
        if (y >= Main.get_instance().stage.stageHeight || y <= 0)
            Main.get_instance().removeLaser(this);
    }
}
