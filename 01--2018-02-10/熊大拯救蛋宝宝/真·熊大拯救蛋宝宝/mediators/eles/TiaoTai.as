package mediators.eles
{
    import defs.*;
    import flash.display.*;
    import flash.events.*;
    import mediators.roles.*;
    import tcUtils.*;
    import wcks.Box2DAS.Dynamics.*;

    public class TiaoTai extends Wp
    {

        public function TiaoTai(param1:MovieClip, param2:Boolean = true)
        {
            super(param1, param2);
            type = Def.Static;
            this.reportBeginContact = true;
            Def.wck.addToWorld(this);
            bodyMc.gotoAndStop(1);
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

        private function onBegin(event:ContactEvent) : void
        {
            var r:Role;
            var onOk:Function;
            var r2:Role2;
            var onOk2:Function;
            var e:* = event;
            if (e.other.GetBody().GetUserData() is Role)
            {
                onOk = function (event:Event) : void
            {
                TcMc.getInstance().removeEventListener(TcMc.PLAYOK, onOk);
                bodyMc.gotoAndStop(1);
                return;
            }// end function
            ;
                TcMc.getInstance().addEventListener(TcMc.PLAYOK, onOk);
                TcMc.play(bodyMc);
                r = e.other.GetBody().GetUserData() as Role;
                r.jumpHighter();
            }
            else if (e.other.GetBody().GetUserData() is Role2)
            {
                onOk2 = function (event:Event) : void
            {
                TcMc.getInstance().removeEventListener(TcMc.PLAYOK, onOk2);
                bodyMc.gotoAndStop(1);
                return;
            }// end function
            ;
                TcMc.getInstance().addEventListener(TcMc.PLAYOK, onOk2);
                TcMc.play(bodyMc);
                r2 = e.other.GetBody().GetUserData() as Role2;
                r2.jumpHighter();
            }
            else
            {
                e.contact.SetEnabled(false);
            }
            return;
        }// end function

        override public function createShapes() : void
        {
            this.box(bodyMc.width * 0.8, bodyMc.height * 0.8);
            return;
        }// end function

    }
}
