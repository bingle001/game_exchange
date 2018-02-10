package mediators.eles
{
    import defs.*;
    import facade.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import mediators.roles.*;
    import tcUtils.*;
    import wcks.Box2DAS.Dynamics.*;
    import wcks.misc.*;

    public class HuoFanWei extends Wp2
    {
        private var count:int;
        private var total:int;

        public function HuoFanWei(param1:MovieClip, param2:Boolean = true)
        {
            super(param1, param2);
            type = Def.Static;
            isSensor = true;
            this.reportBeginContact = true;
            this.total = TcNum.getMinToMax(1, 5);
            return;
        }// end function

        override public function createShapes() : void
        {
            var _loc_1:* = bodyMc.getRect(this);
            box(_loc_1.width * 0.98, _loc_1.height * 0.8);
            return;
        }// end function

        override public function addEvent() : void
        {
            Gfacade.getInstance().mainGame.addEventListener(Event.ENTER_FRAME, this.onFrame);
            this.addEventListener(ContactEvent.BEGIN_CONTACT, this.onBegin);
            return;
        }// end function

        override public function removeEvent() : void
        {
            Gfacade.getInstance().mainGame.removeEventListener(Event.ENTER_FRAME, this.onFrame);
            this.removeEventListener(ContactEvent.BEGIN_CONTACT, this.onBegin);
            return;
        }// end function

        private function onBegin(event:ContactEvent) : void
        {
            if (event.other.GetBody().GetUserData() is Role)
            {
                (event.other.GetBody().GetUserData() as Role).die();
            }
            else if (event.other.GetBody().GetUserData() is Role2)
            {
                (event.other.GetBody().GetUserData() as Role2).die();
            }
            return;
        }// end function

        private function onFrame(event:Event) : void
        {
            var _loc_2:* = this;
            var _loc_3:* = this.count + 1;
            _loc_2.count = _loc_3;
            if (this.count % (24 * this.total) == 0)
            {
                this.di();
                this.count = 0;
            }
            return;
        }// end function

        private function di() : void
        {
            var _loc_1:* = TcNum.getMinToMax(1, 4);
            var _loc_2:* = new Gfacade.getInstance().mainGame.getClass("冰" + _loc_1);
            var _loc_3:* = TcNum.getMinToMax(x - this.bodyMc.width * 0.25, x + this.bodyMc.width * 0.25);
            var _loc_4:* = Util.localizePoint(Def.wck.world, bodyMc);
            new HuoDi(_loc_2, _loc_4, _loc_3);
            return;
        }// end function

    }
}
