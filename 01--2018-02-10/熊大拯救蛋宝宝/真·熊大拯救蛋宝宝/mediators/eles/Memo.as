package mediators.eles
{
    import defs.*;
    import facade.*;
    import flash.display.*;
    import flash.events.*;
    import mediators.roles.*;
    import wcks.Box2DAS.Common.*;
    import wcks.Box2DAS.Dynamics.*;

    public class Memo extends Wp
    {
        private var memo:Memo;
        private var count:int = 0;

        public function Memo(param1:MovieClip, param2:Boolean = true)
        {
            super(param1, param2);
            Def.wck.addToWorld(this);
            type = Def.Static;
            this.isSensor = true;
            this.reportBeginContact = true;
            this.reportEndContact = true;
            return;
        }// end function

        public function open() : void
        {
            bodyMc.gotoAndStop(2);
            return;
        }// end function

        override public function addEvent() : void
        {
            this.addEventListener(ContactEvent.BEGIN_CONTACT, this.onContact);
            this.addEventListener(ContactEvent.END_CONTACT, this.onEnd);
            return;
        }// end function

        override public function removeEvent() : void
        {
            this.removeEventListener(ContactEvent.BEGIN_CONTACT, this.onContact);
            this.removeEventListener(ContactEvent.END_CONTACT, this.onEnd);
            return;
        }// end function

        override public function createShapes() : void
        {
            this.box(50, 50, new V2(0, -23));
            return;
        }// end function

        private function onContact(event:ContactEvent) : void
        {
            if (!(event.other.GetBody().GetUserData() is Role))
            {
            }
            if (event.other.GetUserData() is Role2)
            {
                var _loc_2:* = this;
                var _loc_3:* = this.count + 1;
                _loc_2.count = _loc_3;
                if (this.count >= 2)
                {
                }
                if (Def.totalScore == Def.curScore)
                {
                }
                if (Math.abs(x - Gfacade.getInstance().role.x) < 100)
                {
                }
                if (Math.abs(x - Gfacade.getInstance().role2.x) < 100)
                {
                }
                if (Math.abs(y - Gfacade.getInstance().role.y) < 100)
                {
                }
                if (Math.abs(y - Gfacade.getInstance().role2.y) < 100)
                {
                    this.removeEvent();
                    Def.wck.world.paused = true;
                    Gfacade.getInstance().role.removeEvent();
                    Gfacade.getInstance().role2.removeEvent();
                    EventManager.getInstance().eDispatchEvent(new Event(Def.WIN));
                }
            }
            return;
        }// end function

        private function onEnd(event:ContactEvent) : void
        {
            if (!(event.other.GetBody().GetUserData() is Role))
            {
            }
            if (event.other.GetUserData() is Role2)
            {
                var _loc_2:* = this;
                var _loc_3:* = this.count - 1;
                _loc_2.count = _loc_3;
            }
            return;
        }// end function

    }
}
