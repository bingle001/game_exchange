package mediators.eles
{
    import defs.*;
    import flash.display.*;
    import flash.events.*;
    import mediators.roles.*;
    import tcUtils.sound.*;
    import wcks.Box2DAS.Dynamics.*;

    public class Derail5 extends Wp2
    {
        public var jb3:JumpBoard3;
        private var icount:int = 0;

        public function Derail5(param1:MovieClip, param2:Boolean = true)
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
            this.jb3.onPlayJump(null);
            GameSound.instance.playSoundEffect("机关");
            return;
        }// end function

        public function close() : void
        {
            return;
        }// end function

        override public function addEvent() : void
        {
            addEventListener(ContactEvent.BEGIN_CONTACT, this.onBegin);
            return;
        }// end function

        override public function removeEvent() : void
        {
            this.removeEventListener(ContactEvent.BEGIN_CONTACT, this.onBegin);
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
                this.close();
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
                this.open();
                this.removeEvent();
            }
            return;
        }// end function

    }
}
