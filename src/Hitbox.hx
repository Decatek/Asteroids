package ;

import flash.geom.Point;

class Hitbox {

    private var center:Point = new Point();
    private var radius:Int = 1;

    public function new(Center:Point, Radius:Int) {
        this.center = Center;
        this.radius = Radius;
    }

    public function overlap(Other:Hitbox):Bool {
        return Point.distance(center, Other.get_center()) <= radius + Other.get_radius();
    }

    //generate an angle
    public function randomPointOnRange():Point {
        var angle = 2.0 * Math.PI * Math.random();
        return new Point(center.x + radius * Math.cos(angle), center.y + radius * Math.sin(angle));
    }

    public function set_center(X:Float, Y:Float) { this.center.setTo(X, Y); }
    public function get_center():Point { return this.center; }
    public function get_radius():Int { return this.radius; }

}
