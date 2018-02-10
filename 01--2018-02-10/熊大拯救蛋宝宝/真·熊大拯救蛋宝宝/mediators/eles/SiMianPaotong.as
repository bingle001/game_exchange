package mediators.eles
{
    import facade.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class SiMianPaotong extends Paotong3
    {
        private var interval2:int;

        public function SiMianPaotong(param1:MovieClip, param2:Boolean = true)
        {
            super(param1, param2);
            var _loc_3:* = bodyMc.name;
            var _loc_4:* = _loc_3.split("_");
            this.interval2 = parseInt(_loc_4[1]);
            return;
        }// end function

        override public function addEvent() : void
        {
            super.addEvent();
            return;
        }// end function

        override public function removeEvent() : void
        {
            super.removeEvent();
            return;
        }// end function

        override public function onFrame(event:Event) : void
        {
            var _loc_3:* = curCount + 1;
            curCount = _loc_3;
            if (curCount >= 24 * this.interval2)
            {
                this.shoot();
            }
            bodyMc.rotation = bodyMc.rotation + 2;
            if (bodyMc.rotation > 360)
            {
                bodyMc.rotation = 0;
            }
            return;
        }// end function

        override public function shoot() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            curCount = 0;
            var _loc_1:* = 1;
            while (_loc_1 < 5)
            {
                
                _loc_2 = bodyMc.getChildByName("r" + _loc_1) as MovieClip;
                if (_loc_2 == null)
                {
                }
                else
                {
                    _loc_3 = new Gfacade.getInstance().mainGame.getClass("球");
                    new Bullet4(_loc_3, new Point(x, y), _loc_2);
                }
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

    }
}
