package mediators.eles
{
    import defs.*;
    import facade.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import tcUtils.sound.*;
    import wcks.Box2DAS.Common.*;
    import wcks.Box2DAS.Dynamics.*;

    public class Night2 extends Wp
    {
        private var lidux:int = 0;
        private var liduy:int = 0;

        public function Night2(param1:MovieClip, param2:Point, param3:Object)
        {
            var scale:Number;
            var _bodyMc:* = param1;
            var pos:* = param2;
            var obj:* = param3;
            super(_bodyMc);
            this.bullet = true;
            Def.wck.addToWorld(this);
            this.fixedRotation = true;
            this.gravityMod = true;
            type = Def.Animated;
            this.friction = 1;
            scale = obj.bodyMc.scaleX;
            if (scale > 0)
            {
                x = pos.x;
            }
            else
            {
                x = pos.x;
                bodyMc.scaleX = -1;
            }
            y = pos.y;
            with ({})
            {
                {}.a = function () : void
            {
                removeEventListener(Event.ENTER_FRAME, a);
                if (scale > 0)
                {
                    linearVelocity = new V2(lidux, liduy);
                }
                else
                {
                    linearVelocity = new V2(-lidux, liduy);
                }
                gravityScale = 0;
                type = Def.Dynamic;
                return;
            }// end function
            ;
            }
            addEventListener(Event.ENTER_FRAME, function () : void
            {
                removeEventListener(Event.ENTER_FRAME, a);
                if (scale > 0)
                {
                    linearVelocity = new V2(lidux, liduy);
                }
                else
                {
                    linearVelocity = new V2(-lidux, liduy);
                }
                gravityScale = 0;
                type = Def.Dynamic;
                return;
            }// end function
            );
            this.reportBeginContact = true;
            GameSound.instance.playSoundEffect("发射子弹");
            with ({})
            {
                {}.a = function () : void
            {
                removeEvent();
                remove();
                return;
            }// end function
            ;
            }
            var nc:* = setTimeout(function () : void
            {
                removeEvent();
                remove();
                return;
            }// end function
            , 135);
            return;
        }// end function

        override public function addEvent() : void
        {
            this.addEventListener(ContactEvent.BEGIN_CONTACT, this.onBegin);
            this.addEventListener(Event.ENTER_FRAME, this.checkRemove);
            return;
        }// end function

        override public function removeEvent() : void
        {
            this.removeEventListener(ContactEvent.BEGIN_CONTACT, this.onBegin);
            this.removeEventListener(Event.ENTER_FRAME, this.checkRemove);
            return;
        }// end function

        override public function createShapes() : void
        {
            this.box(bodyMc.width - 5, bodyMc.height - 3);
            return;
        }// end function

        private function checkRemove(event:Event) : void
        {
            var _loc_2:* = Math.abs(Gfacade.getInstance().role.x - x);
            if (_loc_2 > 400)
            {
                this.removeEvent();
                this.remove();
            }
            return;
        }// end function

        private function onBegin(event:ContactEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (event.other.GetBody().GetUserData() is Monster)
            {
                this.removeEvent();
                _loc_2 = event.other.GetBody().GetUserData() as Monster;
                _loc_2.die();
                this.remove();
            }
            else if (event.other.GetBody().GetUserData() is Monster2)
            {
                this.removeEvent();
                _loc_3 = event.other.GetBody().GetUserData() as Monster2;
                _loc_3.die();
                this.remove();
            }
            else
            {
                event.contact.SetEnabled(false);
            }
            return;
        }// end function

    }
}
