package mediators.eles
{
    import defs.*;
    import flash.display.*;
    import tcUtils.*;
    import wcks.Box2DAS.Common.*;

    public class Organ extends Wp2
    {
        private var i:uint;

        public function Organ(param1:MovieClip, param2:Boolean = true)
        {
            super(param1, param2);
            return;
        }// end function

        public function open() : void
        {
            TcMc.play(bodyMc.mc);
            this.isSensor = true;
            return;
        }// end function

        public function close() : void
        {
            TcMc.playBack(bodyMc.mc);
            this.isSensor = false;
            return;
        }// end function

        override public function createShapes() : void
        {
            this.box(19, 70, new V2(0, 0), bodyMc.rotation);
            return;
        }// end function

        override protected function initRice() : void
        {
            type = Def.Static;
            this.reportBeginContact = true;
            return;
        }// end function

    }
}
