package mediators.eles
{
    import facade.*;
    import flash.display.*;
    import flash.geom.*;

    public class PaoTong2 extends Paotong
    {

        public function PaoTong2(param1:MovieClip, param2:Boolean = true)
        {
            super(param1, param2);
            return;
        }// end function

        override public function shoot() : void
        {
            curCount = 0;
            var _loc_1:* = new Gfacade.getInstance().mainGame.getClass("箭右");
            new Bullet3(_loc_1, new Point(x, y), speed);
            return;
        }// end function

    }
}
