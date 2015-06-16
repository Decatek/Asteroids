package ;
import openfl.geom.Point;
class Meteor extends Entity {

    public static inline var BIG_METEOR:String = 'PNG/Meteors/meteorBrown_big1.png';
    public static inline var SMALL_METEOR:String = 'PNG/Meteors/meteorBrown_small1.png';

    private var speed:Int = 0;
    private var rotationSpeed:Int = 0;
    private var direction:Point;

    public function new(Position:Point, Speed:Int, RotationSpeed:Int, Type:String) {
        super(Type);

        x = Position.x;
        y = Position.y;

        speed = - Speed;

        rotationSpeed = RotationSpeed;

        direction = new Point(Main.get_instance().stage.stageWidth / 2 - x, Main.get_instance().stage.stageHeight / 2 - y);
        direction.normalize(1);

        velocity.setTo(speed * direction.x, speed * direction.y);
    }

    override public function update(Delta:Float) {
        rotation += Delta * rotationSpeed;

        super.update(Delta);
    }

    override public function move(Delta:Float) {
        super.move(Delta);
    }

    public function destroy() {

    }
}
