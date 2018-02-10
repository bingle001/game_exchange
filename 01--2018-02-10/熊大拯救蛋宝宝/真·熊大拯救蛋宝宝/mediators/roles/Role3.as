﻿package mediators.roles
{
    import defs.*;
    import facade.*;
    import flash.display.*;
    import flash.events.*;
    import mediators.eles.*;
    import tcUtils.*;
    import tcUtils.sound.*;
    import wcks.Box2DAS.Common.*;
    import wcks.Box2DAS.Dynamics.*;

    public class Role3 extends People
    {
        public var onJumpBoard:Boolean;
        public var onDibiao2:Boolean;
        public var onBox:Boolean;
        public var caiBox:CaiBox;
        public var head:Night;
        public var isMonster:Boolean = false;
        private var isDie:Boolean = false;
        public var isShoot:Boolean = false;
        private var isShooting:Boolean = false;
        private var isHead:Boolean = true;
        public static var STAND:String = "站";
        public static var RUN:String = "走";
        public static var JUMP:String = "跳";
        public static var RUNFIGHT:String = "跑打";
        public static var STANDFIGHT:String = "站打";
        public static var BEHIT:String = "被打";
        public static var DIE:String = "死";
        public static var WUDI:String = "无敌";

        public function Role3()
        {
            var _loc_1:* = Gfacade.instance().mainGame.getMovie("role3");
            bodyWidth = 26;
            bodyHeight = 70;
            speedNum = 2.5;
            this.reportBeginContact = true;
            this.reportEndContact = true;
            this.name = "role";
            this.inertiaScale = 0;
            this.friction = 0.3;
            this.bullet = true;
            super(_loc_1);
            this.gravityMod = true;
            this.density = 1;
            this.friction = 0.3;
            this.addEvent();
            return;
        }// end function

        override public function createShapes() : void
        {
            var _loc_1:* = null;
            if (!iscircle)
            {
                _loc_1 = box(bodyWidth - 15, bodyHeight - 28, new V2(0, 0));
                _loc_1.m_friction = 0.3;
            }
            else
            {
                _loc_1 = circle(12, new V2(0, -8));
            }
            return;
        }// end function

        override public function destroy() : void
        {
            super.destroy();
            this.removeEvent();
            this.isSensor = true;
            this.runDir = null;
            this.caiBox = null;
            bodyMc = null;
            return;
        }// end function

        override public function addEvent() : void
        {
            Gfacade.instance().mainGame.stage.addEventListener(Event.ENTER_FRAME, this.onFrame);
            Gfacade.instance().mainGame.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
            Gfacade.instance().mainGame.stage.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
            this.listenWhileVisible(this, ContactEvent.BEGIN_CONTACT, this.onBegin);
            return;
        }// end function

        override public function removeEvent() : void
        {
            Gfacade.instance().mainGame.stage.removeEventListener(Event.ENTER_FRAME, this.onFrame);
            Gfacade.instance().mainGame.stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
            Gfacade.instance().mainGame.stage.removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
            this.removeEventListener(ContactEvent.BEGIN_CONTACT, this.onBegin);
            TcMc.getInstance().removeEventListener(TcMc.PLAYOK2, this.onPlayOk);
            if (this.isDie)
            {
                this.changeStatus(Role.BEHIT);
            }
            else
            {
                this.changeStatus(Role.STAND);
            }
            return;
        }// end function

        override public function walkRight() : void
        {
            this.changeBodyScale(1);
            if (this.curStatus == Role.JUMP)
            {
            }
            if (this.judgeUp())
            {
                this.changeStatus(Role.RUN);
            }
            this.linearVelocityX = this.speedNum;
            if (this.caiBox)
            {
                this.caiBox.run(speedNum);
            }
            return;
        }// end function

        override public function walkLeft() : void
        {
            this.changeBodyScale(-1);
            if (this.curStatus == Role.JUMP)
            {
            }
            if (this.judgeUp())
            {
                this.changeStatus(Role.RUN);
            }
            this.linearVelocityX = -this.speedNum;
            if (this.caiBox)
            {
                this.caiBox.run(-this.speedNum);
            }
            return;
        }// end function

        override public function jump() : void
        {
            GameSound.instance.playSoundEffect("跳音效");
            this.changeStatus(Role.JUMP);
            this.linearVelocityY = Def.jumpHight;
            return;
        }// end function

        override public function stopRun() : void
        {
            super.stopRun();
            if (this.caiBox)
            {
                this.caiBox.stopRun();
            }
            return;
        }// end function

        override public function die() : void
        {
            this.removeEvent();
            this.stopRun();
            GameSound.instance.playSoundEffect("主角死");
            if (this.isDie)
            {
                return;
            }
            this.changeStatus(Role.DIE);
            this.isCanChangeStatus = false;
            GameSound.instance.playSoundEffect("死亡音效");
            this.isDie = true;
            TcMc.play2(bodyMc.getChildAt(0) as MovieClip);
            with ({})
            {
                {}.a = function () : void
            {
                TcMc.getInstance().removeEventListener(TcMc.PLAYOK2, a);
                bodyMc.visible = false;
                isSensor = true;
                return;
            }// end function
            ;
            }
            TcMc.getInstance().addEventListener(TcMc.PLAYOK2, function () : void
            {
                TcMc.getInstance().removeEventListener(TcMc.PLAYOK2, a);
                bodyMc.visible = false;
                isSensor = true;
                return;
            }// end function
            );
            var _loc_2:* = Gfacade.getInstance();
            var _loc_3:* = Gfacade.getInstance().roleDieNum + 1;
            _loc_2.roleDieNum = _loc_3;
            if (Gfacade.getInstance().roleDieNum == Gfacade.getInstance().roleNum)
            {
                EventManager.getInstance().eDispatchEvent(new Event(Def.FAIL));
            }
            return;
        }// end function

        public function jumpHighter() : void
        {
            GameSound.instance.playSoundEffect("弹簧音效");
            this.changeStatus(Role.JUMP);
            this.linearVelocityY = Def.jumpHight * 1.2;
            return;
        }// end function

        private function onPlayOk(event:Event) : void
        {
            var fh:FuHuo;
            var frame1:Function;
            var f:FuHuo;
            var e:* = event;
            frame1 = function (event:Event) : void
            {
                removeEventListener(Event.ENTER_FRAME, frame1);
                type = Def.Dynamic;
                linearVelocityX = 0;
                linearVelocityY = 0;
                addEvent();
                isCanChangeStatus = true;
                curStatus = "";
                changeStatus(Role.STAND);
                return;
            }// end function
            ;
            TcMc.getInstance().removeEventListener(TcMc.PLAYOK2, this.onPlayOk);
            var preLong:Number;
            var i:int;
            while (i < Gfacade.getInstance().gameMed.fuhuoAr.length)
            {
                
                f = Gfacade.getInstance().gameMed.fuhuoAr[i];
                if (preLong < 0)
                {
                    fh = f;
                    preLong = Math.abs(x - f.x);
                }
                else if (Math.abs(x - f.x) < preLong)
                {
                    preLong = Math.abs(x - f.x);
                    fh = f;
                }
                i = (i + 1);
            }
            type = Def.Animated;
            x = fh.x;
            y = fh.y;
            clearRunDir();
            addEventListener(Event.ENTER_FRAME, frame1);
            return;
        }// end function

        private function onBegin(event:ContactEvent) : void
        {
            if (this.judgeDie())
            {
                this.die();
            }
            else if (event.other.GetUserData() is Night)
            {
            }
            return;
        }// end function

        private function judgeDie() : Boolean
        {
            return false;
        }// end function

        private function judgeUp() : Boolean
        {
            if (Math.abs(this.linearVelocityY) >= 0.03)
            {
            }
            if (!this.onJumpBoard)
            {
            }
            return this.onDibiao2;
        }// end function

        private function judgeRight() : Boolean
        {
            return runDir[Keyboard2.L] == true;
        }// end function

        private function judgeLeft() : Boolean
        {
            return runDir[Keyboard2.J] == true;
        }// end function

        private function onFrame(event:Event) : void
        {
            if (!this.judgeUp())
            {
                this.changeStatus(Role.JUMP);
            }
            if (this.judgeRight())
            {
                this.walkRight();
            }
            else if (this.judgeLeft())
            {
                this.walkLeft();
            }
            else
            {
                if (this.curStatus != Role.RUNFIGHT)
                {
                }
                if (this.curStatus != Role.STANDFIGHT)
                {
                    linearVelocityX = 0;
                    if (this.judgeUp())
                    {
                        this.stopRun();
                    }
                }
            }
            if (this.isDie)
            {
                this.changeStatus(Role.BEHIT);
            }
            return;
        }// end function

        private function onKeyDown(event:KeyboardEvent) : void
        {
            if (runDir[event.keyCode] == true)
            {
                return;
            }
            runDir[event.keyCode] = true;
            switch(event.keyCode)
            {
                case Keyboard2.I:
                {
                    if (this.judgeUp())
                    {
                        this.jump();
                    }
                    break;
                }
                case Keyboard2.K:
                {
                    this.onShoot();
                    break;
                }
                case Keyboard2.Spacebar:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override public function changeStatus(param1:String) : Boolean
        {
            if (curStatus != param1)
            {
            }
            if (bodyMc)
            {
            }
            if (isCanChangeStatus == false)
            {
                return false;
            }
            if (iscircle)
            {
                if (param1.indexOf("球") == -1)
                {
                    curStatus = "球" + param1;
                }
            }
            else
            {
                curStatus = param1;
            }
            oldStatus = curStatus;
            bodyMc.gotoAndStop(curStatus);
            return true;
        }// end function

        private function onShoot() : void
        {
            if (this.curStatus != Role.BEHIT)
            {
            }
            if (this.curStatus != Role.DIE)
            {
            }
            if (this.curStatus != Role.RUNFIGHT)
            {
            }
            if (this.curStatus != Role.STANDFIGHT)
            {
            }
            if (this.curStatus == Role.JUMP)
            {
                return;
            }
            this.iscircle = !iscircle;
            this.isCanChangeStatus = false;
            this.destroyShapes();
            this.createShapes();
            curStatus = "";
            this.changeStatus(Role.STAND);
            return;
        }// end function

        private function onKeyUp(event:KeyboardEvent) : void
        {
            runDir[event.keyCode] = false;
            if (event.keyCode == Keyboard2.K)
            {
                this.isCanChangeStatus = true;
                this.changeStatus(Role.STAND);
                this.destroyShapes();
                this.createShapes();
            }
            return;
        }// end function

    }
}
