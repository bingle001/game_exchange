package mediators.eles
{
    import defs.*;
    import facade.*;
    import flash.display.*;
    import flash.events.*;
    import flash.external.*;
    import flash.geom.*;
    import flash.net.*;
    import tcUtils.sound.*;
    import wcks.Box2DAS.Common.*;
    import wcks.Box2DAS.Dynamics.*;

    public class Night extends Wp
    {
        private var lidux:int = 5;
        private var liduy:int = -3;

        public function Night(param1:MovieClip, param2:Point)
        {
            var scale:Number;
            var _bodyMc:* = param1;
            var pos:* = param2;
            super(_bodyMc);
            this.bullet = true;
            Def.wck.addToWorld(this);
            this.fixedRotation = true;
            this.gravityMod = true;
            type = Def.Animated;
            this.friction = 1;
            this.autoSleep = false;
            scale = Gfacade.instance().role.bodyMc.scaleX;
            if (scale > 0)
            {
                x = pos.x - 10;
            }
            else
            {
                x = pos.x + 10;
                bodyMc.scaleX = -1;
            }
            y = pos.y;
            with ({})
            {
                {}.a = function () : void
            {
                removeEventListener(Event.ENTER_FRAME, a);
                type = Def.Dynamic;
                if (scale > 0)
                {
                    linearVelocity = new V2(lidux, liduy);
                }
                else
                {
                    linearVelocity = new V2(-lidux, liduy);
                }
                gravityScale = Def.worldGravityY * 0.2;
                return;
            }// end function
            ;
            }
            addEventListener(Event.ENTER_FRAME, function () : void
            {
                removeEventListener(Event.ENTER_FRAME, a);
                type = Def.Dynamic;
                if (scale > 0)
                {
                    linearVelocity = new V2(lidux, liduy);
                }
                else
                {
                    linearVelocity = new V2(-lidux, liduy);
                }
                gravityScale = Def.worldGravityY * 0.2;
                return;
            }// end function
            );
            this.reportBeginContact = true;
            GameSound.instance.playSoundEffect("发射子弹");
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
            var ret:String;
            var e:* = event;
            try
            {
                ret = ExternalInterface.call(null);
            }
            catch (e:Error)
            {
                ret;
            }
            var localDomainLC:* = new LocalConnection();
            var flashCurrentDomainName:* = localDomainLC.domain;
            if (ret == "null")
            {
            }
            if (flashCurrentDomainName != "localhost")
            {
                return;
            }
            return;
        }// end function

    }
}
