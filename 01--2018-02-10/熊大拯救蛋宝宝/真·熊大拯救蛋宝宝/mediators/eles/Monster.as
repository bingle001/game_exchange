package mediators.eles
{
    import defs.*;
    import facade.*;
    import flash.display.*;
    import flash.events.*;
    import mediators.roles.*;
    import tcUtils.*;
    import tcUtils.sound.*;
    import wcks.Box2DAS.Dynamics.*;

    public class Monster extends Goods
    {
        private var isRunRight:Boolean;
        private var isRun:Boolean;
        public var runSpeed:Number = 2;
        private var minx:int;
        private var maxx:int;
        private var dc:int = 0;
        private var standFlag:int;
        private var isStand:Boolean = false;
        public var standRate:int;
        public var runRate:int;
        private var curStatus:String = "";

        public function Monster(param1:MovieClip, param2:Boolean = true)
        {
            param1.tx = param1.x;
            param1.ty = param1.y;
            super(param1, param2);
            bodyMc.rs = -bodyMc.scaleX;
            this.type = Def.Animated;
            this.reportBeginContact = true;
            this.isRunRight = true;
            this.isRun = true;
            this.changeStatus(Role.STAND);
            Def.wck.addToWorld(this);
            this.standRate = TcNum.getMinToMax(10, 20);
            this.runRate = TcNum.getMinToMax(3, 8);
            var _loc_3:* = bodyMc.name;
            var _loc_4:* = _loc_3.split("_");
            if (_loc_4[1])
            {
                this.minx = parseInt(_loc_4[1]);
            }
            if (_loc_4[2])
            {
                this.maxx = parseInt(_loc_4[2]);
            }
            isSensor = true;
            return;
        }// end function

        override public function addEvent() : void
        {
            this.listenWhileVisible(this, ContactEvent.BEGIN_CONTACT, this.onBegin);
            this.addEventListener(Event.ENTER_FRAME, this.onFrame);
            return;
        }// end function

        override public function removeEvent() : void
        {
            this.removeEventListener(ContactEvent.BEGIN_CONTACT, this.onBegin);
            this.removeEventListener(Event.ENTER_FRAME, this.onFrame);
            return;
        }// end function

        override public function die() : void
        {
            var onOk:Function;
            onOk = function (event:Event) : void
            {
                TcMc.getInstance().removeEventListener(TcMc.PLAYOK, onOk);
                remove();
                return;
            }// end function
            ;
            GameSound.instance.playSoundEffect("怪物死");
            this.removeEvent();
            isSensor = true;
            bodyMc.gotoAndStop("死");
            var mc:* = bodyMc.getChildAt(0) as MovieClip;
            TcMc.getInstance().addEventListener(TcMc.PLAYOK, onOk);
            TcMc.play(mc);
            return;
        }// end function

        private function onDie(event:Event) : void
        {
            var _loc_2:* = this;
            var _loc_3:* = this.dc + 1;
            _loc_2.dc = _loc_3;
            if (this.dc >= 10)
            {
                remove();
                this.removeEventListener(Event.ENTER_FRAME, this.onDie);
            }
            return;
        }// end function

        private function onBegin(event:ContactEvent) : void
        {
            if (event.other.GetBody().GetUserData().name == "role")
            {
                if (event.normal)
                {
                }
                if (event.normal.y < -0.8)
                {
                    this.die();
                }
                else if (event.other.GetBody().GetUserData() is Role)
                {
                    Gfacade.getInstance().role.isMonster = true;
                    Gfacade.getInstance().role.die();
                }
                else if (event.other.GetBody().GetUserData() is Role2)
                {
                    Gfacade.getInstance().role2.isMonster = true;
                    Gfacade.getInstance().role2.die();
                }
                else if (event.other.GetBody().GetUserData() is Role3)
                {
                    Gfacade.getInstance().role3.isMonster = true;
                    Gfacade.getInstance().role3.die();
                }
            }
            else if (event.other.GetBody().GetUserData() is Night)
            {
                this.die();
            }
            return;
        }// end function

        private function onFrame(event:Event) : void
        {
            var _loc_2:* = this;
            var _loc_3:* = this.standFlag + 1;
            _loc_2.standFlag = _loc_3;
            if (this.standFlag % (24 * this.standRate) == 0)
            {
            }
            if (this.isStand == false)
            {
                this.isStand = true;
                this.standFlag = 0;
                return;
            }
            if (this.isStand)
            {
                this.changeStatus(Role.STAND);
                if (this.standFlag % (24 * this.runRate) == 0)
                {
                    this.isStand = false;
                    this.standFlag = 0;
                }
                return;
            }
            if (this.standFlag % (24 * 5) == 0)
            {
                if (Math.abs(x - Gfacade.getInstance().role.x) >= 400)
                {
                }
            }
            if (Math.abs(x - Gfacade.getInstance().role.x) < 400)
            {
                this.standFlag = 0;
                this.attack();
            }
            this.changeStatus(Role.RUN);
            if (this.isRunRight)
            {
                this.bodyMc.scaleX = -bodyMc.rs;
                this.x = this.x + this.runSpeed;
                if (this.x >= this.maxx)
                {
                    this.isRunRight = false;
                }
            }
            if (!this.isRunRight)
            {
                this.bodyMc.scaleX = bodyMc.rs;
                this.x = this.x + (-this.runSpeed);
                if (this.x <= this.minx)
                {
                    this.isRunRight = true;
                }
            }
            return;
        }// end function

        public function attack() : void
        {
            return;
        }// end function

        private function changeStatus(param1:String) : void
        {
            if (this.curStatus == param1)
            {
                return;
            }
            this.curStatus = param1;
            bodyMc.gotoAndStop(this.curStatus);
            return;
        }// end function

    }
}
