package mediators.eles
{
    import defs.*;
    import facade.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class Paotong3 extends Wp
    {
        private var interval:int;
        public var curCount:int;

        public function Paotong3(param1:MovieClip, param2:Boolean = true)
        {
            super(param1, param2);
            type = Def.Static;
            Def.wck.addToWorld(this);
            var _loc_3:* = bodyMc.name;
            var _loc_4:* = _loc_3.split("_");
            this.interval = parseInt(_loc_4[1]);
            this.isSensor = true;
            return;
        }// end function

        override protected function init() : void
        {
            super.init();
            bodyMc.gotoAndStop(1);
            return;
        }// end function

        override public function createShapes() : void
        {
            this.box(bodyMc.width * 0.9, bodyMc.height * 0.9);
            return;
        }// end function

        override public function addEvent() : void
        {
            Gfacade.getInstance().mainGame.stage.addEventListener(Event.ENTER_FRAME, this.onFrame);
            return;
        }// end function

        override public function removeEvent() : void
        {
            Gfacade.getInstance().mainGame.stage.removeEventListener(Event.ENTER_FRAME, this.onFrame);
            return;
        }// end function

        public function onFrame(event:Event) : void
        {
            var _loc_2:* = this;
            var _loc_3:* = this.curCount + 1;
            _loc_2.curCount = _loc_3;
            if (this.curCount >= 24 * this.interval)
            {
                this.shoot();
            }
            return;
        }// end function

        public function shoot() : void
        {
            this.curCount = 0;
            var _loc_1:* = new Gfacade.getInstance().mainGame.getClass("子弹");
            new Bullet(_loc_1, new Point(x, y), bodyMc.rotation, true);
            return;
        }// end function

    }
}
