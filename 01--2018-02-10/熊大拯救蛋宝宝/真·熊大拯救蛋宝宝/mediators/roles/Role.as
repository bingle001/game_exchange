package mediators.roles
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

    public class Role extends People
    {
        public var onJumpBoard:Boolean;
        public var onDibiao2:Boolean;
        public var onBox:Boolean;
        public var caiBox:CaiBox;
        public var memo:Memo;
        private var _score:int;
        private var _lives:int = 3;
        public var b2Fix:b2Fixture;
        public var isMonster:Boolean = false;
        private var isDie:Boolean = false;
        public var isShoot:Boolean = false;
        private var _scoreMc:MovieClip;
        private var _jindu:MovieClip;
        public static var STAND:String = "站";
        public static var RUN:String = "走";
        public static var JUMP:String = "跳";
        public static var RUNFIGHT:String = "跑打";
        public static var STANDFIGHT:String = "站打";
        public static var BEHIT:String = "被打";
        public static var DIE:String = "死亡";
        public static var FIGHT:String = "攻击";
        public static var WUDI:String = "无敌";

        public function Role()
        {
            var _loc_1:* = Gfacade.instance().mainGame.getMovie("role1");
            bodyWidth = 32;
            bodyHeight = 90;
            speedNum = 2.5;
            this.reportBeginContact = true;
            this.reportEndContact = true;
            this.bullet = true;
            this.name = "role";
            this.inertiaScale = 0;
            this.bullet = true;
            this.lives = 3;
            this.score = 0;
            super(_loc_1);
            this.gravityMod = true;
            this.density = 1;
            this.autoSleep = false;
            this.addEvent();
            return;
        }// end function

        override public function createShapes() : void
        {
            if (!iscircle)
            {
                this.b2Fix = box(bodyWidth - 19, bodyHeight - 50, new V2(0, 0));
                this.b2Fix.m_friction = 0.3;
            }
            else
            {
                this.b2Fix = circle(12, new V2(0, -8));
            }
            type = Def.Dynamic;
            return;
        }// end function

        public function judgeWin() : Boolean
        {
            return this.score == Def.totalScore;
        }// end function

        override public function destroy() : void
        {
            super.destroy();
            this.removeEvent();
            this.isSensor = true;
            this.runDir = null;
            if (this._scoreMc)
            {
                Gfacade.instance().mainGame.stage.removeChild(this._scoreMc);
            }
            if (this._jindu)
            {
                Gfacade.instance().mainGame.stage.removeChild(this._jindu);
            }
            this._jindu = null;
            this._scoreMc = null;
            this.caiBox = null;
            bodyMc = null;
            this.memo = null;
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

        public function jumpHighter() : void
        {
            GameSound.instance.playSoundEffect("弹簧音效");
            this.changeStatus(Role.JUMP);
            this.linearVelocityY = Def.jumpHight * 1.2;
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
            changeStatus(Role.DIE);
            this.isCanChangeStatus = false;
            GameSound.instance.playSoundEffect("死亡音效");
            this.isDie = true;
            isSensor = false;
            TcMc.play2(bodyMc.getChildAt(0) as MovieClip);
            with ({})
            {
                {}.a = function () : void
            {
                TcMc.getInstance().removeEventListener(TcMc.PLAYOK2, a);
                bodyMc.visible = false;
                remove();
                return;
            }// end function
            ;
            }
            TcMc.getInstance().addEventListener(TcMc.PLAYOK2, function () : void
            {
                TcMc.getInstance().removeEventListener(TcMc.PLAYOK2, a);
                bodyMc.visible = false;
                remove();
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

        private function onPlayOk(event:Event) : void
        {
            TcMc.getInstance().removeEventListener(TcMc.PLAYOK2, this.onPlayOk);
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
            else if (event.other.GetUserData() is Role2)
            {
                event.contact.SetEnabled(false);
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
            return runDir[Keyboard2.D] == true;
        }// end function

        private function judgeLeft() : Boolean
        {
            return runDir[Keyboard2.A] == true;
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

        private function changeFocus() : void
        {
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
                case Keyboard2.W:
                {
                    if (this.judgeUp())
                    {
                        this.jump();
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function onKeyUp(event:KeyboardEvent) : void
        {
            runDir[event.keyCode] = false;
            if (event.keyCode == Keyboard2.S)
            {
                this.isCanChangeStatus = true;
                this.changeStatus(Role.STAND);
                this.destroyShapes();
                this.createShapes();
            }
            return;
        }// end function

        public function get score() : int
        {
            return this._score;
        }// end function

        public function set score(param1:int) : void
        {
            this._score = param1;
            return;
        }// end function

        public function get lives() : int
        {
            return this._lives;
        }// end function

        public function set lives(param1:int) : void
        {
            this._lives = param1;
            return;
        }// end function

    }
}
