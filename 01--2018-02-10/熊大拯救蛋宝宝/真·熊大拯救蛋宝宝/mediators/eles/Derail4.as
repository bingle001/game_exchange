package mediators.eles
{
    import defs.*;
    import flash.display.*;
    import mediators.roles.*;
    import tcUtils.*;
    import tcUtils.sound.*;
    import wcks.Box2DAS.Common.*;
    import wcks.Box2DAS.Dynamics.*;

    public class Derail4 extends Wp2
    {
        public var jg:JumpBoard2;
        private var isOpen:Boolean = false;

        public function Derail4(param1:MovieClip, param2:Boolean = true)
        {
            super(param1, param2);
            bodyMc.gotoAndStop(1);
            type = Def.Static;
            this.reportBeginContact = true;
            return;
        }// end function

        override public function createShapes() : void
        {
            this.box(bodyMc.width, bodyMc.height, new V2(0, 0));
            return;
        }// end function

        override public function addEvent() : void
        {
            this.addEventListener(ContactEvent.BEGIN_CONTACT, this.onBegin);
            return;
        }// end function

        override public function removeEvent() : void
        {
            this.removeEventListener(ContactEvent.BEGIN_CONTACT, this.onBegin);
            return;
        }// end function

        public function open() : void
        {
            TcMc.play(bodyMc);
            this.jg.startRun();
            GameSound.instance.playSoundEffect("机关");
            return;
        }// end function

        public function close() : void
        {
            TcMc.playBack(bodyMc);
            this.jg.startRun();
            GameSound.instance.playSoundEffect("机关");
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
                event.contact.SetEnabled(false);
                if (this.isOpen)
                {
                    this.close();
                    this.isOpen = false;
                }
                else
                {
                    this.open();
                    this.isOpen = true;
                }
            }
            return;
        }// end function

    }
}
