package mediators.eles
{
    import facade.*;
    import flash.display.*;
    import flash.events.*;
    import mediators.roles.*;
    import wcks.Box2DAS.Common.*;
    import wcks.Box2DAS.Dynamics.*;

    public class JumpBoard2 extends MoveItem
    {
        private var isRunRight:Boolean;
        private var minx:int;
        private var maxx:int;

        public function JumpBoard2(param1:MovieClip, param2:Boolean = true)
        {
            bodyMc = param1;
            var _loc_3:* = bodyMc.name.split("_");
            this.minx = parseInt(_loc_3[1]);
            this.maxx = parseInt(_loc_3[2]);
            if (_loc_3[3] == "左")
            {
                bodyMc.scaleX = -bodyMc.scaleX;
                this.isRunRight = false;
            }
            else
            {
                this.isRunRight = true;
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
            this.box(bodyMc.width * 0.9, bodyMc.height * 0.8, new V2(0, 0));
            return;
        }// end function

        override public function addEvent() : void
        {
            this.startRun();
            return;
        }// end function

        override public function removeEvent() : void
        {
            this.stopRun();
            return;
        }// end function

        private function onEnd(event:ContactEvent) : void
        {
            if (event.other.GetBody().GetUserData().name == "role")
            {
                if (event.other.GetBody().GetUserData() is Role2)
                {
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
                }
            }
            return;
        }// end function

        public function startRun() : void
        {
            this.isRunRight = !this.isRunRight;
            Gfacade.instance().mainGame.addEventListener(Event.ENTER_FRAME, this.onMove);
            return;
        }// end function

        public function stopRun() : void
        {
            Gfacade.instance().mainGame.removeEventListener(Event.ENTER_FRAME, this.onMove);
            return;
        }// end function

        private function onMove(event:Event) : void
        {
            if (this.isRunRight)
            {
                if (x < this.maxx)
                {
                    x = x + runSpeed;
                }
                else
                {
                    x = this.maxx;
                    bodyMc.scaleX = -bodyMc.scaleX;
                    this.isRunRight = false;
                }
            }
            else if (x > this.minx)
            {
                x = x - runSpeed;
            }
            else
            {
                x = this.minx;
                bodyMc.scaleX = -bodyMc.scaleX;
                this.isRunRight = true;
            }
            return;
        }// end function

    }
}
