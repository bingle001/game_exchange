package mediators.eles
{
    import defs.*;
    import flash.display.*;
    import flash.geom.*;
    import wcks.misc.*;
    import wcks.wck.*;

    public class Wp extends BodyShape
    {
        public var bodyMc:MovieClip;

        public function Wp(param1:MovieClip, param2:Boolean = true)
        {
            this.bodyMc = param1;
            this.bodyMc.visible = param2;
            type = Def.Dynamic;
            this.friction = 2;
            this.density = 2;
            this.gravityMod = true;
            return;
        }// end function

        protected function init() : void
        {
            addChild(this.bodyMc);
            this.pos();
            return;
        }// end function

        protected function pos() : void
        {
            var _loc_1:* = null;
            _loc_1 = Util.localizePoint(Def.wck.world, this.bodyMc);
            x = _loc_1.x;
            y = _loc_1.y;
            this.bodyMc.x = 0;
            this.bodyMc.y = 0;
            return;
        }// end function

        override public function createBody() : void
        {
            this.init();
            super.createBody();
            createShapes();
            this.addEvent();
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

    }
}
