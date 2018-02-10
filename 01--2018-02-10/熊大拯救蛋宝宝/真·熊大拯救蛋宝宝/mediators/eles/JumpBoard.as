package mediators.eles
{
    import facade.*;
    import flash.display.*;
    import flash.events.*;
    import mediators.roles.*;
    import wcks.Box2DAS.Dynamics.*;

    public class JumpBoard extends MoveItem
    {
        private var isRunUp:Boolean;
        private var miny:int;
        private var maxy:int;

        public function JumpBoard(param1:MovieClip, param2:Boolean = true)
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
            return;
        }// end function

        override public function addEvent() : void
        {
            Gfacade.instance().mainGame.addEventListener(Event.ENTER_FRAME, this.onMove);
            this.listenWhileVisible(this, ContactEvent.BEGIN_CONTACT, this.onBegin);
            return;
        }// end function

        override public function removeEvent() : void
        {
            Gfacade.instance().mainGame.removeEventListener(Event.ENTER_FRAME, this.onMove);
            this.removeEventListener(ContactEvent.BEGIN_CONTACT, this.onBegin);
            return;
        }// end function

        override public function createShape() : void
        {
            this.box(bodyMc.width * 0.8, bodyMc.height * 0.7);
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
                else
                {
                    Gfacade.instance().role.onJumpBoard = false;
                }
            }
            return;
        }// end function

        private function onBegin(event:ContactEvent) : void
        {
            if (!(event.other.GetBody().GetUserData() is Role))
            {
            }
            if (!(event.other.GetBody().GetUserData() is Role2))
            {
            }
            if (event.other.GetBody().GetUserData() is Role3)
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
                    Gfacade.instance().role3.die();
                }
            }
            else
            {
                event.contact.SetEnabled(false);
            }
            return;
        }// end function

        private function onMove(event:Event) : void
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

        public function onStopJump(event:Event) : void
        {
            Gfacade.instance().mainGame.removeEventListener(Event.ENTER_FRAME, this.onMove);
            return;
        }// end function

        public function onPlayJump(event:Event) : void
        {
            this.isRunUp = !this.isRunUp;
            Gfacade.instance().mainGame.addEventListener(Event.ENTER_FRAME, this.onMove);
            return;
        }// end function

    }
}
