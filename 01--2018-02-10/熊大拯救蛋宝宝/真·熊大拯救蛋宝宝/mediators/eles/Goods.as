package mediators.eles
{
    import defs.*;
    import flash.display.*;
    import flash.geom.*;
    import wcks.misc.*;
    import wcks.wck.*;

    public class Goods extends BodyShape
    {
        public var bodyMc:MovieClip;
        private var _hp:int;
        private var maxHp:int = -1;
        private var hitNum:uint;
        protected var score:int;

        public function Goods(param1:MovieClip, param2:Boolean = true)
        {
            this.bodyMc = param1;
            this.pos();
            this.hitNum = 0;
            this.bodyMc.visible = param2;
            Def.wck.addToWorld(this);
            this.addEvent();
            return;
        }// end function

        public function pos() : void
        {
            var _loc_1:* = Util.localizePoint(Def.wck.world, this.bodyMc);
            x = _loc_1.x;
            y = _loc_1.y;
            this.bodyMc.x = 0;
            this.bodyMc.y = 0;
            return;
        }// end function

        public function init() : void
        {
            addChild(this.bodyMc);
            return;
        }// end function

        public function addEvent() : void
        {
            return;
        }// end function

        public function removeEvent() : void
        {
            return;
        }// end function

        override public function createBody() : void
        {
            this.init();
            super.createBody();
            this.createShape();
            this.addEvent();
            return;
        }// end function

        override public function remove(... args) : void
        {
            this.removeEvent();
            super.remove(args);
            return;
        }// end function

        public function onHit(param1:int = -1) : void
        {
            var _loc_2:* = this;
            var _loc_3:* = this.hitNum + 1;
            _loc_2.hitNum = _loc_3;
            return;
        }// end function

        public function die() : void
        {
            return;
        }// end function

        public function createShape() : void
        {
            return;
        }// end function

        public function get hp() : int
        {
            return this._hp;
        }// end function

        public function set hp(param1:int) : void
        {
            this._hp = param1;
            if (this.maxHp == -1)
            {
                this.maxHp = param1;
            }
            return;
        }// end function

    }
}
