package mediators.eles
{
    import com.greensock.*;
    import defs.*;
    import flash.display.*;
    import flash.utils.*;
    import mediators.roles.*;
    import wcks.Box2DAS.Dynamics.*;

    public class Wudiyaoshui extends Wp2
    {

        public function Wudiyaoshui(param1:MovieClip, param2:Boolean = true)
        {
            super(param1, param2);
            this.reportBeginContact = true;
            type = Def.Static;
            return;
        }// end function

        override public function addEvent() : void
        {
            super.addEvent();
            this.addEventListener(ContactEvent.BEGIN_CONTACT, this.onbegin);
            return;
        }// end function

        override public function removeEvent() : void
        {
            super.removeEvent();
            this.removeEventListener(ContactEvent.BEGIN_CONTACT, this.onbegin);
            return;
        }// end function

        public function onbegin(event:ContactEvent) : void
        {
            var r:People;
            var n:int;
            var e:* = event;
            var t:* = e.other.GetBody().GetUserData();
            if (t is People)
            {
                r = t as People;
                if (r.iswudi)
                {
                    e.contact.SetEnabled(false);
                    return;
                }
                this.removeEvent();
                e.contact.SetEnabled(false);
                this.isSensor = true;
                r.iswudi = true;
                r.changeStatus(Role.STAND);
                TweenMax.to(bodyMc, 1, {scaleX:0.1, scaleY:0.1, onComplete:function () : void
            {
                bodyMc.visible = false;
                return;
            }// end function
            });
                n = setTimeout(function () : void
            {
                clearTimeout(n);
                r.iswudi = false;
                remove();
                return;
            }// end function
            , 6000);
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
