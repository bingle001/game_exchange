package mediators.eles
{
    import defs.*;
    import flash.display.*;

    public class MoveItem extends Goods
    {
        public var runSpeed:Number = 1;
        public var range:uint = 50;
        public var runDir:uint = 0;

        public function MoveItem(param1:MovieClip, param2:Boolean = true)
        {
            super(param1, param2);
            this.type = Def.Animated;
            this.restitution = 0;
            this.runSpeed = bodyMc.移动速度 == null ? (Def.jumpBoard_speed) : (bodyMc.移动速度);
            this.range = bodyMc.移动幅度 == null ? (Def.jumpBoard_right_left_range) : (bodyMc.移动幅度);
            return;
        }// end function

    }
}
