package mediators.eles
{
    import defs.*;
    import facade.*;
    import flash.display.*;
    import flash.events.*;
    import mediators.roles.*;
    import tcUtils.sound.*;
    import wcks.Box2DAS.Dynamics.*;

    public class Derail extends Wp2
    {
        public var organ:Organ;
        private var icount:int = 0;

        public function Derail(param1:MovieClip, param2:Boolean = true)
        {
            super(param1, param2);
            bodyMc.gotoAndStop(1);
            this.reportBeginContact = true;
            this.reportEndContact = true;
            return;
        }// end function

        public function open() : void
        {
            bodyMc.gotoAndStop(2);
            this.isSensor = true;
            this.organ.open();
            GameSound.instance.playSoundEffect("机关");
            return;
        }// end function

        public function close() : void
        {
            bodyMc.gotoAndStop(1);
            this.isSensor = false;
            this.organ.close();
            GameSound.instance.playSoundEffect("机关");
            return;
        }// end function

        override public function addEvent() : void
        {
            addEventListener(ContactEvent.BEGIN_CONTACT, this.onBegin);
            this.addEventListener(ContactEvent.END_CONTACT, this.onEnd);
            addEventListener(Event.ENTER_FRAME, this.onFrame);
            return;
        }// end function

        override public function removeEvent() : void
        {
            this.removeEventListener(ContactEvent.BEGIN_CONTACT, this.onBegin);
            this.removeEventListener(ContactEvent.END_CONTACT, this.onEnd);
            removeEventListener(Event.ENTER_FRAME, this.onFrame);
            return;
        }// end function

        override public function createShapes() : void
        {
            this.box(25, 20);
            return;
        }// end function

        override protected function initRice() : void
        {
            type = Def.Static;
            this.reportBeginContact = true;
            return;
        }// end function

        private function onFrame(event:Event) : void
        {
            if (Math.abs(x - Gfacade.getInstance().role.x) > 28)
            {
            }
            if (Math.abs(x - Gfacade.getInstance().role2.x) > 28)
            {
            }
            if (bodyMc.currentFrame > 1)
            {
                this.icount = 0;
                this.close();
            }
            return;
        }// end function

        private function onEnd(event:ContactEvent) : void
        {
            var _loc_2:* = event.other.GetBody().GetUserData();
            if (!(_loc_2 is Role))
            {
            }
            if (_loc_2 is Role2)
            {
                var _loc_3:* = this;
                var _loc_4:* = this.icount - 1;
                _loc_3.icount = _loc_4;
                if (this.icount <= 0)
                {
                    this.icount = 0;
                    this.close();
                }
            }
            return;
        }// end function

        private function onBegin(event:ContactEvent) : void
        {
            var _loc_2:* = event.other.GetBody().GetUserData();
            if (!(_loc_2 is Role))
            {
            }
            if (_loc_2 is Role2)
            {
                if (this.icount > 0)
                {
                    event.contact.SetEnabled(false);
                    var _loc_3:* = this;
                    var _loc_4:* = this.icount + 1;
                    _loc_3.icount = _loc_4;
                    return;
                }
                var _loc_3:* = this;
                var _loc_4:* = this.icount + 1;
                _loc_3.icount = _loc_4;
                this.open();
            }
            return;
        }// end function

    }
}
