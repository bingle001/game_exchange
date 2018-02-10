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

    public class Monster3 extends Goods
    {
        private var isRunRight:Boolean;
        private var isRun:Boolean;
        private var firstX:int;
        public var runSpeed:Number = 4;
        private var minx:int;
        private var maxx:int;
        private var standFlag:int;
        private var isStand:Boolean = false;
        public var standRate:int;
        public var runRate:int;
        private var curStatus:String = "";

        public function Monster3(param1:MovieClip, param2:Boolean = true)
        {
            param1.tx = param1.x;
            param1.ty = param1.y;
            super(param1, param2);
            bodyMc.rs = bodyMc.scaleX;
            this.type = Def.Animated;
            this.reportBeginContact = true;
            this.isRunRight = true;
            type = Def.Animated;
            this.runSpeed = 3;
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
            Gfacade.getInstance().role.linearVelocityY = -2;
            GameSound.instance.playSoundEffect("普怪死亡");
            this.removeEvent();
            isSensor = true;
            this.destroyShapes();
            this.addEventListener(Event.ENTER_FRAME, this.onDie);
            return;
        }// end function

        private function onDie(event:Event) : void
        {
            bodyMc.alpha = bodyMc.alpha - 0.05;
            if (bodyMc.alpha < 0.1)
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
                if (event.other.GetBody().GetUserData() is Role)
                {
                    Gfacade.getInstance().role.isMonster = true;
                    Gfacade.getInstance().role.die();
                }
                else if (event.other.GetBody().GetUserData() is Role2)
                {
                    Gfacade.getInstance().role2.isMonster = true;
                    Gfacade.getInstance().role2.die();
                }
            }
            return;
        }// end function

        private function onFrame(event:Event) : void
        {
            if (this.standFlag % (6 * this.standRate) == 0)
            {
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
            return;
        }// end function

    }
}
