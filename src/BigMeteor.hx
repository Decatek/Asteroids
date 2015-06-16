package ;

import flash.geom.Point;
class BigMeteor extends Meteor {

    public function new(Position:Point, Speed:Int, RotationSpeed:Int) {
        super(Position, Speed, RotationSpeed, Meteor.BIG_METEOR);
    }

    override public function destroy() {
        //spawn a small meteor in current x and y
        Main.get_instance().spawnMeteor(new Point(this.x, this.y), Meteor.SMALL_METEOR);
    }
}
