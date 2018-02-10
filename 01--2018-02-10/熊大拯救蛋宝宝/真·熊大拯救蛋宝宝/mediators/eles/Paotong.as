package mediators.eles
{
    import defs.*;
    import facade.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import tcUtils.*;

    public class Paotong extends Wp
    {
        private var interval:int;
        public var speed:int = -1;
        public var curCount:int;

        public function Paotong(param1:MovieClip, param2:Boolean = true)
        {
            super(param1, param2);
            type = Def.Static;
            Def.wck.addToWorld(this);
            var _loc_3:* = bodyMc.name;
            var _loc_4:* = _loc_3.split("_");
            this.interval = parseInt(_loc_4[1]);
            if (_loc_4[2])
            {
                this.speed = parseInt(_loc_4[2]);
            }
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
            this.box(bodyMc.width, bodyMc.height);
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

        private function onFrame(event:Event) : void
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
            var onPlayOk:Function;
            onPlayOk = function (event:Event) : void
            {
                TcMc.getInstance().removeEventListener(TcMc.PLAYOK, onPlayOk);
                bodyMc.gotoAndStop(1);
                return;
            }// end function
            ;
            this.curCount = 0;
            TcMc.getInstance().addEventListener(TcMc.PLAYOK, onPlayOk);
            TcMc.play(bodyMc);
            var mc:* = new Gfacade.getInstance().mainGame.getClass("箭左");
            new Bullet2(mc, new Point(x, y), this.speed);
            return;
        }// end function

    }
}
