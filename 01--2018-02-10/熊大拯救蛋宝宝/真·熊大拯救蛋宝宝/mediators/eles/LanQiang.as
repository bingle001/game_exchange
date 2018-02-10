package mediators.eles
{
    import defs.*;
    import flash.display.*;
    import flash.events.*;
    import tcUtils.*;
    import wcks.Box2DAS.Dynamics.*;

    public class LanQiang extends Wp
    {
        private var live:int = 3;

        public function LanQiang(param1:MovieClip, param2:Boolean = true)
        {
            super(param1, param2);
            Def.wck.addToWorld(this);
            type = Def.Static;
            this.friction = 0;
            this.autoSleep = false;
            this.reportBeginContact = true;
            return;
        }// end function

        override public function createShapes() : void
        {
            this.box(bodyMc.width, bodyMc.height);
            return;
        }// end function

        override public function addEvent() : void
        {
            this.listenWhileVisible(this, ContactEvent.BEGIN_CONTACT, this.onBegin);
            return;
        }// end function

        override public function removeEvent() : void
        {
            this.removeEventListener(ContactEvent.BEGIN_CONTACT, this.onBegin);
            return;
        }// end function

        private function onBegin(event:ContactEvent) : void
        {
            var mc:MovieClip;
            var onOk:Function;
            var e:* = event;
            if (e.other.GetBody().GetUserData() is Night2)
            {
                if (Math.abs(e.normal.x) > 0.5)
                {
                    var _loc_3:* = this;
                    var _loc_4:* = this.live - 1;
                    _loc_3.live = _loc_4;
                    bodyMc.gotoAndStop((bodyMc.currentFrame + 1));
                    (e.other.GetBody().GetUserData() as Night2).removeEvent();
                    (e.other.GetBody().GetUserData() as Night2).remove();
                    if (this.live == 0)
                    {
                        onOk = function (event:Event) : void
            {
                TcMc.getInstance().removeEventListener(TcMc.PLAYOK, onOk);
                mc.stop();
                remove();
                if (mc.parent)
                {
                    mc.parent.removeChild(mc);
                }
                return;
            }// end function
            ;
                        this.removeEvent();
                        mc = bodyMc;
                        TcMc.getInstance().addEventListener(TcMc.PLAYOK, onOk);
                        TcMc.play(mc);
                    }
                }
            }
            return;
        }// end function

    }
}
