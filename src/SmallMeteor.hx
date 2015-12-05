package ;

import openfl.geom.Point;
class SmallMeteor extends Meteor {

    public function new(Position:Point, Speed:Int, RotationSpeed:Int) {
        super(Position, Speed, RotationSpeed, Meteor.SMALL_METEOR);
    }
}
