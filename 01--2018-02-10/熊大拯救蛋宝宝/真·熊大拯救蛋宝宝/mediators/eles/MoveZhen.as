package mediators.eles
{
    import defs.*;
    import facade.*;
    import flash.display.*;
    import flash.events.*;
    import mediators.roles.*;
    import wcks.Box2DAS.Common.*;
    import wcks.Box2DAS.Dynamics.*;

    public class MoveZhen extends Wp
    {
        private var flag:int = 0;
        public var ar:Array;
        private var isRun:Boolean;
        private var count:int = 0;

        public function MoveZhen(param1:MovieClip, param2:Boolean = true)
        {
            this.ar = [];
            super(param1, param2);
            type = Def.Animated;
            bodyMc.stop();
            Def.wck.addToWorld(this);
            isSensor = true;
            this.reportBeginContact = true;
            this.reportEndContact = true;
            return;
        }// end function

        override public function createShapes() : void
        {
            box(bodyMc.width * 0.5, bodyMc.height * 0.7, new V2(0, 0));
            return;
        }// end function

        override protected function init() : void
        {
            super.init();
            return;
        }// end function

        override public function addEvent() : void
        {
            super.addEvent();
            Gfacade.getInstance().mainGame.container.addEventListener(Event.ENTER_FRAME, this.onFrame);
            this.listenWhileVisible(this, ContactEvent.BEGIN_CONTACT, this.onBegin);
            this.listenWhileVisible(this, ContactEvent.END_CONTACT, this.onEnd);
            return;
        }// end function

        override public function removeEvent() : void
        {
            super.removeEvent();
            Gfacade.getInstance().mainGame.container.removeEventListener(Event.ENTER_FRAME, this.onFrame);
            this.removeEventListener(ContactEvent.BEGIN_CONTACT, this.onBegin);
            this.removeEventListener(ContactEvent.END_CONTACT, this.onEnd);
            return;
        }// end function

        private function onBegin(event:ContactEvent) : void
        {
            if (event.other.GetBody().GetUserData().name == "role")
            {
                if (bodyMc.currentFrame >= 9)
                {
                }
            }
            if (bodyMc.currentFrame > 10)
            {
                if (event.other.GetBody().GetUserData() is Role)
                {
                    if (Gfacade.instance().role.iswudi == false)
                    {
                        Gfacade.instance().role.die();
                    }
                }
                else if (event.other.GetBody().GetUserData() is Role2)
                {
                    if (Gfacade.instance().role2.iswudi == false)
                    {
                        Gfacade.instance().role2.die();
                    }
                }
                else if (Gfacade.instance().role3.iswudi == false)
                {
                    Gfacade.getInstance().role3.die();
                }
            }
            else if (event.other.GetBody().GetUserData().name == "role")
            {
                this.ar.push(event.other.GetBody().GetUserData());
            }
            return;
        }// end function

        private function onEnd(event:ContactEvent) : void
        {
            var _loc_2:* = 0;
            if (event.other.GetBody().GetUserData().name == "role")
            {
                _loc_2 = 0;
                while (_loc_2 < this.ar.length)
                {
                    
                    if (this.ar[_loc_2] == event.other.GetBody().GetUserData())
                    {
                        this.ar.splice(_loc_2);
                        break;
                    }
                    _loc_2 = _loc_2 + 1;
                }
            }
            return;
        }// end function

        private function onFrame(event:Event) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = undefined;
            var _loc_4:* = this;
            var _loc_5:* = this.count + 1;
            _loc_4.count = _loc_5;
            if (this.count % 24 * 4 == 0)
            {
                this.isRun = !this.isRun;
                if (this.isRun)
                {
                }
                if (this.flag == 1)
                {
                    this.flag = 0;
                }
                else
                {
                    if (this.isRun)
                    {
                    }
                    if (this.flag == 0)
                    {
                        this.flag = 1;
                    }
                }
            }
            if (this.isRun)
            {
                if (this.flag == 0)
                {
                    _loc_2 = bodyMc.currentFrame + 1;
                    if (_loc_2 >= 20)
                    {
                        _loc_2 = 1;
                    }
                    if (_loc_2 > 10)
                    {
                        _loc_2 = 10;
                    }
                    bodyMc.gotoAndStop(_loc_2);
                }
                else if (this.flag == 1)
                {
                    _loc_2 = bodyMc.currentFrame + 1;
                    if (_loc_2 >= 20)
                    {
                        _loc_2 = 20;
                    }
                    bodyMc.gotoAndStop(_loc_2);
                }
            }
            if (bodyMc.currentFrame >= 9)
            {
            }
            if (bodyMc.currentFrame > 10)
            {
                while (this.ar.length > 0)
                {
                    
                    _loc_3 = this.ar.pop();
                    if (_loc_3 is Role)
                    {
                        Gfacade.instance().role.die();
                        continue;
                    }
                    if (_loc_3 is Role2)
                    {
                        Gfacade.instance().role2.die();
                        continue;
                    }
                    if (_loc_3 is Role3)
                    {
                        Gfacade.getInstance().role3.die();
                    }
                }
            }
            return;
        }// end function

    }
}
