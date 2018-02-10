package mediators.eles.jing
{
    import defs.*;
    import facade.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import mediators.eles.*;
    import mediators.roles.*;
    import wcks.Box2DAS.Common.*;
    import wcks.Box2DAS.Dynamics.*;

    public class HaiShui extends Wp
    {
        private var timer:Timer;
        private var timeNum:int = 1200;
        private var timer2:Timer;
        private var timer3:Timer;
        private var numMc:MovieClip;
        private var numMc2:MovieClip;
        private var numMc3:MovieClip;

        public function HaiShui(param1:MovieClip, param2:Boolean = true)
        {
            super(param1, param2);
            type = Def.Static;
            this.reportBeginContact = true;
            this.reportEndContact = true;
            this.timer = new Timer(this.timeNum);
            this.timer2 = new Timer(this.timeNum);
            this.timer3 = new Timer(this.timeNum);
            this.numMc = new Gfacade.getInstance().mainGame.getClass("数字");
            this.numMc.gotoAndStop(1);
            this.numMc2 = new Gfacade.getInstance().mainGame.getClass("数字");
            this.numMc2.gotoAndStop(1);
            this.numMc3 = new Gfacade.getInstance().mainGame.getClass("数字");
            this.numMc3.gotoAndStop(1);
            Def.wck.addToWorld(this);
            return;
        }// end function

        override public function destroy() : void
        {
            super.destroy();
            this.timer = null;
            this.numMc = null;
            this.timer2 = null;
            this.numMc2 = null;
            this.timer3 = null;
            this.numMc3 = null;
            return;
        }// end function

        override public function addEvent() : void
        {
            this.addEventListener(ContactEvent.BEGIN_CONTACT, this.onBegin);
            this.addEventListener(ContactEvent.END_CONTACT, this.onEnd);
            this.timer.addEventListener(TimerEvent.TIMER, this.onTimer);
            this.timer2.addEventListener(TimerEvent.TIMER, this.onTimer2);
            this.timer3.addEventListener(TimerEvent.TIMER, this.onTimer3);
            return;
        }// end function

        override public function removeEvent() : void
        {
            this.removeEventListener(ContactEvent.BEGIN_CONTACT, this.onBegin);
            this.removeEventListener(ContactEvent.END_CONTACT, this.onEnd);
            if (this.timer)
            {
                this.timer.removeEventListener(TimerEvent.TIMER, this.onTimer);
            }
            if (this.timer2)
            {
                this.timer2.removeEventListener(TimerEvent.TIMER, this.onTimer2);
            }
            if (this.timer3)
            {
                this.timer3.removeEventListener(TimerEvent.TIMER, this.onTimer3);
            }
            return;
        }// end function

        private function onTimer(event:TimerEvent) : void
        {
            this.numMc.gotoAndStop((this.numMc.currentFrame + 1));
            if (this.numMc.currentFrame == this.numMc.totalFrames)
            {
                this.timer.stop();
                Gfacade.getInstance().role.die();
                if (this.numMc.parent)
                {
                    Gfacade.getInstance().mainGame.removeChild(this.numMc);
                }
            }
            return;
        }// end function

        private function onTimer2(event:TimerEvent) : void
        {
            this.numMc2.gotoAndStop((this.numMc2.currentFrame + 1));
            if (this.numMc2.currentFrame == this.numMc2.totalFrames)
            {
                this.timer2.stop();
                Gfacade.getInstance().role2.die();
                if (this.numMc2.parent)
                {
                    Gfacade.getInstance().mainGame.removeChild(this.numMc2);
                }
            }
            return;
        }// end function

        private function onTimer3(event:TimerEvent) : void
        {
            this.numMc3.gotoAndStop((this.numMc3.currentFrame + 1));
            if (this.numMc3.currentFrame == this.numMc3.totalFrames)
            {
                this.timer3.stop();
                Gfacade.getInstance().role3.die();
                if (this.numMc3.parent)
                {
                    Gfacade.getInstance().mainGame.removeChild(this.numMc3);
                }
            }
            return;
        }// end function

        private function onBegin(event:ContactEvent) : void
        {
            event.contact.SetEnabled(false);
            if (event.other.GetBody().GetUserData() is Role)
            {
                this.timer.start();
                Gfacade.getInstance().mainGame.addChild(this.numMc);
                this.numMc.x = Gfacade.getInstance().mainGame.stage.stageWidth * 0.5;
                this.numMc.y = Gfacade.getInstance().mainGame.stage.stageHeight * 0.5 - 100;
            }
            if (event.other.GetBody().GetUserData() is Role2)
            {
                this.timer2.start();
                Gfacade.getInstance().mainGame.addChild(this.numMc2);
                this.numMc2.x = Gfacade.getInstance().mainGame.stage.stageWidth * 0.5 - 50;
                this.numMc2.y = Gfacade.getInstance().mainGame.stage.stageHeight * 0.5 - 100;
            }
            if (event.other.GetBody().GetUserData() is Role3)
            {
                this.timer3.start();
                Gfacade.getInstance().mainGame.addChild(this.numMc3);
                this.numMc3.x = Gfacade.getInstance().mainGame.stage.stageWidth * 0.5 + 50;
                this.numMc3.y = Gfacade.getInstance().mainGame.stage.stageHeight * 0.5 - 100;
            }
            return;
        }// end function

        private function onEnd(event:ContactEvent) : void
        {
            if (event.other.GetBody().GetUserData() is Role)
            {
                this.timer.stop();
                if (this.numMc.parent)
                {
                    Gfacade.getInstance().mainGame.removeChild(this.numMc);
                }
                this.numMc.gotoAndStop(1);
            }
            if (event.other.GetBody().GetUserData() is Role2)
            {
                this.timer2.stop();
                if (this.numMc2.parent)
                {
                    Gfacade.getInstance().mainGame.removeChild(this.numMc2);
                }
                this.numMc2.gotoAndStop(1);
            }
            if (event.other.GetBody().GetUserData() is Role3)
            {
                this.timer3.stop();
                if (this.numMc3.parent)
                {
                    Gfacade.getInstance().mainGame.removeChild(this.numMc3);
                }
                this.numMc3.gotoAndStop(1);
            }
            return;
        }// end function

        override public function createShapes() : void
        {
            var _loc_1:* = bodyMc.getChildAt(0);
            this.box(_loc_1.width * bodyMc.scaleX, _loc_1.height * bodyMc.scaleY, new V2(0, 0));
            return;
        }// end function

    }
}
