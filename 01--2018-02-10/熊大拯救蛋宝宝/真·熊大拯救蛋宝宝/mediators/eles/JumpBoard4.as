package mediators.eles
{
    import facade.*;
    import flash.display.*;
    import flash.events.*;
    import mediators.roles.*;
    import wcks.Box2DAS.Common.*;
    import wcks.Box2DAS.Dynamics.*;

    public class JumpBoard4 extends MoveItem
    {
        private var isRunUp:Boolean;
        private var miny:int;
        private var maxy:int;

        public function JumpBoard4(param1:MovieClip, param2:Boolean = true)
        {
            bodyMc = param1;
            var _loc_3:* = bodyMc.name.split("_");
            this.miny = parseInt(_loc_3[1]);
            this.maxy = parseInt(_loc_3[2]);
            if (_loc_3[3] == "下")
            {
                this.isRunUp = false;
            }
            else
            {
                this.isRunUp = true;
            }
            super(param1, param2);
            if (_loc_3[4])
            {
                this.runSpeed = parseInt(_loc_3[4]);
            }
            this.reportBeginContact = true;
            this.reportEndContact = true;
            this.friction = 9;
            return;
        }// end function

        override public function createShape() : void
        {
            this.box(bodyMc.width, bodyMc.height * 0.8, new V2(0, 0));
            return;
        }// end function

        override public function addEvent() : void
        {
            this.startRun();
            this.listenWhileVisible(this, ContactEvent.BEGIN_CONTACT, this.onBegin);
            this.listenWhileVisible(this, ContactEvent.END_CONTACT, this.onEnd);
            return;
        }// end function

        override public function removeEvent() : void
        {
            this.stopRun();
            this.removeEventListener(ContactEvent.BEGIN_CONTACT, this.onBegin);
            this.removeEventListener(ContactEvent.END_CONTACT, this.onEnd);
            return;
        }// end function

        private function onEnd(event:ContactEvent) : void
        {
            if (event.other.GetBody().GetUserData().name == "role")
            {
                if (event.other.GetBody().GetUserData() is Role2)
                {
                    Gfacade.instance().role2.onJumpBoard = false;
                }
                else if (event.other.GetBody().GetUserData() is Role)
                {
                    Gfacade.instance().role.onJumpBoard = false;
                }
                else
                {
                    Gfacade.instance().role3.onJumpBoard = false;
                }
            }
            return;
        }// end function

        private function onBegin(event:ContactEvent) : void
        {
            if (event.other.GetBody().GetUserData().name == "role")
            {
                if (event.other.GetBody().GetUserData() is Role2)
                {
                    Gfacade.instance().role2.onJumpBoard = true;
                    Gfacade.instance().role2.changeStatus(Role.STAND);
                }
                else if (event.other.GetBody().GetUserData() is Role)
                {
                    Gfacade.instance().role.onJumpBoard = true;
                    Gfacade.instance().role.changeStatus(Role.STAND);
                }
                else
                {
                    Gfacade.instance().role3.onJumpBoard = true;
                    Gfacade.instance().role3.changeStatus(Role.STAND);
                }
            }
            return;
        }// end function

        public function startRun() : void
        {
            this.isRunUp = !this.isRunUp;
            Gfacade.instance().mainGame.addEventListener(Event.ENTER_FRAME, this.onMove);
            return;
        }// end function

        public function stopRun() : void
        {
            Gfacade.instance().mainGame.removeEventListener(Event.ENTER_FRAME, this.onMove);
            return;
        }// end function

        public function onMove(event:Event) : void
        {
            if (this.isRunUp)
            {
                if (y > this.miny)
                {
                    y = y - runSpeed;
                }
                else
                {
                    y = this.miny;
                    this.isRunUp = false;
                }
            }
            else if (y < this.maxy)
            {
                y = y + runSpeed;
            }
            else
            {
                y = this.maxy;
                this.isRunUp = true;
            }
            return;
        }// end function

    }
}
