package mediators.eles
{
    import defs.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import mediators.roles.*;
    import wcks.Box2DAS.Common.*;
    import wcks.Box2DAS.Dynamics.*;

    public class Yicidibiao extends Wp
    {
        private var standTime:int = 1000;
        private var timer:Timer;
        private var i:int = 0;
        private var j:int = 0;

        public function Yicidibiao(param1:MovieClip, param2:Boolean = true)
        {
            this.timer = new Timer(this.standTime);
            super(param1, param2);
            type = Def.Static;
            this.reportBeginContact = true;
            this.friction = 0;
            bodyMc.gotoAndStop(1);
            Def.wck.addToWorld(this);
            return;
        }// end function

        override public function createShapes() : void
        {
            super.createShapes();
            this.box(this.bodyMc.width * 0.85, bodyMc.height * 0.6, new V2(0, 0));
            return;
        }// end function

        override public function addEvent() : void
        {
            super.addEvent();
            this.addEventListener(ContactEvent.BEGIN_CONTACT, this.onBegin);
            this.timer.addEventListener(TimerEvent.TIMER, this.onTimer);
            return;
        }// end function

        override public function removeEvent() : void
        {
            super.removeEvent();
            this.removeEventListener(ContactEvent.BEGIN_CONTACT, this.onBegin);
            this.timer.removeEventListener(TimerEvent.TIMER, this.onTimer);
            return;
        }// end function

        private function onTimer(event:TimerEvent) : void
        {
            if (this.i == 0)
            {
                this.timer.stop();
                this.isSensor = true;
                bodyMc.gotoAndPlay(2);
            }
            return;
        }// end function

        private function onBegin(event:ContactEvent) : void
        {
            if (!(event.other.GetUserData() is Role))
            {
            }
            if (event.other.GetUserData() is Role2)
            {
            }
            if (event.normal)
            {
            }
            if (event.normal.y <= -0.9)
            {
            }
            if (this.j == 0)
            {
                this.timer.start();
            }
            return;
        }// end function

    }
}
